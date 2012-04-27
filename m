From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 27 Apr 2012 10:28:53 +0800
Subject: [PATCH v2] Convert i.MX architecture to generic clock framework
In-Reply-To: <4F995657.4080505@de.bosch.com>
References: <1335367703-19929-1-git-send-email-s.hauer@pengutronix.de>
 <4F995657.4080505@de.bosch.com>
Message-ID: <20120427022851.GC2234@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2012 at 04:06:15PM +0200, Dirk Behme wrote:
> >git://git.pengutronix.de/git/imx/linux-2.6.git work/v3.4-rc4-imx-clk
> 
> Booting this on top of a 3.4-rc4 on a i.MX6 SabreLite gives me
> 
What do you mean "on top of a 3.4-rc4"?  Sascha's branch is built up
on v3.4-rc4.

> ..
> Linux video capture interface: v2.00
> Switching to clocksource mxc_timer1
> Clockevents: could not switch to one-shot mode:
> Clockevents: could not switch to one-shot mode:
> Clockevents: could not switch to one-shot mode: dummy_timer is not
> functional.
>  dummy_timer is not functional.
> Clockevents: could not switch to one-shot mode:
> Could not switch to high resolution mode on CPU 0
>  dummy_timer is not functional.
> Could not switch to high resolution mode on CPU 2
> Could not switch to high resolution mode on CPU 1
>  dummy_timer is not functional.
> Could not switch to high resolution mode on CPU 3
> NET: Registered protocol family 2
> ...
> 
> I'm no expert of this, so just in case this is interesting for somebody.
> 
I just booted my sabrelite board using Sascha's branch and can not
reproduce it.

Regards,
Shawn

---
Booting Linux on physical CPU 0
Linux version 3.4.0-rc4+ (r65073 at S2101-09) (gcc version 4.6.1 (Ubuntu/Linaro 4.6
.1-9ubuntu3) ) #124 SMP Fri Apr 27 09:38:02 CST 2012
CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c53c7d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine: Freescale i.MX6 Quad (Device Tree), model: Freescale i.MX6 Quad SABRE L
ite Board
Memory policy: ECC disabled, Data cache writealloc
On node 0 totalpages: 262144
free_area_init_node: node 0, pgdat 80594600, node_mem_map 805ea000
  Normal zone: 2048 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 260096 pages, LIFO batch:31
PERCPU: Embedded 7 pages/cpu @80df5000 s5440 r8192 d15040 u32768
pcpu-alloc: s5440 r8192 d15040 u32768 alloc=8*4096
pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260096
Kernel command line: console=ttymxc1,115200 debug earlyprintk root=/dev/mmcblk0p
3 rootwait
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1024MB = 1024MB total
Memory: 1031908k/1031908k available, 16668k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xc0800000 - 0xff000000   (1000 MB)
    lowmem  : 0x80000000 - 0xc0000000   (1024 MB)
    modules : 0x7f000000 - 0x80000000   (  16 MB)
      .text : 0x80008000 - 0x80503000   (5100 kB)
      .init : 0x80503000 - 0x80548540   ( 278 kB)
      .data : 0x8054a000 - 0x80594f80   ( 300 kB)
       .bss : 0x80594fa4 - 0x805e9ff8   ( 341 kB)
SLUB: Genslabs=11, HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
Hierarchical RCU implementation.
NR_IRQS:436
L310 cache controller enabled
l2x0: 16 ways, CACHE_ID 0x410000c7, AUX_CTRL 0x02070000, Cache size: 1048576 B
sched_clock: 32 bits at 66MHz, resolution 15ns, wraps every 65075ms
Console: colour dummy device 80x30
Calibrating delay loop... 1581.05 BogoMIPS (lpj=7905280)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
Setting up static identity map for 0x103e7588 - 0x103e75f8
CPU1: Booted secondary processor
CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
CPU2: Booted secondary processor
CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
CPU3: Booted secondary processor
CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
Brought up 4 CPUs
SMP: Total of 4 processors activated (6324.22 BogoMIPS).
.....
