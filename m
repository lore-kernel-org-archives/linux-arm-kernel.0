From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 9 Dec 2010 22:11:40 +0100
Subject: [PATCH v3 09/15] ARM: mxs: Add clock support
In-Reply-To: <1291907569-8925-9-git-send-email-shawn.guo@freescale.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291907569-8925-9-git-send-email-shawn.guo@freescale.com>
Message-ID: <20101209211140.GC17441@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

On Thu, Dec 09, 2010 at 11:12:44PM +0800, Shawn Guo wrote:
> diff --git a/arch/arm/mach-mxs/clock-mx23.c b/arch/arm/mach-mxs/clock-mx23.c
> new file mode 100644
> index 0000000..b2923da
> --- /dev/null
> +++ b/arch/arm/mach-mxs/clock-mx23.c
> @@ -0,0 +1,526 @@
> +[...]
> +static int cpu_clk_set_rate(struct clk *clk, unsigned long rate)
> +{
> +[...]
> +		rate <<= PARENT_RATE_SHIFT;
> +		parent_rate <<= PARENT_RATE_SHIFT;
You're making the problem worse here.  You need to shift right!

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
