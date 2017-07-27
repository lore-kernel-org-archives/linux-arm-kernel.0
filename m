From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 27 Jul 2017 16:39:39 +0200
Subject: [PATCH v4 9/9] arm: dts: mt7623: add dts file for Bananapi R2
 (BPI-R2) board
In-Reply-To: <5cc5489b38fc2723c30c8cfe0d4353f967d100f3.1495683769.git.sean.wang@mediatek.com>
References: <cover.1495683769.git.sean.wang@mediatek.com>
 <5cc5489b38fc2723c30c8cfe0d4353f967d100f3.1495683769.git.sean.wang@mediatek.com>
Message-ID: <805ad5c4-db47-ef10-565d-b63e33a84bdf@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/25/2017 06:02 AM, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Add support for the Bananapi R2 (BPI-R2) development board from
> BIPAI KEJI. Detailed hardware information for BPI-R2 which could be
> found on http://www.banana-pi.org/r2.html
> 
> The patch currently only adds Mediatek GMAC, MT7530 Switch, the crypto
> engine, USB, IR, I2S, I2C, UART, SPI, PWM, GPIO keys, GPIO LEDs and
> PMIC LEDs. As to the other missing hardware and peripherals, they would
> be added and integrated continuously.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>   Documentation/devicetree/bindings/arm/mediatek.txt |   2 +
>   arch/arm/boot/dts/Makefile                         |   1 +
>   arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts      | 440 +++++++++++++++++++++
>   3 files changed, 443 insertions(+)
>   create mode 100644 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> 
[...]
> diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> new file mode 100644
> index 0000000..72c7984
> --- /dev/null
> +++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
[...]
> +
> +&eth {
> +	status = "okay";
> +	gmac0: mac at 0 {
> +		compatible = "mediatek,eth-mac";
> +		reg = <0>;
> +		phy-mode = "trgmii";
> +		fixed-link {
> +			speed = <1000>;
> +			full-duplex;
> +			pause;
> +		};
> +	};
> +
> +	mdio: mdio-bus {
> +		switch at 0 {
> +			compatible = "mediatek,mt7530";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0>;

What is this reg needed for? I can't find it neither in the code nor in the 
bindings (mt7530 and general dsa bindings). Actually it throws a warning when 
compiling:
arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dtb: Warning (reg_format): "reg" 
property in /ethernet at 1b100000/mdio-bus/switch at 0 has invalid length (4 bytes) 
(#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dtb: Warning 
(avoid_default_addr_size): Relying on default #address-cells value for 
/ethernet at 1b100000/mdio-bus/switch at 0
arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dtb: Warning 
(avoid_default_addr_size): Relying on default #size-cells value for 
/ethernet at 1b100000/mdio-bus/switch at 0

Regards,
Matthias
