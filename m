From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 7 Dec 2010 18:00:20 +0100
Subject: [PATCH v2] watchdog: imx: use clk_get to acquire the watchdog
	clock
In-Reply-To: <20101207164905.GD6017@pengutronix.de>
References: <1291738564-10374-1-git-send-email-fabio.estevam@freescale.com>
	<20101207164905.GD6017@pengutronix.de>
Message-ID: <20101207170020.GC4134@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 07, 2010 at 05:49:05PM +0100, Sascha Hauer wrote:

> I should have seen this happen. This breaks i.MX1 reset which uses
> imx-wdt.0.
> 
> The root cause of this problem is that we have two different watchdog
> drivers with two different names but only one reset code for all i.MX.
> We could register an additional watchdog clock for all i.MXs and use it
> for the reset code.

Actually, there is no wdt-driver for mx1 yet. They _could_ be merged,
but the result will not be pretty.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101207/d1c4df50/attachment.sig>
