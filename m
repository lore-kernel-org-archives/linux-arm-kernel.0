From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 4 Nov 2010 16:57:35 +0100
Subject: [PATCH] ARM: pxa: fix the building failue on saar
In-Reply-To: <1288882401-14859-1-git-send-email-haojian.zhuang@marvell.com>
References: <1288882401-14859-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <20101104155735.GE16938@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Nov 04, 2010 at 10:53:21PM +0800, Haojian Zhuang wrote:
> Since CONFIG_FB_PXA_SMARTPANEL is introduced and it's depend on CONFIG_FB_PXA.
> We can't compile CONFIG_FB_PXA as module.
I don't know if choosing CONFIG_FB_PXA=m without
CONFIG_FB_PXA_SMARTPANEL makes sense.  If yes, just letting
CONFIG_FB_PXA_SMARTPANEL depend on CONFIG_FB_PXA=y should work.

If this doesn't work (e.g. because arch/arm/mach-pxa/saar.c calls
functions that are only available in the fb_pxa kernel module) there is
no need to talk about CONFIG_FB_PXA_SMARTPANEL in the commit log, this
only confuses the readers.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
