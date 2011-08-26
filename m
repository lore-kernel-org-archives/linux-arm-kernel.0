From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 26 Aug 2011 09:07:00 -0700
Subject: [PATCH v3 00/13] arm/tegra: Initialize GPIO & pinmux from DT
In-Reply-To: <CAOesGMiygfaNkPa7uURCiJpC=WDinWhKi07LFgJ+5JoGW_fLKw@mail.gmail.com>
References: <1314315824-9687-1-git-send-email-swarren@nvidia.com>
	<CAOesGMiygfaNkPa7uURCiJpC=WDinWhKi07LFgJ+5JoGW_fLKw@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04B24A40D2@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote at Thursday, August 25, 2011 11:05 PM:
> On Thu, Aug 25, 2011 at 4:43 PM, Stephen Warren <swarren@nvidia.com> wrote:
> > v3:
...
> This is looking pretty sane to me.
> 
> Grant, how do you prefer to handle this, since it spans of/dt, gpio
> and tegra code? I can start a topic branch for Arnd to pull in for the
> tegra parts, would you prefer picking up the of helper functions on
> your own or is an ack from you and merge through the arm-soc tree
> easier?

I haven't thought through all the merging details yet, but do be aware
of the dependencies this patchset has:

1) Rename of arch/arm/mach-tegra/gpio.c -> drivers/gpio/gpio-tegra.c
   This is in Grant's gpio for-next branch, and hence linux-next.
   This is in some GPIO-related branch of Russell's.

2) Various previous Tegra <mach/gpio.h> rework.
   This is in some GPIO-related branch of Russell's; I assume the same one
   as (1), but I can't actually find this branch, so can't check.

Neither of those is in any Linus release or rc.

I *think* that's it.

For reference, this patchset was physical written/tested on top of
next-20110823, with the patches mentioned in (2) aboe, and some others that
hopefully aren't relevant, between linux-next and this patchset.

-- 
nvpublic
