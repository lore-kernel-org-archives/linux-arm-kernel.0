From: will.deacon@arm.com (Will Deacon)
Date: Fri, 7 May 2010 18:02:23 +0100
Subject: MSM PMU Support in Commit ee3c454b
Message-ID: <000101caee07$104acdc0$30e06940$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Commit ee3c454b `arm: msm: add oprofile pmu support' in your devel
branch adds an IRQ to the static list in kernel/pmu.c. Patch 6064/1 in
the patch system replaces this old functionality with runtime registration
using a platform device, so this commit prevents that patch applying.
The OProfile patches in the system also depend on the runtime registration
patch, so they will become blocked too.

I can update the patch in the patch system so it applies cleanly, but
the mach-msm bsp will need updating to register the IRQ using the new
mechanism. Daniel: would you like me to submit a patch to do this, or
would you rather do it [since I'm unfamiliar with the mach]?

Cheers,

Will
