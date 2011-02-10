From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 10 Feb 2011 11:47:25 +0100
Subject: [PATCH 1/2] video: Add i.MX23/28 framebuffer driver
In-Reply-To: <201102101046.33994.jbe@pengutronix.de>
References: <1297257651-8002-1-git-send-email-s.hauer@pengutronix.de>
	<1297257651-8002-2-git-send-email-s.hauer@pengutronix.de>
	<09EC74FE2C9E8444BF2FF67BD36E1D69167919@039-SN1MPN1-003.039d.mgd.msft.net>
	<201102101046.33994.jbe@pengutronix.de>
Message-ID: <20110210104725.GC2206@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> But I would prefer:
> #define SET 4
> #define CLEAR 8
> [...]
> writel(CTRL_DOTCLK_MODE, host->base + CTRL + SET)

NACK.

This will indeed not be caught by the compiler.

And while I like the shorter macros better as well, an MXSFB_ prefix
should be added IMO. Macros like CTRL and TIMING are not too well
protected.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110210/d36ddd33/attachment.sig>
