From: olof@lixom.net (Olof Johansson)
Date: Wed, 21 May 2014 14:25:26 -0700
Subject: [GIT PULL] vexpress: defconfig update for 3.13
In-Reply-To: <1400173119.29434.4.camel@hornet>
References: <1400173119.29434.4.camel@hornet>
Message-ID: <20140521212526.GA24972@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 05:58:39PM +0100, Pawel Moll wrote:
> Hello Arnd, Kevin, Olof,
> 
> The series went through the a couple of review cycles (with the latest
> here: thread.gmane.org/gmane.linux.ports.arm.kernel/320572/) and got set
> of acks from almost all relevant subsystem maintainers.
> 
> The following changes since commit d6d211db37e75de2ddc3a4f979038c40df7cc79c:
> 
>   Linux 3.15-rc5 (2014-05-09 13:10:52 -0700)
> 
> are available in the git repository at:
> 
>   git://git.linaro.org/people/pawel.moll/linux.git tags/vexpress/updates-for-3.16
> 
> for you to fetch changes up to 6b2c31c71d6fa8896c5f3f2354d790a5bd3f0a1e:
> 
>   ARM: vexpress: move HBI check to sysreg driver (2014-05-15 17:02:21 +0100)
> 
> ----------------------------------------------------------------
> ARM Versatile Express updates for 3.16
> 
> This series reworks VE's platform configuration infrastructure by:
> 
> - making it possible to instantiate selected devices from the
>   Device Tree, prior to massive population,
> - converting custom "func" API into standard "regmap",
> - splitting the existing MFD driver into smaller ones and placing
>   them into relevant directories.
> 
> The common clock framework driver can now be selected individually
> (mostly for arm64 sake, where some of them are not used at all).
> 
> It also simplifies the machine code, by:
> 
> - moving the shed clock info clocksource driver,
> - simplifying SMP operations to base them entirely of the DT data,
> - moving platform ID checks into relevant driver.
> 
> ----------------------------------------------------------------
> Pawel Moll (8):
>       of: Keep track of populated platform devices
>       mfd: vexpress: Convert custom func API to regmap
>       mfd: syscon: Add platform data with a regmap config name
>       mfd: vexpress: Define the device as MFD cells
>       clk: versatile: Split config options for sp810 and vexpress_osc
>       clocksource: Sched clock source for Versatile Express
>       ARM: vexpress: Simplify SMP operations for DT-powered system
>       ARM: vexpress: move HBI check to sysreg driver
> 
> Sudeep KarkadaNagesha (1):
>       ARM: vexpress: remove redundant vexpress_dt_cpus_num to get cpu count


Nice refactorings!

I've merged this into next/cleanup -- I can't really find a better place for it
and, well, it is definitely a huge cleanup branch in many ways. :)


-Olof
