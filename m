From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 26 May 2011 14:00:55 +0200
Subject: [PATCH] ARM: mxs_defconfig: Remove locking debug config options
In-Reply-To: <1306391203-29338-1-git-send-email-shawn.guo@linaro.org>
References: <20110525141624.GE2408@S2100-06.ap.freescale.net>
	<1306391203-29338-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110526120055.GB14257@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 26, 2011 at 02:26:43PM +0800, Shawn Guo wrote:
> The amba-pl011 driver assumes that clk_enable/disable are atomic, but
> currently it's not the case on mxs.  There are lock debug warnings
> seen when serial console does power management.
> 
> The patch removes locking debug config options to get rid of the
> warnings.  They can be turned on later when new clock framework sorts
> the locking thing out.
I'd keep the debug messages enabled. Just because you disable them the
problem isn't gone. This way it's a bit more certain that it gets fixed
...

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
