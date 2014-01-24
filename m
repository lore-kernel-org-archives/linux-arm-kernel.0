From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 24 Jan 2014 11:01:17 -0200
Subject: Warning at __kmem_cache_create
Message-ID: <CAOMZO5Cbws-Kj-q63iCAFFOyR7gm24Z+VUZTAdzeOgud3B4cjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

When running linux-next on mx51 or mx6 I get the following warning:
Booting Linux on physical CPU 0x0
Linux version 3.13.0-next-20140124 (fabio at fabio-Latitude-E6410) (gcc version 4.7
.3 (Ubuntu/Linaro 4.7.3-1ubuntu1) ) #685 SMP Fri Jan 24 10:54:30 BRST 2014
CPU: ARMv7 Processor [412fc085] revision 5 (ARMv7), cr=10c53c7d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine model: Freescale i.MX51 Babbage Board
Memory policy: Data cache writeback
On node 0 totalpages: 131072
free_area_init_node: node 0, pgdat 8088ac00, node_mem_map 9fbf8000
  Normal zone: 1024 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 131072 pages, LIFO batch:31
CPU: All CPU(s) started in SVC mode.
PERCPU: Embedded 8 pages/cpu @9fbe1000 s8960 r8192 d15616 u32768
pcpu-alloc: s8960 r8192 d15616 u32768 alloc=8*4096
pcpu-alloc: [0] 0
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
Kernel command line: console=ttymxc0,115200 root=/dev/nfs ip=dhcp nfsroot=192.16
8.0.25:/tftpboot/rfs,v3,tcp earlyprintk
PID hash table entries: 2048 (order: 1, 8192 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 505424K/524288K available (6043K kernel code, 366K rwdata, 1992K rodata,
 308K init, 5505K bss, 18864K reserved, 0K highmem)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xa0800000 - 0xff000000   (1512 MB)
    lowmem  : 0x80000000 - 0xa0000000   ( 512 MB)
    pkmap   : 0x7fe00000 - 0x80000000   (   2 MB)
    modules : 0x7f000000 - 0x7fe00000   (  14 MB)
      .text : 0x80008000 - 0x807e0edc   (8036 kB)
      .init : 0x807e1000 - 0x8082e300   ( 309 kB)
      .data : 0x80830000 - 0x8088b900   ( 367 kB)
       .bss : 0x8088b908 - 0x80debdb0   (5506 kB)
------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at mm/slub.c:1511 __kmem_cache_create+0x24c/0x318()
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 3.13.0-next-20140124 #685
Backtrace:
[<8001235c>] (dump_backtrace) from [<800124f8>] (show_stack+0x18/0x1c)
 r6:800da30c r5:00000009 r4:00000000 r3:00000000
[<800124e0>] (show_stack) from [<805e56d8>] (dump_stack+0x80/0x9c)
[<805e5658>] (dump_stack) from [<80027834>] (warn_slowpath_common+0x70/0x94)
 r4:00000000 r3:8083bcf0
[<800277c4>] (warn_slowpath_common) from [<8002787c>] (warn_slowpath_null+0x24/0
x2c)
 r8:80dbeb18 r7:00002000 r6:80821c94 r5:9ffd8000 r4:9f000000
[<80027858>] (warn_slowpath_null) from [<800da30c>] (__kmem_cache_create+0x24c/0
x318)
[<800da0c0>] (__kmem_cache_create) from [<80801d34>] (create_boot_cache+0x50/0x7
8)
 r10:9fffcb80 r9:412fc085 r8:80838880 r7:80821d08 r6:8073e360 r5:80821c94
 r4:0000002c
[<80801ce4>] (create_boot_cache) from [<80803544>] (kmem_cache_init+0x3c/0xe0)
 r6:80dbeb14 r5:80821c94 r4:80dc41a4 r3:00002000
[<80803508>] (kmem_cache_init) from [<807e19cc>] (start_kernel+0x198/0x384)
 r8:80838880 r7:8081f4c0 r6:ffffffff r5:8088b940 r4:00000001
[<807e1834>] (start_kernel) from [<90008074>] (0x90008074)
 r10:00000000 r8:90004059 r7:8083d3ac r6:8081f4bc r5:80838928 r4:10c53c7d
---[ end trace 3406ff24bd97382e ]---
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1


Any ideas?

Regards,

Fabio Estevam
