From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Mon, 31 Jan 2011 19:13:30 +0100
Subject: [PATCH] ARM: print FPGA info on plat-versatile variants
In-Reply-To: <20110130195934.GC27436@n2100.arm.linux.org.uk>
References: <1296128890-18765-1-git-send-email-linus.walleij@stericsson.com>
	<20110130195934.GC27436@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinqrTPhdFw+yr8Ryd_QAZJCi_OhTsyxfK6D_OCS@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/30 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> I think it needs a few tweaks for Versatile Express:
>
> arch/arm/plat-versatile/fpga-id.c:14:27: error: mach/platform.h: No such file or directory
> arch/arm/plat-versatile/fpga-id.c: In function ?versatile_fpga_probe?:
> arch/arm/plat-versatile/fpga-id.c:78: error: implicit declaration of function ?MMIO_P2V?

Aha, I figured out this is impossible to solve without falling
back to either:

- The old patch approach adding hooks to each platform calling
  here with the offset address or,
- Rework the driver supplying some platform data and a
  platform device for it feels like overkill.
- Rearchitecture vexpress to use same macros as RealView
  or so.

Because MMIO_P2V is local in mach-vexpress/core.h
and cannot be used outside the machine, e.g. in the platform.

This is not useful enough to keep hacking at, it was a little bit useful
but let's just drop it for now, I'll take the patch out of the tracker.

Linus Walleij
