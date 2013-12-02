From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 2 Dec 2013 10:56:50 +0000
Subject: [PATCH RESEND] mfd: mc13xxx: Fix null pointer dereference in
 mc13xxx_common_init
In-Reply-To: <1385805125.304293643@f433.i.mail.ru>
References: <1385787337-5296-1-git-send-email-shc_work@mail.ru>
 <20131130093456.GD28906@pengutronix.de>
 <1385805125.304293643@f433.i.mail.ru>
Message-ID: <20131202105650.GD29373@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 30 Nov 2013, Alexander Shiyan wrote:

> > On Sat, Nov 30, 2013 at 08:55:37AM +0400, Alexander Shiyan wrote:
> > > If this driver being loaded from devicetree, the pdata is NULL.
> > > This cause kernel Oops when "fsl,mc13xxx-uses-codec" and/or
> > > "fsl,mc13xxx-uses-touch" properties is specified.
> > > 
> > > mc13xxx spi0.0: mc13783: rev: 3.3, fin: 0, fab: 0, icid: 2/0
> > > Unable to handle kernel NULL pointer dereference at virtual address 00000018
> ...
> > > -	if (mc13xxx->flags & MC13XXX_USE_TOUCHSCREEN)
> > > +	if ((mc13xxx->flags & MC13XXX_USE_CODEC) && pdata)
> > 
> > Why do we check for CODEC if the Touchscreen should be used?
> 
> Oops, my fault, copy/paste bug.
> I'll send the corrected version.

No, please don't.

Just provide proper Device Tree support.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
