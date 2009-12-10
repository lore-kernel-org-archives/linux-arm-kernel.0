From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Thu, 10 Dec 2009 20:11:32 +0100
Subject: MXC: mx31pdk: mc13783: Trying to full support mc13783 regulators
In-Reply-To: <1260470224.2141.37.camel@climbing-alby>
References: <1260470224.2141.37.camel@climbing-alby>
Message-ID: <1260472292.2141.64.camel@climbing-alby>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Oh! I forget! I am testing this without the personality board!
and this is a typical kernel debug output:

Uncompressing
Linux..........................................................................................................................................
Linux version 2.6.32-rc6-g7eeda2b-dirty (alberto at climbing-alby) (gcc
version 4.3.2 (OSELAS.Toolchain-1.99.3) ) #99 PREEMPT Thu Dec 10
18:59:37 CET 2009
CPU: ARMv6-compatible processor [4107b364] revision 4 (ARMv6TEJ),
cr=00c5387f
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: Freescale MX31PDK (3DS)
Memory policy: ECC disabled, Data cache writeback
On node 0 totalpages: 32768
free_area_init_node: node 0, pgdat c053e0e4, node_mem_map c0a8c000
  Normal zone: 256 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 32512 pages, LIFO batch:7
Built 1 zonelists in Zone order, mobility grouping on.  Total pages:
32512
Kernel command line: console= tty0 console=ttymxc0  debug
PID hash table entries: 512 (order: -1, 2048 bytes)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 128MB = 128MB total
Memory: 118996KB available (3520K code, 7027K data, 112K init, 0K
highmem)
Hierarchical RCU implementation.
NR_IRQS:180
MXC GPIO hardware
MXC IRQ initialized
Clock input source is 26000000
CPU identified as i.MX31, silicon rev 2.0
Console: colour dummy device 80x30
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:  8
... MAX_LOCK_DEPTH:          48
... MAX_LOCKDEP_KEYS:        8191
... CLASSHASH_SIZE:          4096
... MAX_LOCKDEP_ENTRIES:     16384
... MAX_LOCKDEP_CHAINS:      32768
... CHAINHASH_SIZE:          16384
 memory used by lock dependency info: 3951 kB
 per task-struct memory footprint: 2304 bytes
