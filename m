From: Mark.Zhang@arris.com (Zhang, Mark)
Date: Wed, 31 Dec 2014 03:20:54 +0000
Subject: Initrd memory area overlaps with platform-specific memory region
Message-ID: <F1DE50855249694DBC7A0EA5645BECF789B543EF@ATLEXMBX4.ARRS.ARRISI.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

We have an issue that our initrd memory area (20M~50M) is overlapped with
vendor reversed memory area (32M ~ 40M); When freeing initrd memory the vendor
memory are also freed, which caused many weird issues.

We found that in "arch/arm/mm/init.c::arm_memblock_init()" it has checked if
the initrd memory has been reserved, but it is checked before the reserve of the
platform specific memblock areas. So our question is: In this function, can we
reserve the platform-specific memblocks (or maybe all memblocks need to be reserved?)
before the initrd memory check and reserve operation? In this case there will be
errors like:
  "INITRD: 0x01400000+0x01e00000 overlaps in-use memory region - disabling initrd"

So that we can easily find out the problem.

Thank you very much.
