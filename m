From: horms@verge.net.au (Simon Horman)
Date: Wed, 18 Feb 2015 16:20:45 -0500
Subject: [PATCH v4 0/6] ARM: shmobile: r8a73a4/ape6evm: Complete
 multiplatform support
In-Reply-To: <1424185486-3017-1-git-send-email-geert+renesas@glider.be>
References: <1424185486-3017-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20150218212044.GD12754@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 17, 2015 at 04:04:40PM +0100, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series completes the migration from aep6evm-legacy (legacy board
> code) and ape6evm-reference (legacy DT based) to ape6evm-multiplatform (ARM
> multiplatform DT based with common clock framework).
> 
> It depends on Simon's branch simple-pm-bus-for-v3.21.
> 
>   - The first two patches fix Ethernet on ape6evm, by adding a Bus State
>     Controller node, and moving the Ethernet node to it, and thus depends
>     on Simon's branch simple-pm-bus-for-v3.21,
>   - The third patch moves the pfc node after the irqc nodes, to work around
>     a bug in the core OF proving code,
>   - The fourth and fifth patch remove all ape6evm-legacy and
>     ape6evm-reference support, now the r8a73a4 generic multiplatform case
>     has the same feature set,
>   - The sixth patch is new, and removes the now superfluous console=
>     bootargs parameter.
> 
> Thanks for applying!

Thanks, done.

With this patch applied I am able to NFS boot the ape6evm using
multiplatform using the shmobile_defconfig with CONFIG_MMC disabled.

For reference the boot log for shmobile_defconfig (without CONFIG_MMC
disabled) is as follows:


Booting Linux on physical CPU 0x0
Linux version 3.19.0-00014-g507937a (horms at ayumi.isobedori.kobe.vergenet.net) (gcc version 4.6.3 (GCC) ) #725 SMP Thu Feb 19 04:45:03 JST 2015
CPU: ARMv7 Processor [412fc0f3] revision 3 (ARMv7), cr=10c5307d
CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
Machine model: APE6EVM
Ignoring memory block 0x200000000 - 0x240000000
debug: ignoring loglevel setting.
Memory policy: Data cache writealloc
On node 0 totalpages: 262144
free_area_init_node: node 0, pgdat c064fb40, node_mem_map eeff9000
  Normal zone: 1520 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 194560 pages, LIFO batch:31
  HighMem zone: 67584 pages, LIFO batch:15
PERCPU: Embedded 7 pages/cpu @eefdf000 s6976 r0 d21696 u32768
pcpu-alloc: s6976 r0 d21696 u32768 alloc=8*4096
pcpu-alloc: [0] 0 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260624
Kernel command line: ignore_loglevel root=/dev/nfs ip=dhcp rw
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1032816K/1048576K available (4632K kernel code, 317K rwdata, 1212K rodata, 268K init, 191K bss, 15760K reserved, 0K cma-reserved, 270336K highmem)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
    vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
    lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
      .text : 0xc0008000 - 0xc05be024   (5849 kB)
      .init : 0xc05bf000 - 0xc0602000   ( 268 kB)
      .data : 0xc0602000 - 0xc0651460   ( 318 kB)
       .bss : 0xc0651460 - 0xc06811bc   ( 192 kB)
Hierarchical RCU implementation.
        RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=1.
RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
NR_IRQS:16 nr_irqs:16 16
Architected cp15 timer(s) running at 13.00MHz (virt).
sched_clock: 56 bits at 13MHz, resolution 76ns, wraps every 2643056803840ns
Switching to timer-based delay loop, resolution 76ns
Console: colour dummy device 80x30
console [tty0] enabled
Calibrating delay loop (skipped), value calculated using timer frequency.. 26.00 BogoMIPS (lpj=130000)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
CPU: Testing write buffer coherency: ok
CPU0: update cpu_capacity 1024
CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
Setting up static identity map for 0x4048c270 - 0x4048c2c8
Brought up 1 CPUs
SMP: Total of 1 processors activated (26.00 BogoMIPS).
CPU: All CPU(s) started in SVC mode.
devtmpfs: initialized
VFP support v0.3: implementor 41 architecture 4 part 30 variant f rev 0
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
renesas_irqc e61c0000.interrupt-controller: driving 32 irqs
renesas_irqc e61c0200.interrupt-controller: driving 26 irqs
sh-pfc e6050000.pfc: r8a73a4_pfc handling gpio 0 -> 329
sh-pfc e6050000.pfc: r8a73a4_pfc support registered
No ATAGs?
hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
hw-breakpoint: maximum watchpoint size is 8 bytes.
vgaarb: loaded
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
max8973: failed to enable
max8973 0-001b: regulator register failed, err -110
max8973: probe of 0-001b failed with error -110
i2c-sh_mobile e60b0000.i2c: I2C adapter 0, bus speed 100000 Hz
media: Linux media interface: v0.10
Linux video capture interface: v2.00
sh_cmt e6130000.timer: ch0: used for clock events
sh_cmt e6130000.timer: ch1: used as clock source
Advanced Linux Sound Architecture Driver Initialized.
Switched to clocksource arch_sys_counter
NET: Registered protocol family 2
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP: reno registered
UDP hash table entries: 512 (order: 2, 16384 bytes)
UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
PCI: CLS 0 bytes, default 64
futex hash table entries: 256 (order: 2, 16384 bytes)
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
nfs4filelayout_init: NFSv4 File Layout Driver Registering...
bounce: pool size: 64 pages
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
SuperH (H)SCI(F) driver initialized
e6c40000.serial: ttySC0 at MMIO 0xe6c40000 (irq = 139, base_baud = 0) is a scifa
console [ttySC0] enabled
[drm] Initialized drm 1.1.0 20060810
libphy: smsc911x-mdio: probed
smsc911x 8000000.ethernet eth0: attached PHY driver [SMSC LAN8700] (mii_bus:phy_addr=8000000.ethernet:01, irq=-1)
smsc911x 8000000.ethernet eth0: MAC Address: 00:08:f7:00:02:4b
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci-pci: OHCI PCI platform driver
mousedev: PS/2 mouse device common for all mice
i2c /dev entries driver
rcar_thermal e61f0000.thermal: 3 sensor probed
Driver 'mmcblk' needs updating - please use bus_type methods
sh_mobile_sdhi ee100000.sd: No vqmmc regulator found
sh_mobile_sdhi: probe of ee100000.sd failed with error -22
sh_mobile_sdhi ee120000.sd: No vqmmc regulator found
sh_mobile_sdhi: probe of ee120000.sd failed with error -22
sh_mmcif ee200000.mmc: No vqmmc regulator found
of_dma_request_slave_channel: dma-names property of node '/mmc at ee200000' missing or empty
sh_mmcif ee200000.mmc: Chip version 0x0003, clock rate 0MHz
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
TCP: cubic registered
NET: Registered protocol family 10
sit: IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
Key type dns_resolver registered
platform cpufreq-dt: Driver cpufreq-dt requests probe deferral
Registering SWP/SWPB emulation handler
platform cpufreq-dt: Driver cpufreq-dt requests probe deferral
input: keyboard as /devices/platform/keyboard/input/input0
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
platform cpufreq-dt: Driver cpufreq-dt requests probe deferral
smsc911x 8000000.ethernet eth0: SMSC911x/921x identified at 0xf009c000, IRQ: 120
IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
sh_mmcif ee200000.mmc: Timeout waiting for 1 on CMD0
