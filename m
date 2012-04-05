From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 5 Apr 2012 15:52:07 -0700
Subject: CONFIG_EARLY_PRINTK on versatile broken in mainline
Message-ID: <CACxGe6twdkkQaN+ieZoFpjvQAect7-6mUz+N8yULDzwtwHoW1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Has anyone else had problems with CONFIG_EARLY_PRINTK on current
mainline?  ARM versatile fails to boot on qemu when it is selected.
I've just started bisecting.  v3.3 is okay, but current mainline is
broken.  Output stops after dumping out the memblock regions, and
__log_buf stops at the same place.

/home/grant/hacking/qemu/arm-softmmu/qemu-system-arm -M versatilepb
-nographic -kernel
/home/grant/hacking/linux/.build/arm/arch/arm/boot/zImage -append
memblock=debug earlyprintk console=ttyAMA0 console=tty0 debug -dtb
/home/grant/hacking/linux/.build/arm/arch/arm/boot/versatile-pb.dtb
-initrd /home/grant/hacking/images/versatile.rootfs.ext2
Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0
Linux version 3.4.0-rc1+ (grant at ponder) (gcc version 4.6.3
(Ubuntu/Linaro 4.6.3-1ubuntu3) ) #383 Thu Apr 5 15:50:47 PDT 2012
CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00093177
CPU: VIVT data cache, VIVT instruction cache
Machine: ARM-Versatile (Device Tree Support), model: ARM Versatile PB
bootconsole [earlycon0] enabled
memblock_reserve: [0x00000000008400-0x000000003995f8]
arm_memblock_init+0x4c/0x150
memblock_reserve: [0x00000000d00000-0x0000000122f000]
arm_memblock_init+0xcc/0x150
memblock_reserve: [0x00000000004000-0x00000000008000]
arm_memblock_init+0xf0/0x150
memblock_reserve: [0x0000000122f000-0x00000001235fd2]
arm_dt_memblock_reserve+0x30/0xb4
MEMBLOCK configuration:
 memory size = 0x8000000 reserved size = 0x8cb1ca
 memory.cnt  = 0x1
 memory[0x0]    [0x00000000000000-0x00000007ffffff], 0x8000000 bytes
 reserved.cnt  = 0x3
 reserved[0x0]  [0x00000000004000-0x00000000007fff], 0x4000 bytes
 reserved[0x1]  [0x00000000008400-0x000000003995f7], 0x3911f8 bytes
 reserved[0x2]  [0x00000000d00000-0x00000001235fd1], 0x535fd2 bytes
Memory policy: ECC disabled, Data cache writeback
memblock_reserve: [0x00000007fff000-0x00000008000000]
memblock_alloc_base_nid+0x44/0x58


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
