From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 26 Sep 2016 08:23:18 +0200
Subject: [PATCH v2 3/4] clk: imx31: fix rewritten input argument of
 mx31_clocks_init()
In-Reply-To: <1474848223-19728-4-git-send-email-vz@mleia.com>
References: <1474848223-19728-1-git-send-email-vz@mleia.com>
 <1474848223-19728-4-git-send-email-vz@mleia.com>
Message-ID: <20160926062318.c6tipjjktvmxpwed@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Sep 26, 2016 at 03:03:42AM +0300, Vladimir Zapolskiy wrote:
> Function mx31_clocks_init() is called during clock intialization on
> legacy boards with reference clock frequency passed as its input
> argument, this can be verified by examination of the function
> declaration found in arch/arm/mach-imx/common.h and actual function
> users which include that header file.
> 
> Inside CCF driver the function ignores its input argument, by chance
> the used value in the function body is the same as input arguments on
> side of all callers.
> 
> Fixes: d9388c843237 ("clk: imx31: Do not call mxc_timer_init twice when booting with DT")
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Reviewed-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
