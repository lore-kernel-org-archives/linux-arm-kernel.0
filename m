From: matthew.leach@arm.com (Matthew Leach)
Date: Thu,  6 Sep 2012 14:35:01 +0100
Subject: [RFC PATCH 0/2] ARM: kexec: Add dtb kexec support
Message-ID: <1346938503-18142-1-git-send-email-matthew.leach@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the value of r2 that is passed to the new kernel when
performing a kexec() is hard coded to an address that is 16Kb before
the kernel image. A dtb file may be much larger and thus get corrupted
by the decompressor's page tables.

These patches, along with a set of kexec-tools patches, move the dtb
to a more sane location. The kernel will scan each segment for the dtb
magic within the first four bytes of each segment to identify the
physical address to pass through to the new kernel in r2.


Matthew Leach (2):
  ARM: kexec: scan for dtb magic in segments
  ARM: kexec: Check segment memory addresses

 arch/arm/kernel/machine_kexec.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

-- 
1.7.12
