From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 7 Jan 2012 10:59:51 +0000
Subject: MSM's mach/system.h
Message-ID: <20120107105950.GD13857@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

MSM's mach/system.h is now almost empty, except for this:

extern void (*msm_hw_reset_hook)(void);

Grepping around for this, I find only one place where it's called, and
nowhere it's set:

$ grep -r msm_hw_reset_hook arch/arm/*msm* drivers/
arch/arm/mach-msm/include/mach/system.h:extern void (*msm_hw_reset_hook)(void);
arch/arm/mach-msm/smd.c:void (*msm_hw_reset_hook)(void);
arch/arm/mach-msm/smd.c:    if (msm_hw_reset_hook)
arch/arm/mach-msm/smd.c:            msm_hw_reset_hook();

As we've virtually eliminated the mach/system.h include (the only
remaining ones apart from this are the three unconverted platforms for
the restart changes), can this declaration move to somewhere else, or
can this read-only hook be removed?

Thanks.
