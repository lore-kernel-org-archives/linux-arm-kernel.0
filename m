From: scott.branden@broadcom.com (Scott Branden)
Date: Thu,  1 Dec 2016 16:19:57 -0800
Subject: [RFC PATCH 0/2] arm64: memory-hotplug: Add Memory Hotplug support
Message-ID: <1480637999-4320-1-git-send-email-scott.branden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is sent for comment to add memory hotplug support for ARM64
based platforms.  It follows hotplug code added for other architectures
in the linux kernel.

I tried testing the memory hotplug feature following documentation from
Documentation/memory-hotplug.txt.  I don't think it is working as expected
- see below:

To add memory to the system I did the following:
echo 0x400000000 > /sys/devices/system/memory/probe

The memory is displayed as system ram:
cat /proc/iomem:
74000000-77ffffff : System RAM
  74080000-748dffff : Kernel code
  74950000-749d2fff : Kernel data
400000000-43fffffff : System RAM

But does not seem to be added to the kernel memory.
/proc/meminfo did not change.

What else needs to be done so the memory is added to the kernel memory
pool for normal allocation?

Scott Branden (2):
  arm64: memory-hotplug: Add MEMORY_HOTPLUG, MEMORY_HOTREMOVE,
    MEMORY_PROBE
  arm64: defconfig: enable MEMORY_HOTPLUG config options

 arch/arm64/Kconfig           | 10 ++++++++++
 arch/arm64/configs/defconfig |  3 +++
 arch/arm64/mm/init.c         | 42 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+)

-- 
2.5.0
