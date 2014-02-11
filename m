From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 11 Feb 2014 10:30:05 -0500
Subject: [PATCH 06/11] ARM: mvebu: add Armada 380/385 support to the
 system-controller driver
In-Reply-To: <20140211162436.2bbe5719@skate>
References: <1392053002-19831-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1392053002-19831-7-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140210173957.GS8533@titan.lakedaemon.net>
 <CACxGe6u--F0J=kaHnvSsyDXNaO1r++T_TgzpNyy_2JU7+07r7w@mail.gmail.com>
 <20140211162436.2bbe5719@skate>
Message-ID: <20140211153005.GY8533@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 04:24:36PM +0100, Thomas Petazzoni wrote:
> Grant,
> 
> On Tue, 11 Feb 2014 14:22:04 +0000, Grant Likely wrote:
> 
> > >> +     }, {
> > >> +             /*
> > >> +              * As far as RSTOUTn and System soft reset registers
> > >> +              * are concerned, Armada 38x is similar to Armada
> > >> +              * 370/XP
> > >> +              */
> > >> +             .compatible = "marvell,armada-380-system-controller",
> > >> +             .data = (void *) &armada_370_xp_system_controller,
> > 
> > However, this would not be the right thing to do. The better solution
> > is to put the following into the .dts file:
> > 
> > compatible = "marvell,armada-380-system-controller","marvell,armada-370-system-controller"
> > 
> > So that the kernel has the option to override the 370 version if an
> > errata or extra feature support ever needs to be added.
> 
> Ah, right true. Makes sense. We are going to update our patch set to
> take this suggestion into account, and resubmit a v2 with this. This
> way, we don't need new to introduce in drivers new compatible strings
> for the clocksource driver, the mbus driver and the system-controller
> driver.
> 
> Thanks Grant for your suggestion.
> 
> Jason, are you ok with this?

Yes.  Thanks Grant for clearing this up.  And thanks guys for tolerating
my "This doesn't look right, but I'm having trouble explaining how"
moment :)

thx,

Jason.
