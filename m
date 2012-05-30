From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 30 May 2012 11:12:23 +0300
Subject: [PATCH 0/3] ARM: OMAP4: add support for TPS62361 PMIC
In-Reply-To: <87ehq2ekwk.fsf@ti.com>
References: <1336139842-845-1-git-send-email-t-kristo@ti.com>
 <87ehq2ekwk.fsf@ti.com>
Message-ID: <1338365543.8834.111.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-05-29 at 14:29 -0700, Kevin Hilman wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > Hi,
> >
> > This set adds support for TPS62361 PMIC, which is used to power
> > MPU voltagedomain on OMAP4460 boards. These patches apply on top
> > of 3.4 + my voltagedomain fixes set to avoid adding redundant code.
> 
> Hmm... do you have an updated version of your voltagedomain fixes?  Or
> are you waiting for me to review something?  I thought I had been
> through them already, but if I have not, they slipped throught the
> cracks.  I'm sorry.  Can you please update/repost?

There have been some updates to the patches as per Nishanth's comments,
but I need to double check those before re-posting here. I can re-post
this series also once that is done.

-Tero

> 
> Thanks.
> 
> Kevin
> 
> > Working tree available here for interested parties:
> >
> > git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
> > branch: mainline-3.4-voltdm-tps-v1
> >
> > Tree has been tested with:
> > - omap3beagle board
> > - omap4panda es board (OMAP4460)
> > - omap4blaze board (OMAP4430)
> >
> > Tested modifying the voltage levels on all core regulators (vdd1...vdd3)
> > and measuring that the voltages do actually change.
> >
> > Patch #1 was needed before the voltages could be modified on a panda
> > board es device, otherwise the timing for the I2C channel was so bogus
> > it usually failed. The values used were taken from an android tree and
> > are based on TI analysis.
> >
> > -Tero
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
