From: horms@verge.net.au (Simon Horman)
Date: Fri, 12 Apr 2013 10:23:50 +0900
Subject: [PATCH v4 7/7] ARM: mach-shmobile: r8a7740: Setup the timer
 CMT10 using DT
In-Reply-To: <1365679443-25456-7-git-send-email-hechtb+renesas@gmail.com>
References: <1365679443-25456-1-git-send-email-hechtb+renesas@gmail.com>
 <1365679443-25456-7-git-send-email-hechtb+renesas@gmail.com>
Message-ID: <20130412012350.GA25941@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 01:24:03PM +0200, Bastian Hecht wrote:
> We can now use the Device Tree for bringing up our timer device CMT10 on
> the SoC r8a7740.

Hi Bastian,

unfortunately with this patch the armaillo800eva no longer boots.

I am testing  against renesas-next-20130411v2 with the other
6 patches in this series applied. I am using the armadillo800eva defconfig.
The boot log is below.

I have also tested kzm9g an kzm9g-reference, they seem fine.


hermit> tftpboot 10.3.5.147 10.3.5.146 --kernel=armadillo/zImage
initializing net-device...OK

Client: 10.3.5.147
Server: 10.3.5.146
Region(kernel): armadillo/zImage

Filename : armadillo/zImage
......................................................................................................................................................................................................................................................................................................................................................................................................................................................
Filesize : 2240001

Copying kernel:net.........done.
Doing console=tty0
Doing console=ttySC1,115200
Doing earlyprintk=sh-sci.1,115200
Doing ignore_loglevel
Doing root=/dev/nfs
Doing ip=dhcp
Doing nfsroot=,rsize=4096,wsize=4096
Doing rw
Booting Linux on physical CPU 0x0
Linux version 3.9.0-rc2-00007-g92bd9f5 (horms at ayumi.isobedori.kobe.vergenet.net) (gcc version 4.4.5 (Debian 4.4.5-8) ) #1698 Fri Apr 12 10:21:28 JST 2013
CPU: ARMv7 Processor [412fc093] revision 3 (ARMv7), cr=10c53c7d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine: armadillo800eva, model: armadillo 800 eva
debug: ignoring loglevel setting.
Memory policy: ECC disabled, Data cache writeback
On node 0 totalpages: 131072
free_area_init_node: node 0, pgdat c0459e1c, node_mem_map c067e000
  Normal zone: 1024 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 131072 pages, LIFO batch:31
CPU: All CPU(s) started in SVC mode.
bootconsole [early_ttySC1] enabled
pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
pcpu-alloc: [0] 0 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
Kernel command line: console=tty0 console=ttySC1,115200 earlyprintk=sh-sci.1,115200 ignore_loglevel root=/dev/nfs ip=dhcp nfsroot=,rsize=4096,wsize=4096 rw
PID hash table entries: 2048 (order: 1, 8192 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
__ex_table already sorted, skipping sort
Memory: 512MB = 512MB total
Memory: 515124k/515124k available, 9164k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xe0800000 - 0xff000000   ( 488 MB)
    lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .text : 0xc0008000 - 0xc040702c   (4093 kB)
      .init : 0xc0408000 - 0xc042b468   ( 142 kB)
      .data : 0xc042c000 - 0xc045a600   ( 186 kB)
       .bss : 0xc045a600 - 0xc0482624   ( 161 kB)
NR_IRQS:16 nr_irqs:16 16
GIC CPU mask not found - kernel will fail to boot.
GIC CPU mask not found - kernel will fail to boot.
sched_clock: 32 bits at 128 Hz, resolution 7812500ns, wraps every 3489660920ms
Console: colour dummy device 80x30
console [tty0] enabled
Calibrating delay loop... 