Calibrating delay loop... 529.20 BogoMIPS (lpj=2646016)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
------------[ cut here ]------------
WARNING: at kernel/lockdep.c:3154 check_flags+0xc0/0x1d4()
Modules linked in:
[<c002aa50>] (unwind_backtrace+0x0/0xdc) from [<c003db08>]
(warn_slowpath_common+0x4c/0x80)
[<c003db08>] (warn_slowpath_common+0x4c/0x80) from [<c005fdbc>]
(check_flags+0xc0/0x1d4)
[<c005fdbc>] (check_flags+0xc0/0x1d4) from [<c006527c>] (lock_acquire
+0x40/0x98)
[<c006527c>] (lock_acquire+0x40/0x98) from [<c02b2670>] (_spin_lock
+0x40/0x78)
[<c02b2670>] (_spin_lock+0x40/0x78) from [<c00a3670>] (set_task_comm
+0x18/0x34)
[<c00a3670>] (set_task_comm+0x18/0x34) from [<c0052730>] (kthreadd
+0x24/0xf4)
[<c0052730>] (kthreadd+0x24/0xf4) from [<c0025f78>] (kernel_thread_exit
+0x0/0x8)
---[ end trace 1b75b31a2719ed1c ]---
possible reason: unannotated irqs-on.
irq event stamp: 1
hardirqs last  enabled at (0): [<(null)>] (null)
hardirqs last disabled at (1): [<c0024fcc>] ret_slow_syscall+0xc/0x1c
softirqs last  enabled at (0): [<c003c548>] copy_process+0x35c/0xec4
softirqs last disabled at (0): [<(null)>] (null)
regulator: core version 0.5
NET: Registered protocol family 16
i.MX31PDK Debug board detected, rev = 0x0200
L2X0 cache controller enabled
bio: create slab <bio-0> at 0
Switching to clocksource mxc_timer1
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 5, 163840 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
NET: Registered protocol family 1
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
JFFS2 version 2.2. (NAND) ?? 2001-2006 Red Hat, Inc.
msgmni has been set to 232
alg: No test for stdrng (krng)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Serial: IMX driver
imx-uart.0: ttymxc0 at MMIO 0x43f90000 (irq = 45) is a IMX
Serial: Console IMX rounded baud rate from 115201 to 115200
console [ttymxc0] enabled
NAND device: Manufacturer ID: 0xec, Chip ID: 0xaa (Samsung NAND 256MiB
1,8V 8-bit)
Scanning device for bad blocks
Bad eraseblock 55 at 0x0000006e0000
Bad eraseblock 115 at 0x000000e60000
Bad eraseblock 116 at 0x000000e80000
Bad eraseblock 117 at 0x000000ea0000
Bad eraseblock 118 at 0x000000ec0000
Bad eraseblock 119 at 0x000000ee0000
Bad eraseblock 120 at 0x000000f00000
Bad eraseblock 1688 at 0x00000d300000
Bad eraseblock 1735 at 0x00000d8e0000
Bad eraseblock 1742 at 0x00000d9c0000
Searching for RedBoot partition table in mxc_nand at offset 0x80000
5 RedBoot partitions found on MTD device mxc_nand
Creating 5 MTD partitions on "mxc_nand":
0x000000000000-0x000000040000 : "RedBoot"
0x000000080000-0x00000009f000 : "FIS directory"
mtd: partition "FIS directory" doesn't end on an erase block -- force
read-only
0x00000009f000-0x0000000a0000 : "RedBoot config"
mtd: partition "RedBoot config" doesn't start on an erase block boundary
-- force read-only
0x000000100000-0x000000500000 : "kernel"
0x000000600000-0x000002ac0000 : "root"
spi_imx_setup: mode 4, 8 bpw, 500000 hz
spi_imx_setup: mode 4, 32 bpw, 500000 hz
mc13783 spi1.1: MC13783 Rev 3.3 FinVer 0 detected
mc13783_write frame: 0x80ffffff
mc13783_write frame: 0x82ffffff
mc13783_write frame: 0x86ffffff
mc13783_write frame: 0x88ffffff
mc13783_set_bits reg: 1, mask: 0x1, val: 0x0
mc13783_set_bits read ret: 0, tmp: 0xe9ffff
mc13783_write frame: 0x82e9fffe
mc13783_set_bits write ret: 0, tmp: 0xe9fffe
mc13783_set_bits done
mc13783-regulator mc13783-regulator: mc13783_regulator_probe id -1
mc13783_set_bits reg: 32, mask: 0x492412, val: 0x492412
mc13783_set_bits read ret: 0, tmp: 0x249249
mc13783_write frame: 0xc06db65b
mc13783_set_bits write ret: 0, tmp: 0x6db65b
mc13783_set_bits done
mc13783_set_bits reg: 33, mask: 0x492492, val: 0x492492
mc13783_set_bits read ret: 0, tmp: 0x249240
mc13783_write frame: 0xc26db6d2
mc13783_set_bits write ret: 0, tmp: 0x6db6d2
mc13783_set_bits done
mc13783_set_bits reg: 29, mask: 0x200000, val: 0x200000
mc13783_set_bits read ret: 0, tmp: 0x1e1605
mc13783_write frame: 0xba3e1605
mc13783_set_bits write ret: 0, tmp: 0x3e1605
mc13783_set_bits done
regulator regulator.0: mc13783_set_voltage id: 0 min_uV: 1625000 max_uV:
1625000
regulator regulator.0: mc13783_set_voltage n_voltages: 64 
regulator regulator.0: mc13783_set_voltage best value: 29 
regulator regulator.0: mc13783_set_voltage id: 0 best index: 29
mc13783_set_bits reg: 24, mask: 0x3f, val: 0x1d
mc13783_set_bits read ret: 0, tmp: 0x1c71c
mc13783_write frame: 0xb001c71d
mc13783_set_bits write ret: 0, tmp: 0x1c71d
mc13783_set_bits done
regulator regulator.0: mc13783_enable id: 0
regulator: SW_SW1A: 1625 mV 
regulator regulator.1: mc13783_enable id: 1
regulator: SW_SW1B: 1200 <--> 2200 mV 
regulator regulator.2: mc13783_enable id: 2
regulator: SW_SW2A: 1200 <--> 2200 mV 
regulator regulator.3: mc13783_enable id: 3
regulator: SW_SW2B: 1200 <--> 2200 mV 
regulator regulator.4: mc13783_enable id: 4
mc13783_set_bits reg: 29, mask: 0x100000, val: 0x100000
mc13783_set_bits read ret: 0, tmp: 0x3e1605
mc13783_write frame: 0xba3e1605
mc13783_set_bits write ret: 0, tmp: 0x3e1605
mc13783_set_bits done
regulator regulator.4: mc13783_enable ret: 0
regulator: SW_SW3: 5000 <--> 5500 mV 
regulator: REGU_VVIB: 1300 <--> 3000 mV 
set_machine_constraints: override 'REGU_VAUDIO' min_uV, 1 -> 2775000
set_machine_constraints: override 'REGU_VAUDIO' max_uV, 2147483647 ->
2775000
regulator regulator.6: mc13783_enable id: 6
mc13783_set_bits reg: 32, mask: 0x1, val: 0x1
mc13783_set_bits read ret: 0, tmp: 0x6db65b
mc13783_write frame: 0xc06db65b
mc13783_set_bits write ret: 0, tmp: 0x6db65b
mc13783_set_bits done
regulator regulator.6: mc13783_enable ret: 0
regulator: REGU_VAUDIO: 2775 mV 
set_machine_constraints: override 'REGU_VIOHI' min_uV, 1 -> 2775000
set_machine_constraints: override 'REGU_VIOHI' max_uV, 2147483647 ->
2775000
regulator regulator.7: mc13783_enable id: 7
mc13783_set_bits reg: 32, mask: 0x8, val: 0x8
mc13783_set_bits read ret: 0, tmp: 0x6db65b
mc13783_write frame: 0xc06db65b
mc13783_set_bits write ret: 0, tmp: 0x6db65b
mc13783_set_bits done
regulator regulator.7: mc13783_enable ret: 0
regulator: REGU_VIOHI: 2775 mV 
regulator regulator.8: mc13783_enable id: 8
mc13783_set_bits reg: 32, mask: 0x40, val: 0x40
mc13783_set_bits read ret: 0, tmp: 0x6db65b
mc13783_write frame: 0xc06db65b
mc13783_set_bits write ret: 0, tmp: 0x6db65b
mc13783_set_bits done
regulator regulator.8: mc13783_enable ret: 0
regulator: REGU_VIOLO: 1200 <--> 1800 mV 
regulator regulator.9: mc13783_enable id: 13
mc13783_set_bits reg: 32, mask: 0x200000, val: 0x200000
mc13783_set_bits read ret: 0, tmp: 0x6db65b
mc13783_write frame: 0xc06db65b
mc13783_set_bits write ret: 0, tmp: 0x6db65b
mc13783_set_bits done
regulator regulator.9: mc13783_enable ret: 0
regulator: REGU_VRFCP: 2700 <--> 2775 mV 
regulator regulator.10: mc13783_enable id: 9
mc13783_set_bits reg: 32, mask: 0x200, val: 0x200
mc13783_set_bits read ret: 0, tmp: 0x6db65b
mc13783_write frame: 0xc06db65b
mc13783_set_bits write ret: 0, tmp: 0x6db65b
mc13783_set_bits done
regulator regulator.10: mc13783_enable ret: 0
regulator: REGU_VDIG: 1200 <--> 1800 mV 
regulator regulator.11: mc13783_set_voltage id: 10 min_uV: 1800000
max_uV: 1800000
regulator regulator.11: mc13783_set_voltage n_voltages: 8 
regulator regulator.11: mc13783_set_voltage best value: 3 
regulator regulator.11: mc13783_set_voltage id: 10 best index: 3
mc13783_set_bits reg: 30, mask: 0x1c0, val: 0xc0
mc13783_set_bits read ret: 0, tmp: 0x63eac
mc13783_write frame: 0xbc063eec
mc13783_set_bits write ret: 0, tmp: 0x63eec
mc13783_set_bits done
regulator regulator.11: mc13783_enable id: 10
mc13783_set_bits reg: 32, mask: 0x1000, val: 0x1000
mc13783_set_bits read ret: 0, tmp: 0x6db65b
mc13783_write frame: 0xc06db65b
mc13783_set_bits write ret: 0, tmp: 0x6db65b
mc13783_set_bits done
regulator regulator.11: mc13783_enable ret: 0
regulator: REGU_VGEN: 1800 mV 
regulator regulator.12: mc13783_enable id: 11
mc13783_set_bits reg: 32, mask: 0x8000, val: 0x8000
mc13783_set_bits read ret: 0, tmp: 0x6db65b
mc13783_write frame: 0xc06db65b
mc13783_set_bits write ret: 0, tmp: 0x6db65b
mc13783_set_bits done
regulator regulator.12: mc13783_enable ret: 0
regulator: REGU_VRFDIG: 1200 <--> 1875 mV 
regulator regulator.13: mc13783_enable id: 12
mc13783_set_bits reg: 32, mask: 0x40000, val: 0x40000
mc13783_set_bits read ret: 0, tmp: 0x6db65b
mc13783_write frame: 0xc06db65b
mc13783_set_bits write ret: 0, tmp: 0x6db65b
mc13783_set_bits done
regulator regulator.13: mc13783_enable ret: 0
regulator: REGU_VRFREF: 2475 <--> 2775 mV 
regulator: REGU_VSIM: 1800 <--> 2900 mV 
regulator: REGU_VESIM: 1800 <--> 2900 mV 
regulator: REGU_VCAM: 1500 <--> 3000 mV 
regulator regulator.17: mc13783_enable id: 19
mc13783_set_bits reg: 33, mask: 0x1000, val: 0x1000
mc13783_set_bits read ret: 0, tmp: 0x6db6d2
mc13783_write frame: 0xc26db6d2
mc13783_set_bits write ret: 0, tmp: 0x6db6d2
mc13783_set_bits done
regulator regulator.17: mc13783_enable ret: 0
regulator: REGU_VRF1: 1500 <--> 2775 mV 
regulator regulator.18: mc13783_enable id: 20
mc13783_set_bits reg: 33, mask: 0x8000, val: 0x8000
mc13783_set_bits read ret: 0, tmp: 0x6db6d2
mc13783_write frame: 0xc26db6d2
mc13783_set_bits write ret: 0, tmp: 0x6db6d2
mc13783_set_bits done
regulator regulator.18: mc13783_enable ret: 0
regulator: REGU_VRF2: 1500 <--> 2775 mV 
regulator: REGU_VMMC1: 1600 <--> 3000 mV 
regulator: REGU_VMMC2: 1600 <--> 3000 mV 
regulator: REGU_GPO3: 0 mV 
regulator regulator.22: reg: 0, val: 0
regulator regulator.22: reg: 1, val: e9fffe
regulator regulator.22: reg: 2, val: 8d840
regulator regulator.22: reg: 3, val: 0
regulator regulator.22: reg: 4, val: ffffff
regulator regulator.22: reg: 5, val: 4838
regulator regulator.22: reg: 6, val: 9c46
regulator regulator.22: reg: 7, val: 9b
regulator regulator.22: reg: 8, val: 0
regulator regulator.22: reg: 9, val: 0
regulator regulator.22: reg: 10, val: 0
regulator regulator.22: reg: 11, val: 0
regulator regulator.22: reg: 12, val: 0
regulator regulator.22: reg: 13, val: 40
regulator regulator.22: reg: 14, val: 0
regulator regulator.22: reg: 15, val: 0
regulator regulator.22: reg: 16, val: 200000
regulator regulator.22: reg: 17, val: 0
regulator regulator.22: reg: 18, val: 0
regulator regulator.22: reg: 19, val: 0
regulator regulator.22: reg: 20, val: 10
regulator regulator.22: reg: 21, val: 1ffff
regulator regulator.22: reg: 22, val: 0
regulator regulator.22: reg: 23, val: 7fff
regulator regulator.22: reg: 24, val: 1c71d
regulator regulator.22: reg: 25, val: 1c71c
regulator regulator.22: reg: 26, val: 24924
regulator regulator.22: reg: 27, val: 24924
regulator regulator.22: reg: 28, val: 221605
regulator regulator.22: reg: 29, val: 3e1605
regulator regulator.22: reg: 30, val: 63eec
regulator regulator.22: reg: 31, val: b7c
regulator regulator.22: reg: 32, val: 6db65b
regulator regulator.22: reg: 33, val: 6db6d2
regulator regulator.22: reg: 34, val: 18000
regulator regulator.22: reg: 35, val: 0
regulator regulator.22: reg: 36, val: 1000
regulator regulator.22: reg: 37, val: d35a
regulator regulator.22: reg: 38, val: 420000
regulator regulator.22: reg: 39, val: 13060
regulator regulator.22: reg: 40, val: 180027
regulator regulator.22: reg: 41, val: e0004
regulator regulator.22: reg: 42, val: 0
regulator regulator.22: reg: 43, val: 8000
regulator regulator.22: reg: 44, val: 0
regulator regulator.22: reg: 45, val: ffffff
regulator regulator.22: reg: 46, val: 80
regulator regulator.22: reg: 47, val: 0
regulator regulator.22: reg: 48, val: 0
regulator regulator.22: reg: 49, val: e0060
regulator regulator.22: reg: 50, val: 6
regulator regulator.22: reg: 51, val: 0
regulator regulator.22: reg: 52, val: 0
regulator regulator.22: reg: 53, val: 0
regulator regulator.22: reg: 54, val: 0
regulator regulator.22: reg: 55, val: 0
regulator regulator.22: reg: 56, val: 0
regulator regulator.22: reg: 57, val: 0
regulator regulator.22: reg: 58, val: 0
regulator regulator.22: reg: 59, val: 0
regulator regulator.22: reg: 60, val: 0
regulator regulator.22: reg: 61, val: 0
regulator regulator.22: reg: 62, val: 0
regulator regulator.22: reg: 63, val: 0
regulator regulator.22: mc13783_enable id: 23
mc13783_set_bits reg: 34, mask: 0x40, val: 0x40
mc13783_set_bits read ret: 0, tmp: 0x18000
mc13783_write frame: 0xc4018040




No more message.
I have modified the mc13783_write function (function that write
something in mc13783 registers) to light a debug led at the beginning
and to shout down it before return. 
This led at the remain on -> no strange interference with serial output,
the cpu is really hanged.

And, another important: all GPOn enabling call, enable the corresponding
output before freezing.
