From: shariffsmailbox@gmail.com (Shariff Md)
Date: Wed, 19 Dec 2012 12:17:49 +0530
Subject: ARM-cortex 9: Want to enable watchdog interrupt ID30 as FIQ and rest
 all interrupts as IRQ
Message-ID: <CAFRvuB75sJCdd-iYDQFTMB8ygK0d0HvuVYJbcV80Huc4h+MFeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Our development board is based on ARM cortex a9 with linux-2.6.28.

Our requirement is to enable watchdog interrupt ID(30) as FIQ and rest all
interrupts as IRQ.

For this, I configured all interrupts as Non secure interrupts except
watchdog interrupt(which
was configured as secured). With this change linux kernel has hanged(Kernel
log below after
hang).

I made watchdog interrupt as Secure interrupt to enable secure interrupt as
FIQ with "ICCICR"
register.

Does making all interrupts as Non secure interrupt will not work?

Kernel bootup hang log:
-----------------------
Linux version 2.6.28.10-arm2-1.82.1-rc11 (turner at debian) (gcc version 4.3.2
(Sourcery G++ Lite
2008q3-72) ) #22 SMP Tue Dec 18 20:33:49 IST 2012
CPU: ARMv7 Processor [411fc090] revision 0 (ARMv7), cr=10c53c7f
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: Transcede
Device revision: x7
Memory policy: ECC disabled, Data cache writealloc
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
Kernel command line: root=/dev/mtdblock3 rootfstype=jffs2 rw mem=512M
earlycon=uart8250,mmio,0xfe092000,115200n8 console=ttyS0 user_debug=11
panic=10
Early serial console at MMIO 0xfe092000 (options '115200n8')
console [uart0] enabled
PID hash table entries: 2048 (order: 11, 8192 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 512MB = 512MB total
Memory: 514560KB available (4224K code, 355K data, 132K init)
Calibrating delay loop...

Regards,
Shariff
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121219/479d4ebf/attachment-0001.html>
