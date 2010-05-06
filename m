From: rk.raggit@gmail.com (RK Raggit)
Date: Thu, 6 May 2010 16:00:12 +0530
Subject: cortex-m3 booting failure
Message-ID: <h2zec1f3d401005060330n22178e21ve22265bd37006825@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin/others,

I am trying to boot the linux kernel with my baseport built on top of your
architecture port (taken from this link
http://www.linux-arm.org/LinuxKernel/LinuxM3) on
my cortex-m3 based target FPGA.

kernel and busybox are compiled with the Sourcery G++ Lite 2009q3-66
toolset and i
am using an initramfs filesystem. My target has 4MB of RAM. I get the
following bootlog -

--------------------
Linux version 2.6.28-arm2 (raghun at PINGU) (gcc version 4.4.1 (Sourcery
G++ Lite 2009q3-66) ) #1 Thu M
ay 6 15:43:55 IST 2010
CPU: ARMv7-M Processor [411fc231] revision 1 (ARMv?(11)M)
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: STM STICE
Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 1016
Kernel command line: init=/bin/sh console=ttyAMA0,115200n8 mem=4M user_debug=31
PID hash table entries: 16 (order: 4, 64 bytes)
Dentry cache hash table entries: 1024 (order: 0, 4096 bytes)
Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
Memory: 4MB = 4MB total
Memory: 3376KB available (444K code, 48K data, 112K init)
Calibrating delay loop... 5.44 BogoMIPS (lpj=27200)
Mount-cache hash table entries: 512
Serial: AMBA PL011 UART driver
stice-uart0: ttyAMA0 at MMIO 0x4e000000 (irq = 13) is a AMBA/PL011
console [ttyAMA0] enabled
Freeing init memory: 112K
?CPU: 0    Not tainted  (2.6.28-arm2 #1)
PC is at 0x180044
LR is at 0x0
pc : [<00180044>]    lr : [<00000000>]    psr: 00000000
sp : 001bff98  ip : 00000000  fp : 00000000
r10: 001991ec  r9 : 00000000  r8 : 00000000
r7 : 00000000  r6 : 00000000  r5 : 00000000  r4 : 00180044
r3 : 00000000  r2 : 001bffcc  r1 : 001bffc4  r0 : 00000000
Flags: nzcv  IRQs on  FIQs on  Mode USER_26  ISA ARM  Segment kernel
----------------

It looks like the first userspace process is crashing but i do not get
any log (though
i have user debug enabled). A few times though i do manage to get the
serial console prompt
but when i try to execute any simple command (like 'ls') then i see
the same crash as above.

I am wondering what could be happening here.One possibility could be
that busybox is not built
properly but that seems less likely since i am using the standard
code-sourcery toolchain.
Could lack of memory be an issue ? ...but ~3.3MB seems good enough.

Your thoughts ?


Regards
RK
