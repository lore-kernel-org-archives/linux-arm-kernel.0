From: mgr@pengutronix.de (Michael Grzeschik)
Date: Mon, 2 Dec 2013 12:53:24 +0100
Subject: [PATCH RESEND] mfd: mc13xxx: Fix null pointer dereference in
 mc13xxx_common_init
In-Reply-To: <1385982663.209903201@f198.i.mail.ru>
References: <1385787337-5296-1-git-send-email-shc_work@mail.ru>
 <1385805125.304293643@f433.i.mail.ru>
 <20131202105650.GD29373@lee--X1>
 <1385982663.209903201@f198.i.mail.ru>
Message-ID: <20131202115324.GA27635@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 02, 2013 at 03:11:03PM +0400, Alexander Shiyan wrote:
> 
> 
> 
> ???????????,  2 ??????? 2013, 10:56 UTC ?? Lee Jones <lee.jones@linaro.org>:
> > On Sat, 30 Nov 2013, Alexander Shiyan wrote:
> > 
> > > > On Sat, Nov 30, 2013 at 08:55:37AM +0400, Alexander Shiyan wrote:
> > > > > If this driver being loaded from devicetree, the pdata is NULL.
> > > > > This cause kernel Oops when "fsl,mc13xxx-uses-codec" and/or
> > > > > "fsl,mc13xxx-uses-touch" properties is specified.
> > > > > 
> > > > > mc13xxx spi0.0: mc13783: rev: 3.3, fin: 0, fab: 0, icid: 2/0
> > > > > Unable to handle kernel NULL pointer dereference at virtual address 00000018
> > > ...
> > > > > -	if (mc13xxx->flags & MC13XXX_USE_TOUCHSCREEN)
> > > > > +	if ((mc13xxx->flags & MC13XXX_USE_CODEC) && pdata)
> > > > 
> > > > Why do we check for CODEC if the Touchscreen should be used?
> > > 
> > > Oops, my fault, copy/paste bug.
> > > I'll send the corrected version.
> > 
> > No, please don't.
> > 
> > Just provide proper Device Tree support.
> 
> I still have two incomplete MC13XXX DT-related patches.
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/175099.html
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/182116.html
> 
> I'll resume to work on this (and CODEC & TS too).

When you keep working on it, you can also look into that tree:

http://git.pengutronix.de/?p=mgr/linux.git;a=shortlog;h=refs/heads/v3.11/topic/mc13xxx

I currently have no time and no capable hardware on my desk to keep
working on this. But it would be great if this code will not keep
rotting any further.

Thanks,
Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
