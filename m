From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 23 May 2012 23:49:15 +0800
Subject: Booting mx31 on linux-next-20120517
In-Reply-To: <CAOMZO5DHNXkc9wAMapQgtfPujSEcMvFvuSSZfJPb2nM5fm3sUg@mail.gmail.com>
References: <CAOMZO5C2vf-emmk=aALy7VESnBkVAQ23YXkHP31MMK7JQzd3Ag@mail.gmail.com>
 <20120518085922.GQ30400@pengutronix.de>
 <CAOMZO5DNSRCknE2Z-rmUjBsJWaiZdRb=8hrNw2N=u4OsqyX1AQ@mail.gmail.com>
 <3280708.6NjLuBzCWZ@laptop>
 <CAOMZO5DHNXkc9wAMapQgtfPujSEcMvFvuSSZfJPb2nM5fm3sUg@mail.gmail.com>
Message-ID: <20120523154909.GA17621@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2012 at 10:35:42AM -0300, Fabio Estevam wrote:
> On Mon, May 21, 2012 at 10:33 AM, Philippe R?tornaz
> <philippe.retornaz@epfl.ch> wrote:
> 
> > Try to disable the MC13783 Pmic. On mx31moboard I have the same hang and I can
> > clearly see that the board switchoff itself.
> > It looks like somebody is writing in the wrong register (regmap code?).
> 
> You are right. If I disable the mc13783 driver then the boots proceed.
> 
> I will take a look at the mc13783 driver. If you also spot anything
> wrong there, please let us know.
> 
My imx51 babbage stops booting for the same cause.  And I tracked it
down a little bit and it goes to regmap patch below. 

commit 91b5e741184ea9836cd7d7509e4f9b6eefa27df2
Author: Marc Reilly <marc@cpdesign.com.au>
Date:   Sun Apr 1 16:41:37 2012 +1000

    mfd: Use regmap for the mc13xxx-core register access

    This change converts the mc13xxx core to use regmap rather than direct
    spi r/w.
    The spidev member of mc13xxx struct becomes redundant and is removed.
    Extra debugging aids are added to mc13xxx_reg_rmw.
    Mutex init is moved to before regmap init.

Marc,

Have you tested the patch with spi access?  It seems not to me.

-- 
Regards,
Shawn
