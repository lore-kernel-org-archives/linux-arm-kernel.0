From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 19 Mar 2015 14:33:32 +0300
Subject: [PATCH 5/5] ARM: dts: brcmstb: add nodes for SATA controller
 and PHY
In-Reply-To: <1426728222-8197-5-git-send-email-computersforpeace@gmail.com>
References: <1426728222-8197-1-git-send-email-computersforpeace@gmail.com>
 <1426728222-8197-5-git-send-email-computersforpeace@gmail.com>
Message-ID: <550AB40C.8060607@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 3/19/2015 4:23 AM, Brian Norris wrote:

> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> ---
> Light dependency on:
>    http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/331921.html
> for the surrounding text.

>   arch/arm/boot/dts/bcm7445.dtsi | 36 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)

> diff --git a/arch/arm/boot/dts/bcm7445.dtsi b/arch/arm/boot/dts/bcm7445.dtsi
> index 9eaeac8dce1b..7a7c4d8c2afe 100644
> --- a/arch/arm/boot/dts/bcm7445.dtsi
> +++ b/arch/arm/boot/dts/bcm7445.dtsi
> @@ -108,6 +108,42 @@
>   			brcm,int-map-mask = <0x25c>, <0x7000000>;
>   			brcm,int-fwd-mask = <0x70000>;
>   		};
> +
> +		sata at f045a000 {

    Hm, why the <unit-address> part of the name doesn't correspond to the 
"reg" prop?

> +			compatible = "brcm,bcm7445-ahci", "brcm,sata3-ahci";
> +			reg-names = "ahci", "top-ctrl";
> +			reg = <0x45a000 0xa9c>, <0x458040 0x24>;
> +			interrupts = <GIC_SPI 30 0>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
[...]
> +		sata_phy: sata-phy at f0458100 {

    Same question here...

> +			compatible = "brcm,bcm7445-sata-phy", "brcm,phy-sata3";
> +			reg = <0x458100 0x1e00>, <0x45804c 0x10>;
[...]

WBR, Sergei
