From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 19 Sep 2016 07:55:30 +0200
Subject: [PATCH] clk: imx31: fix potential stack corruption on clock
 initialization
In-Reply-To: <1474249708-11088-1-git-send-email-vz@mleia.com>
References: <1474249708-11088-1-git-send-email-vz@mleia.com>
Message-ID: <20160919055530.qyahv7ep6wbuhsnx@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2016 at 04:48:28AM +0300, Vladimir Zapolskiy wrote:
> Function mx31_clocks_init() is called during clock intialization on
> legacy boards with reference clock frequency passed as its input
> argument, this can be verified by examination of the function
> declaration found in arch/arm/mach-imx/common.h and actual function
> users which include that header file.

I don't think this can corrupt the stack. The caller puts a value in r0
that is unused by mx31_clocks_init. And given that all callers pass
26000000 there should happen nothing bad apart from a compiler warning.

So: the change is fine, IMHO the commit log shouldn't mention stack
corruption.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
