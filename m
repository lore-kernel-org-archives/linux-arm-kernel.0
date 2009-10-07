From: saurabhkadekodi@gmail.com (Saurabh Kadekodi)
Date: Wed, 7 Oct 2009 17:23:40 +0530
Subject: Problem in booting off a pxa270 board
In-Reply-To: <967093cd0910070357w2c603fefn5ea386f6c6c757e5@mail.gmail.com>
References: <967093cd0910070357w2c603fefn5ea386f6c6c757e5@mail.gmail.com>
Message-ID: <967093cd0910070453m28edef9v9127d271d20fbd76@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

I have pxa270 based board, and I've just recently put an
emdebian-crush root filesystem image on it. On booting the board I get
upto the point where it starts init and then it fails for some
subsequent processes.

I would be grateful if someone could enlighten why this could be happening.

Here's the bootup log:

RedBoot> clock -L 16 -N 5
RedBoot> mount -t jffs2 -f filesystem
RedBoot> load -r -b %{FREEMEMLO} %{kernel}
Using default protocol (file)
Raw file loaded 0x00400000-0x004d0df7, assumed entry at 0x00400000
RedBoot> exec -c %{cmdline}
Using base address 0x00400000 and length 0x000d0df8
Uncompressing Linux.........................................................
done, booting the kernel.
Linux version 2.6.16.28(gcc version 3.4.4) #1 Wed Apr 25 15:39:08 BST 2007
CPU: XScale-PXA270 [69054117] revision 7 (ARMv5TE)
Memory policy: ECC disabled, Data cache writeback
Run Mode clock: 208.00MHz (*16)
Turbo Mode clock: 520.00MHz (*2.5, active)
Memory clock: 208.00MHz (/2)
System bus clock: 208.00MHz
CPU0: D VIVT undefined 5 cache
CPU0: I cache: 32768 bytes, associativity 32, 32 byte lines, 32 sets
CPU0: D cache: 32768 bytes, associativity 32, 32 byte lines, 32 sets
Built 1 zonelists
Kernel command line: console=ttyS0,115200 rootfstype=jffs2
root=/dev/mtdblock1 ro
Map ISA IRQ 3 to IRQ 160
Map ISA IRQ 4 to IRQ 161
Map ISA IRQ 5 to IRQ 162
Map ISA IRQ 6 to IRQ 163
Map ISA IRQ 7 to IRQ 164
Map ISA IRQ 10 to IRQ 165
Map ISA IRQ 11 to IRQ 166
Map ISA IRQ 12 to IRQ 167
PID hash table entries: 1024 (order: 10, 16384 bytes)
Console: colour dummy device 80x30
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 64MB 64MB = 128MB total
Memory: 127856KB available (1416K code, 301K data, 64K init)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
NetWinder Floating Point Emulator V0.97 (double precision)
JFFS2 version 2.2. (C) 2001-2003 Red Hat, Inc.
Initializing Cryptographic API
io scheduler noop registered
io scheduler deadline registered (default)
Serial: 8250/16550 driver $Revision: 1.90 $ 64 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0x10000000 (irq = 41) is a 16550A
serial8250.0: ttyS1 at MMIO 0x10800000 (irq = 42) is a 16550A
serial8250.0: ttyS2 at MMIO 0x11000000 (irq = 44) is a 16550A
serial8250.0: ttyS3 at MMIO 0x11800000 (irq = 43) is a 16550A
serial8250.0: ttyS4 at MMIO 0x40100000 (irq = 22) is a XScale
serial8250.0: ttyS5 at MMIO 0x40200000 (irq = 21) is a XScale
serial8250.0: ttyS6 at MMIO 0x40700000 (irq = 20) is a XScale
dm9000 Ethernet Driver
eth0: dm9000 at d485a000,d485c002 IRQ 46 MAC: 00:80:66:10:d2:32
eth1: dm9000 at d485e000,d4860002 IRQ 145 MAC: 00:80:66:10:d2:33
flash: Found 1 x16 devices at 0x0 in 16-bit bank
?Amd/Fujitsu Extended Query Table at 0x0040
flash: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
cmdlinepart partition parsing not available
Searching for RedBoot partition table in flash at offset 0x1fe0000
4 RedBoot partitions found on MTD device flash
Creating 4 MTD partitions on "flash":
0x00000000-0x00040000 : "RedBoot"
0x00040000-0x01fe0000 : "filesystem"
0x01fe0000-0x01fff000 : "FIS directory"
0x01fff000-0x02000000 : "RedBoot config"
i2c /dev entries driver
I2C: i2c-0: PXA I2C adapter
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
VFS: Mounted root (jffs2 filesystem) readonly.
Freeing init memory: 64K
init started: BusyBox v1.11.1 (2008-08-08 18:56:00 ART)
starting pid 223, tty '': '/etc/init.d/rcS'
process '/sbin/syslogd -n -m 0' (pid 234) exited. Scheduling for restart.
process '/usr/bin/tail -f /var/log/messages' (pid 236) exited.
Scheduling for restart.
process '/sbin/syslogd -n -m 0' (pid 247) exited. Scheduling for restart.
process '/usr/bin/tail -f /var/log/messages' (pid 248) exited.
Scheduling for restart.
process '/sbin/syslogd -n -m 0' (pid 253) exited. Scheduling for restart.
process '/usr/bin/tail -f /var/log/messages' (pid 254) exited.
Scheduling for restart.
process '/sbin/syslogd -n -m 0' (pid 259) exited. Scheduling for restart.
process '/usr/bin/tail -f /var/log/messages' (pid 260) exited.
Scheduling for restart.
process '/sbin/syslogd -n -m 0' (pid 265) exited. Scheduling for restart.
process '/usr/bin/tail -f /var/log/messages' (pid 266) exited.
Scheduling for restart.

This latter part then keeps on recurring indefinately.

Thanks in advance,

Saurabh
