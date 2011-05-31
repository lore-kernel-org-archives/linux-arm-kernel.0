From: dc4meego@gmail.com (dc4 meego)
Date: Tue, 31 May 2011 12:52:09 +0100
Subject: Memory hotplug on ARM linux
Message-ID: <BANLkTinf5t9zb=6Ha4emMmJZuLeT0t9Acg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm trying to get memory hotplug working on ARM linux.

I've enabled the options (ARCH_ENABLE_MEMORY_HOTPLUG,
ARCH_ENABLE_MEMORY_HOTREMOVE, ARCH_MEMORY_PROBE) and can see the
memory through the sysfs interface.
However adding memory results in a "Unable to handle kernel paging
request", and no memory is removable (e.g. "memory offlining 2000 to
2400 failed")

I'm guessing I need either start with all memory present, but some
initialised as ZONE_MOVABLE, so I can later offline it.
Or start with some memory missing, but add something to the
arch_add_memory to make the memory available after onlining.

(the reason for doing this is to share SDRAM between the ARM and a
DSP, and to change the allocation whilst running)

Anyone had this working on an ARM?
