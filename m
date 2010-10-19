From: tbm@cyrius.com (Martin Michlmayr)
Date: Tue, 19 Oct 2010 20:05:34 +0100
Subject: QNAP TS-209 broken by "orion/kirkwood: reset PCIe unit on boot"
Message-ID: <20101019190533.GA11893@jirafa.cyrius.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I noticed that 2.6.36-rc no longer boots on my QNAP TS-209.  I get
some output but then the machine resets.

I've bisected it down to the patch "orion/kirkwood: reset PCIe unit on
boot".  I remember this patch was controversial when it was proposed.
Looks like it breaks at least one orion5x machine.  Maybe the patch
should be reverted for now or only be called on kirkwood.

I remember that Marvell was looking into this issue.  Saeed, have you
had a chance to investigate this more in the meantime?  See
http://marc.info/?l=linux-ide&m=124822863706181&w=2 for the original
problem.



Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Linux version 2.6.36-rc8 (tbm at pergolesi) (gcc version 4.1.3 20080704 (prerelease) (Debian 4.1.2-25)) #91 PREEMPT Tue Oct 19 17:55:31 UTC 2010
CPU: Feroceon [41069260] revision 0 (ARMv5TEJ), cr=a0053177
CPU: VIVT data cache, VIVT instruction cache
Machine: QNAP TS-109/TS-209
Clearing invalid memory bank 0KB at 0x00000000
Clearing invalid memory bank 0KB at 0x00000000
Clearing invalid memory bank 0KB at 0x00000000
Ignoring unrecognised tag 0x00000000
Ignoring unrecognised tag 0x00000000
Ignoring unrecognised tag 0x00000000
Ignoring unrecognised tag 0x41000403
bootconsole [earlycon0] enabled
Memory policy: ECC disabled, Data cache writeback
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
Kernel command line: console=ttyS0,115200n8 root=/dev/sda2 earlyprintk
PID hash table entries: 512 (order: -1, 2048 bytes)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 128MB = 128MB total
Memory: 126240k/126240k available, 4832k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
    vmalloc : 0xc8800000 - 0xfd800000   ( 848 MB)
    lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .init : 0xc0008000 - 0xc0027000   ( 124 kB)
      .text : 0xc0027000 - 0xc0370000   (3364 kB)
      .data : 0xc0370000 - 0xc038da40   ( 119 kB)
SLUB: Genslabs=11, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Hierarchical RCU implementation.
	RCU-based detection of stalled CPUs is disabled.
	Verbose stalled-CPUs detection is disabled.
NR_IRQS:64
Calibrating delay loop... 332.59 BogoMIPS (lpj=1662976)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
Orion ID: MV88F5182-A2. TCLK=166666667.
tsx09: found ethernet mac address 00:08:9b:ac:6a:04.

         __  __                      _ _
        |  \/  | __ _ _ ____   _____| | |
        | |\/| |/ _` | '__\ \ / / _ \ | |
        | |  | | (_| | |   \ V /  __/ | |
        |_|  |_|\__,_|_|    \_/ \___|_|_|
 _   _     ____              _
| | | |   | __ )  ___   ___ | |_ 
| | | |___|  _ \ / _ \ / _ \| __| 
| |_| |___| |_) | (_) | (_) | |_ 
 \___/    |____/ \___/ \___/ \__|  ** LOADER **

 QNAP SYSTEMS, INC.

-- 
Martin Michlmayr
http://www.cyrius.com/
