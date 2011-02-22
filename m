From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 22 Feb 2011 09:09:29 +0100
Subject: [PATCH v3 2/2] ARM: mxs: add dma device
In-Reply-To: <1298284306-14710-3-git-send-email-shawn.guo@freescale.com>
References: <1298284306-14710-1-git-send-email-shawn.guo@freescale.com>
	<1298284306-14710-3-git-send-email-shawn.guo@freescale.com>
Message-ID: <20110222080928.GS22310@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 21, 2011 at 06:31:46PM +0800, Shawn Guo wrote:
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
>  arch/arm/mach-mxs/clock-mx23.c           |    3 +-
>  arch/arm/mach-mxs/clock-mx28.c           |    4 +-
>  arch/arm/mach-mxs/devices/Makefile       |    1 +
>  arch/arm/mach-mxs/devices/platform-dma.c |  101 ++++++++++++++++++++++++++++++
>  4 files changed, 106 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm/mach-mxs/devices/platform-dma.c
> 
> diff --git a/arch/arm/mach-mxs/clock-mx23.c b/arch/arm/mach-mxs/clock-mx23.c
> index b1a362e..350b28c 100644
> --- a/arch/arm/mach-mxs/clock-mx23.c
> +++ b/arch/arm/mach-mxs/clock-mx23.c
> @@ -443,7 +443,8 @@ static struct clk_lookup lookups[] = {
>  	/* for amba-pl011 driver */
>  	_REGISTER_CLOCK("duart", NULL, uart_clk)
>  	_REGISTER_CLOCK("rtc", NULL, rtc_clk)
> -	_REGISTER_CLOCK(NULL, "hclk", hbus_clk)
> +	_REGISTER_CLOCK("mxs-dma-apbh", NULL, hbus_clk)
> +	_REGISTER_CLOCK("mxs-dma-apbx", NULL, xbus_clk)
>  	_REGISTER_CLOCK(NULL, "usb", usb_clk)
>  	_REGISTER_CLOCK(NULL, "audio", audio_clk)
>  	_REGISTER_CLOCK(NULL, "pwm", pwm_clk)
> diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
> index c9d7951..a3b4787 100644
> --- a/arch/arm/mach-mxs/clock-mx28.c
> +++ b/arch/arm/mach-mxs/clock-mx28.c
> @@ -617,8 +617,8 @@ static struct clk_lookup lookups[] = {
>  	_REGISTER_CLOCK("fec.0", NULL, fec_clk)
>  	_REGISTER_CLOCK("rtc", NULL, rtc_clk)
>  	_REGISTER_CLOCK("pll2", NULL, pll2_clk)
> -	_REGISTER_CLOCK(NULL, "hclk", hbus_clk)
> -	_REGISTER_CLOCK(NULL, "xclk", xbus_clk)
> +	_REGISTER_CLOCK("mxs-dma-apbh", NULL, hbus_clk)
> +	_REGISTER_CLOCK("mxs-dma-apbx", NULL, xbus_clk)
>  	_REGISTER_CLOCK("flexcan.0", NULL, can0_clk)
>  	_REGISTER_CLOCK("flexcan.1", NULL, can1_clk)
>  	_REGISTER_CLOCK(NULL, "usb0", usb0_clk)
> diff --git a/arch/arm/mach-mxs/devices/Makefile b/arch/arm/mach-mxs/devices/Makefile
> index a8dc8d5..ca7acc4 100644
> --- a/arch/arm/mach-mxs/devices/Makefile
> +++ b/arch/arm/mach-mxs/devices/Makefile
> @@ -1,4 +1,5 @@
>  obj-$(CONFIG_MXS_HAVE_AMBA_DUART) += amba-duart.o
>  obj-$(CONFIG_MXS_HAVE_PLATFORM_AUART) += platform-auart.o
> +obj-y += platform-dma.o
>  obj-$(CONFIG_MXS_HAVE_PLATFORM_FEC) += platform-fec.o
>  obj-$(CONFIG_MXS_HAVE_PLATFORM_FLEXCAN) += platform-flexcan.o
> diff --git a/arch/arm/mach-mxs/devices/platform-dma.c b/arch/arm/mach-mxs/devices/platform-dma.c
> new file mode 100644
> index 0000000..ee3220e
> --- /dev/null
> +++ b/arch/arm/mach-mxs/devices/platform-dma.c
I'd prefer to have that called platform-mxs-dma.c to match the driver
name.  (At least that's what you use for the data structs.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
