From: vlad@emcraft.com (Vladimir K)
Date: Fri, 03 Feb 2012 19:12:04 +0300
Subject: insmod problem on ARM with more than 16MB of RAM?
In-Reply-To: <20111222204515.GQ2577@n2100.arm.linux.org.uk>
References: <20111222204515.GQ2577@n2100.arm.linux.org.uk>
Message-ID: <4F2C0754.4070504@emcraft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> So for MMU platforms, we just ensure that modules are always placed
> within reach of the kernel text.  For nommu platforms, modules are
> a bitch - and TBH given the virtually non-existent activity/interest
> from the nommu sector, it's something I'm willing to spend the grand
> total of zero time to solve this _really_ _hard_ problem.

Wouldn't just adding a -mlong-calls to CFLAGS_MODULE
resolve the problem?

Something along the lines of:

ifeq ($(CONFIG_MODULES),y)
CFLAGS_MODULE    += -mlong-calls
endif

in arch/arm/Makefile.

This this change, modules work fine for me on a 32MBytes RAM
Cortex-M3 configuration.

Regards,
Vladimir Khusainov
