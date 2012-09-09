From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 8 Sep 2012 22:39:15 -0300
Subject: Early crash on linux-nex:t 20120906
Message-ID: <CAOMZO5DN8iEH=1f+1LAQHbJpQ5PSHJW7ucHVrFc7cpRfoRW9Bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Booting a linux-nex:t 20120906 kernel on a mx31pdk board I get a very
early crash:

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0
Linux version 3.6.0-rc4-next-20120906 (fabio at fabio-Latitude-E6410)
(gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #140 SMP Thu S2
CPU: ARMv6-compatible processor [4107b364] revision 4 (ARMv6TEJ), cr=00c5387d
CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: Freescale MX31PDK (3DS)
bootconsole [earlycon0] enabled
Memory policy: ECC disabled, Data cache writeback
PERCPU: Embedded 7 pages/cpu @80838000 s6208 r8192 d14272 u32768
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 30464
Kernel command line: console=ttymxc0,115200 earlyprintk root=/dev/nfs
ip=dhcp nfsroot=10.29.240.145:/tftpboot/ltib
PID hash table entries: 512 (order: -1, 2048 bytes)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 120MB = 120MB total
Memory: 114332k/114332k available, 16740k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0x88800000 - 0xff000000   (1896 MB)
    lowmem  : 0x80000000 - 0x88000000   ( 128 MB)
    modules : 0x7f000000 - 0x80000000   (  16 MB)
      .text : 0x80008000 - 0x80648000   (6400 kB)
      .init : 0x80648000 - 0x80692840   ( 299 kB)
      .data : 0x80694000 - 0x806dd590   ( 294 kB)
       .bss : 0x806dd5b4 - 0x80734b30   ( 350 kB)
Unable to handle kernel paging request at virtual address fffff7fc
pgd = 80004000
[fffff7fc] *pgd=877fe821, *pte=00000000, *ppte=00000000
Internal error: Oops: 80000007 [#1] SMP ARM
Modules linked in:
CPU: 0    Not tainted  (3.6.0-rc4-next-20120906 #140)
PC is at 0xfffff7fc
LR is at new_slab+0x1d4/0x258
pc : [<fffff7fc>]    lr : [<800ad9f8>]    psr: a00001f3
sp : 80695f10  ip : 8069d168  fp : 80695f34
r10: 00000000  r9 : 80724154  r8 : 80815100
r7 : 87008000  r6 : 87008000  r5 : 87008000  r4 : 87000080
r3 : fffff7fd  r2 : 00008000  r1 : 806961f4  r0 : 87008000
Flags: NzCv  IRQs off  FIQs off  Mode SVC_32  ISA Thumb  Segment kernel
Control: 00c5387d  Table: 80004000  DAC: 00000017
Process swapper (pid: 0, stack limit = 0x80694238)
Stack: (0x80695f10 to 0x80696000)
5f00:                                     00042000 87000080 00000000 80724ac0
5f20: 00000001 00000006 80695f6c 80695f38 800aede4 800ad830 806dd5c0 80684904
5f40: 806ab88c 80004008 4107b364 00000006 806dd5c0 80684904 806ab88c 00000001
5f60: 80695fbc 80695f70 806653f4 800aed38 80694000 806dd590 00000126 806dd5b4
5f80: 80734b30 0000015e 80695fac 80695f98 8024f44c ffffffff 806dd5c0 80684904
5fa0: 80835700 80004008 4107b364 804d638c 80695ff4 80695fc0 806486e0 80665394
5fc0: ffffffff ffffffff 8064832c 00000000 00000000 80684904 00c5387d 8069c948
5fe0: 80684900 806a099c 00000000 80695ff8 80008044 80648590 00000000 00000000
Backtrace:
[<800ad824>] (new_slab+0x0/0x258) from [<800aede4>] (kmem_cache_open+0xb8/0x1e4)
[<800aed2c>] (kmem_cache_open+0x0/0x1e4) from [<806653f4>]
(kmem_cache_init+0x6c/0x258)
 r8:00000001 r7:806ab88c r6:80684904 r5:806dd5c0 r4:00000006
[<80665388>] (kmem_cache_init+0x0/0x258) from [<806486e0>]
(start_kernel+0x15c/0x2f0)
[<80648584>] (start_kernel+0x0/0x2f0) from [<80008044>] (0x80008044)
 r7:806a099c r6:80684900 r5:8069c948 r4:00c5387d
Code: bad PC value
---[ end trace 1b75b31a2719ed1c ]---
Kernel panic - not syncing: Attempted to kill the idle task!

,I will start bisecting it on Monday, but if anyone has any
suggestions please let me know.

Regards,

Fabio Estevam
