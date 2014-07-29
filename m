From: ken.wilson@opengear.com (Ken Wilson)
Date: Tue, 29 Jul 2014 11:14:12 +1000
Subject: CPU1 fails to boot on Armada 375 DB with 3.16.0-rc6
Message-ID: <53D6F564.5070803@opengear.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
We're running 3.16.0-rc6 on our Rev 2 Armada 375 DB, and we've found 
that the second CPU is not coming up.
Are there any known issues here?

I've also tried starting the 2nd CPU after boot using the sysfs 
interface, but I get the same error.
We're tftpbooting the kernel, using an in-memory ramdisk

Snip from dmesg:

Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0x0
Linux version 3.16.0-rc6-dirty (kenw at build-ken) (gcc version 4.8.1 (GCC) 
) #7 SMP Tue Jul 29 09:47:30 EST 2014
CPU: ARMv7 Processor [414fc091] revision 1 (ARMv7), cr=10c5387d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine model: Marvell Armada 375 Development Board
bootconsole [earlycon0] enabled
Memory policy: Data cache writeback
BUG: mapping for 0xf1012000 at 0xfff12000 out of vmalloc space
CPU: All CPU(s) started in SVC mode.
PERCPU: Embedded 7 pages/cpu @ee7d5000 s7680 r8192 d12800 u32768
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 522768
Kernel command line: console=ttyS0,115200 earlyprintk root=/dev/ram
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2063736K/2097152K available (4932K kernel code, 259K rwdata, 
1324K rodata, 235K init, 205K bss, 33416K reserved, 1318912K highmem)
Virtual kernel memory layout:
     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
     fixmap  : 0xffc00000 - 0xffe00000   (2048 kB)
     vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
     lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
       .text : 0xc0008000 - 0xc06242d0   (6257 kB)
       .init : 0xc0625000 - 0xc065fe00   ( 236 kB)
       .data : 0xc0660000 - 0xc06a0e80   ( 260 kB)
        .bss : 0xc06a0e80 - 0xc06d43c0   ( 206 kB)
Hierarchical RCU implementation.
     RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.
RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
NR_IRQS:16 nr_irqs:16 16
L2C-310 enabling early BRESP for Cortex-A9
L2C-310 full line of zeros enabled for Cortex-A9
L2C-310 dynamic clock gating enabled, standby mode enabled
L2C-310 cache controller enabled, 8 ways, 256 kB
L2C-310: CACHE_ID 0x410054c9, AUX_CTRL 0x46040001
sched_clock: 32 bits at 6MHz, resolution 160ns, wraps every 687194767200ns
Console: colour dummy device 80x30
Calibrating delay loop... 1594.16 BogoMIPS (lpj=7970816)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
CPU: Testing write buffer coherency: ok
CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
Setting up static identity map for 0x4af758 - 0x4af7b0
mvebu-soc-id: MVEBU SoC ID=0x6720, Rev=0x3
Booting CPU 1
CPU1: failed to come online
Brought up 1 CPUs
SMP: Total of 1 processors activated.
CPU: All CPU(s) started in SVC mode.
