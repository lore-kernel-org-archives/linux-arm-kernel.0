From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sat, 30 Nov 2013 13:52:05 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBSRVNFTkRdIG1mZDogbWMxM3h4eDogRml4IG51bGwgcG9p?=
 =?UTF-8?B?bnRlciBkZXJlZmVyZW5jZSBpbiBtYzEzeHh4X2NvbW1vbl9pbml0?=
In-Reply-To: <20131130093456.GD28906@pengutronix.de>
References: <1385787337-5296-1-git-send-email-shc_work@mail.ru>
 <20131130093456.GD28906@pengutronix.de>
Message-ID: <1385805125.304293643@f433.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Sat, Nov 30, 2013 at 08:55:37AM +0400, Alexander Shiyan wrote:
> > If this driver being loaded from devicetree, the pdata is NULL.
> > This cause kernel Oops when "fsl,mc13xxx-uses-codec" and/or
> > "fsl,mc13xxx-uses-touch" properties is specified.
> > 
> > mc13xxx spi0.0: mc13783: rev: 3.3, fin: 0, fab: 0, icid: 2/0
> > Unable to handle kernel NULL pointer dereference at virtual address 00000018
...
> > -	if (mc13xxx->flags & MC13XXX_USE_TOUCHSCREEN)
> > +	if ((mc13xxx->flags & MC13XXX_USE_CODEC) && pdata)
> 
> Why do we check for CODEC if the Touchscreen should be used?

Oops, my fault, copy/paste bug.
I'll send the corrected version.

---
