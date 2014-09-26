From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 26 Sep 2014 21:25:12 +0400
Subject: [PATCH v5 09/10] ARM: dts: berlin: add the Ethernet node
In-Reply-To: <1411742036-23520-10-git-send-email-antoine.tenart@free-electrons.com>
References: <1411742036-23520-1-git-send-email-antoine.tenart@free-electrons.com>
 <1411742036-23520-10-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <5425A178.4050501@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 09/26/2014 06:33 PM, Antoine Tenart wrote:

> This patch adds the Ethernet node, enabling the network unit on Berlin
> BG2Q SoCs.

> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   arch/arm/boot/dts/berlin2q.dtsi | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)

> diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
> index 902eddb19cd8..d442b22fd1ea 100644
> --- a/arch/arm/boot/dts/berlin2q.dtsi
> +++ b/arch/arm/boot/dts/berlin2q.dtsi
> @@ -114,6 +114,23 @@
>   			#interrupt-cells = <3>;
>   		};
>
> +		eth0: ethernet at b90000 {
> +			compatible = "marvell,pxa168-eth";
> +			reg = <0xb90000 0x10000>;
> +			clocks = <&chip CLKID_GETH0>;
> +			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
> +			/* set by bootloader */
> +			local-mac-address = [00 00 00 00 00 00];
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			phy-handle = <&ethphy0>;
> +			status = "disabled";
> +
> +			ethphy0: ethernet-phy at 0 {
> +				reg = <0>;
> +			};
> +		};
> +

    Hm, is the PHY internal to the Ethernet controller?

WBR, Sergei
