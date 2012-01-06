From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 6 Jan 2012 14:43:02 +0100
Subject: [PATCH 1/2] ARM: mxs: detect SoC by checking CHIPID register
In-Reply-To: <20120106133908.GD4790@S2101-09.ap.freescale.net>
References: <1325817712-4573-1-git-send-email-shawn.guo@linaro.org>
 <1325817712-4573-2-git-send-email-shawn.guo@linaro.org>
 <20120106114029.GB2610@pengutronix.de>
 <20120106133908.GD4790@S2101-09.ap.freescale.net>
Message-ID: <20120106134302.GC2610@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > 0x310 should not be hardcoded. CHIPID could be MXS_CHIPID.
> > 
> I thought about those when I wrote the code, and decided not to bother,
> since they are very really limited in mxs.h.  But now I think I should
> bother, because your comments are here.

:) I think 0x310 should be defined in digctl.h (which was introduced by
Aisheng IIRC). Then, we at least know which functionality from DIGCTL is
used currently.

> > Can't we use the cpu_is-functions here?
> > 
> No.  We are running with MMU off here.

Right, thanks, missed that.

Thanks,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120106/c17eb839/attachment.sig>
