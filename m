From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 02 Dec 2013 15:11:03 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBSRVNFTkRdIG1mZDogbWMxM3h4eDogRml4IG51bGwgcG9p?=
 =?UTF-8?B?bnRlciBkZXJlZmVyZW5jZSBpbiBtYzEzeHh4X2NvbW1vbl9pbml0?=
In-Reply-To: <20131202105650.GD29373@lee--X1>
References: <1385787337-5296-1-git-send-email-shc_work@mail.ru>
 <1385805125.304293643@f433.i.mail.ru>
 <20131202105650.GD29373@lee--X1>
Message-ID: <1385982663.209903201@f198.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org




???????????,  2 ??????? 2013, 10:56 UTC ?? Lee Jones <lee.jones@linaro.org>:
> On Sat, 30 Nov 2013, Alexander Shiyan wrote:
> 
> > > On Sat, Nov 30, 2013 at 08:55:37AM +0400, Alexander Shiyan wrote:
> > > > If this driver being loaded from devicetree, the pdata is NULL.
> > > > This cause kernel Oops when "fsl,mc13xxx-uses-codec" and/or
> > > > "fsl,mc13xxx-uses-touch" properties is specified.
> > > > 
> > > > mc13xxx spi0.0: mc13783: rev: 3.3, fin: 0, fab: 0, icid: 2/0
> > > > Unable to handle kernel NULL pointer dereference at virtual address 00000018
> > ...
> > > > -	if (mc13xxx->flags & MC13XXX_USE_TOUCHSCREEN)
> > > > +	if ((mc13xxx->flags & MC13XXX_USE_CODEC) && pdata)
> > > 
> > > Why do we check for CODEC if the Touchscreen should be used?
> > 
> > Oops, my fault, copy/paste bug.
> > I'll send the corrected version.
> 
> No, please don't.
> 
> Just provide proper Device Tree support.

I still have two incomplete MC13XXX DT-related patches.
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/175099.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/182116.html

I'll resume to work on this (and CODEC & TS too).
Thanks.

---
