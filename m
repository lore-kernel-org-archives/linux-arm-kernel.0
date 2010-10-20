From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Wed, 20 Oct 2010 06:51:10 +0200
Subject: [RFC, PATCH 0/5] unify definition of CLOCK_TICK_RATE across different
	platforms
Message-ID: <20101020045110.GW12979@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One of the things preventing building an ARM multiplatform kernel
image is the fact that CLOCK_TICK_RATE (and as a consequence, LATCH)
is defined differently for each ARM platform.

The patches in this series:
- pull the per-platform CLOCK_TICK_RATE defines from <mach/timex.h>
  into arch/arm/mach-foo/ (on those platforms that use the
  CLOCK_TICK_RATE define and/or the LATCH define in their platform
  support code);
- define CLOCK_TICK_RATE as a platform-independent value in <asm/timex.h>;
- get rid of all <mach/timex.h> include files.

Comments welcome!
