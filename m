From: tony@atomide.com (Tony Lindgren)
Date: Thu, 8 Oct 2015 01:40:21 -0700
Subject: All OMAP platforms: MMC is broken
In-Reply-To: <5615A723.6090907@ti.com>
References: <20151006090015.GE21626@n2100.arm.linux.org.uk>
 <20151006094425.GM23801@atomide.com>
 <20151006150009.GF21626@n2100.arm.linux.org.uk>
 <20151006153710.GS23801@atomide.com>
 <20151007124551.GI21626@n2100.arm.linux.org.uk>
 <20151007132642.GV23801@atomide.com>
 <CAPDyKFoBPEnHuNR_bsrPU6X=q5pHa8cDR7_Ng9xLnLsudymvOg@mail.gmail.com>
 <20151007155206.GX23801@atomide.com>
 <CAPDyKFp5e_pizFSCzeYSM8sXGx6Jewgs2PRB-RQ1iWMM6WMOww@mail.gmail.com>
 <5615A723.6090907@ti.com>
Message-ID: <20151008084020.GY23801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kishon Vijay Abraham I <kishon@ti.com> [151007 16:18]:
> Hi,
> 
> On Thursday 08 October 2015 01:10 AM, Ulf Hansson wrote:
> > On 7 October 2015 at 17:52, Tony Lindgren <tony@atomide.com> wrote:
> >> * Ulf Hansson <ulf.hansson@linaro.org> [151007 06:46]:
> >>> On 7 October 2015 at 15:26, Tony Lindgren <tony@atomide.com> wrote:
> >>>>>> Good idea, how about something like the following? AFAIK that's the
> >>>>>> only .config option needed as MFD_SYSCON is selected by Kconfig
> >>>>>> already.
> >>>
> >>> Similar to MFD_SYSCON, why don't we have REGULATOR_PBIAS to be
> >>> selected when omap_hsmmc is being used?
> >>>
> >>> It seems like that should also be a patch for the rc, right!?
> >>
> >> Well selecting CONFIG_REGULATOR is still optional and force selecting
> >> drivers usually leads into randconfig build issues sooner or later.
> >> And we'd like to make everything into loadable modules eventually.
> > 
> > I am not sure I get your point. Perhaps I was too vague in what I suggested.
> > 
> > Unless we express the dependencies via Kconfig files (or perhaps via
> > updated defconfigs), how do you expect build/boot automated tools to
> > handle this?
> 
> Both omap2plus_defconfig and multi_v7_defconfig has
> CONFIG_PBIAS_REGULATOR enabled [1].
> 
> I think by using *depends on* in Kconfig, we'll end up in the same issue
> faced by Russell (since even with that CONFIG_PBIAS_REGULATOR won't be
> enabled) and using *select* can lead to randconfig errors.

Well the way distros deal with issues like this is have everything
possible as loadable modules. We should get the regulator_pbiaa
loaded automatically in that case as long as it's in the dts.. And
as long as we have the MODULE_DEVICE_TABLE entries right.

Maybe we could also use the composite device to indicate when MMC1
is using PBIAS regulator?

Regrads,

Tony
