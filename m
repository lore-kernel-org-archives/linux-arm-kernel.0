From: ipaton0@gmail.com (Iain Paton)
Date: Sun, 24 Aug 2014 10:44:54 +0100
Subject: [PATCH 1/6] ARM: dts: microsom-ar8035: MDIO pad must be set open
 drain
In-Reply-To: <E1XL7M1-0002yD-K3@rmk-PC.arm.linux.org.uk>
References: <20140823091058.GO30401@n2100.arm.linux.org.uk>
 <E1XL7M1-0002yD-K3@rmk-PC.arm.linux.org.uk>
Message-ID: <53F9B416.5030907@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/08/14 10:11, Russell King wrote:
> From: Rabeeh Khoury <rabeeh@solid-run.com>
> To: Shawn Guo <shawn.guo@freescale.com>
> 
> MDIO pad must be set open drain.
> 
> Signed-off-by: Rabeeh Khoury <rabeeh@solid-run.com>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi b/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi
> index d16066608e21..db9f45b2c573 100644
> --- a/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi
> @@ -17,7 +17,7 @@
>  	enet {
>  		pinctrl_microsom_enet_ar8035: microsom-enet-ar8035 {
>  			fsl,pins = <
> -				MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b0b0
> +				MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b8b0
>  				MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
>  				/* AR8035 reset */
>  				MX6QDL_PAD_KEY_ROW4__GPIO4_IO15		0x130b0
> 

Can you elaborate some more on the reasons for this?  

I'd like to understand if it's something specific to the hardware on that 
board, or if other i.MX6 boards using the ar8035 are doing it wrong as well.

The datasheet strongly suggests this is the correct thing to do as MDIO 
should electrically be open drain. However that suggests many more instances 
of this incorrect configuration exist which also need changed, and not just 
for ar8035.

While I'm reluctant to attribute something like this to the fec/interrupt 
problems some people are seeing, I'd also like to be able to rule it out.
