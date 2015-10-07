From: tony@atomide.com (Tony Lindgren)
Date: Wed, 7 Oct 2015 08:52:06 -0700
Subject: All OMAP platforms: MMC is broken
In-Reply-To: <CAPDyKFoBPEnHuNR_bsrPU6X=q5pHa8cDR7_Ng9xLnLsudymvOg@mail.gmail.com>
References: <20151005145127.GB23801@atomide.com>
 <20151005171155.GF23801@atomide.com>
 <20151005183813.GD21626@n2100.arm.linux.org.uk>
 <20151006090015.GE21626@n2100.arm.linux.org.uk>
 <20151006094425.GM23801@atomide.com>
 <20151006150009.GF21626@n2100.arm.linux.org.uk>
 <20151006153710.GS23801@atomide.com>
 <20151007124551.GI21626@n2100.arm.linux.org.uk>
 <20151007132642.GV23801@atomide.com>
 <CAPDyKFoBPEnHuNR_bsrPU6X=q5pHa8cDR7_Ng9xLnLsudymvOg@mail.gmail.com>
Message-ID: <20151007155206.GX23801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ulf Hansson <ulf.hansson@linaro.org> [151007 06:46]:
> On 7 October 2015 at 15:26, Tony Lindgren <tony@atomide.com> wrote:
> >> > Good idea, how about something like the following? AFAIK that's the
> >> > only .config option needed as MFD_SYSCON is selected by Kconfig
> >> > already.
> 
> Similar to MFD_SYSCON, why don't we have REGULATOR_PBIAS to be
> selected when omap_hsmmc is being used?
> 
> It seems like that should also be a patch for the rc, right!?

Well selecting CONFIG_REGULATOR is still optional and force selecting
drivers usually leads into randconfig build issues sooner or later.
And we'd like to make everything into loadable modules eventually.

We could print a warning during MMC1 probe if REGULATOR_PBIAS
is not selected and attempt to continue probing?

Regards,

Tony
