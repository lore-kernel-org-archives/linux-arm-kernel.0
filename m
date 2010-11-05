From: zonque@gmail.com (Daniel Mack)
Date: Fri, 05 Nov 2010 09:41:10 -0400
Subject: CONFIG_FORCE_MAX_ZONEORDER settable for all ARM architectures
Message-ID: <4CD40976.1080009@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

on a PXA3xx based platform, we want to allocate 8MByte of physically
contiguous memory for the framebuffer device.

However, alloc_pages() fails because MAX_ORDER is hard-coded to 11 for
this architecture.

Is there any reason why CONFIG_FORCE_MAX_ZONEORDER is constrained to
ARCH_SHMOBILE in arch/arm/Kconfig? Would a patch to remove this
limitation be accepted? Or is there any better way to allocate that
amount and type of memory?

Thanks,
Daniel
