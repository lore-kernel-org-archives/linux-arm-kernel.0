From: dinguyen@altera.com (Dinh Nguyen)
Date: Wed, 2 Apr 2014 12:33:58 -0500
Subject: [PATCH v2 1/6] ARM: socfpga: dts: fix pdma interrupt
In-Reply-To: <1396422700-3962-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1396422700-3962-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1396460038.17141.1.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steffen,

On Wed, 2014-04-02 at 09:11 +0200, Steffen Trumtrar wrote:
> The first interrupt is not at 180 but 104. Fix it.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  arch/arm/boot/dts/socfpga.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> index 537f1a5..0c3344f 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -75,7 +75,7 @@
>  			pdma: pdma at ffe01000 {
>  				compatible = "arm,pl330", "arm,primecell";
>  				reg = <0xffe01000 0x1000>;
> -				interrupts = <0 180 4>;
> +				interrupts = <0 104 4>;
>  				#dma-cells = <1>;
>  				#dma-channels = <8>;
>  				#dma-requests = <32>;

I applied this series to rocketboards  linux-socfpga-next/next-dt.

Thanks,
Dinh
