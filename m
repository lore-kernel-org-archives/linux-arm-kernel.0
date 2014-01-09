From: dinguyen@altera.com (Dinh Nguyen)
Date: Thu, 9 Jan 2014 10:24:22 -0600
Subject: [PATCH] ARM: socfpga: dts: add pl330 clock
In-Reply-To: <1387449054-27115-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1387449054-27115-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1389284662.13556.26.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-12-19 at 11:30 +0100, Steffen Trumtrar wrote:
> The pl330 dmac won't be added to the list of amba devices, as it doesn't have
> a clock entry.
> Add the clock.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
> Rebased to
> 	git://git.rocketboards.org/linux-socfpga-next.git next-dt
> 
>  arch/arm/boot/dts/socfpga.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> index 634950f..8920371 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -79,6 +79,8 @@
>  				#dma-cells = <1>;
>  				#dma-channels = <8>;
>  				#dma-requests = <32>;
> +				clocks = <&l4_main_clk>;
> +				clock-names = "apb_pclk";
>  			};
>  		};
>  

Applied to next-dt.

Thanks,
Dinh
