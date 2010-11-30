From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 30 Nov 2010 20:20:05 +0100
Subject: [PATCH v2] ARM: mx5: fix keypad clock name
In-Reply-To: <1291144416-25197-1-git-send-email-fabio.estevam@freescale.com>
References: <1291144416-25197-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20101130192005.GV20449@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Fabio,

On Tue, Nov 30, 2010 at 05:13:36PM -0200, Fabio Estevam wrote:
> This fixes the following error during keypad driver probe:
> 
> imx-keypad imx-keypad: failed to get keypad clock
> imx-keypad: probe of imx-keypad failed with error -2
> 
> commit 3f88014 (ARM: imx: dynamically allocate imx-keypad devices)
> uses id=-1 for imx_kpp_device, so change the clock name accordingly.
This is true, but the reasoning is broken.  3f88014 uses -1, but only
with your patch that makes mx51 use the function introduced in 3f88014
this becomes a problem for mx51.

I suggest to squash this into your patch and adding a short notice to
the commit log why this is necessary.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
