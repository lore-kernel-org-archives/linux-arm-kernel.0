From: horms@verge.net.au (Simon Horman)
Date: Wed, 10 Apr 2013 10:35:08 +0900
Subject: [PATCH/RFC 0/2] ARM: shmobile: DT irqpin for r8a7779 and
 marzen-reference
In-Reply-To: <20130410010818.GA11105@verge.net.au>
References: <Pine.LNX.4.64.1304031103590.10531@axis700.grange>
 <20130404035426.GC28297@verge.net.au>
 <Pine.LNX.4.64.1304042325140.21548@axis700.grange>
 <20130405014429.GV29203@verge.net.au>
 <20130405021339.GZ29203@verge.net.au>
 <20130410010818.GA11105@verge.net.au>
Message-ID: <20130410013508.GE11105@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 10, 2013 at 10:08:18AM +0900, Simon Horman wrote:
> On Fri, Apr 05, 2013 at 11:13:39AM +0900, Simon Horman wrote:
> > On Fri, Apr 05, 2013 at 10:44:29AM +0900, Simon Horman wrote:
> > > On Thu, Apr 04, 2013 at 11:47:05PM +0200, Guennadi Liakhovetski wrote:
> > > > Hi Simon
> > > > 
> > > > On Thu, 4 Apr 2013, Simon Horman wrote:
> > > > 
> > > > > On Wed, Apr 03, 2013 at 11:18:57AM +0200, Guennadi Liakhovetski wrote:
> > > > > > Hi
> > > > > > 
> > > > > > This 2 patches add DT irqpin support on marzen-reference. Only 
> > > > > > compile-tested due to the lack of hardware. The patches can go 
> > > > > > independently via their respective trees. irqpin on marzen will not work 
> > > > > > if patch 2 is applied before patch 1, but as long as there are no devices, 
> > > > > > using irqpin interrupts, no breakage will be caused.
> > > > > 
> > > > > I have applied both patches and the dependency I mention below.
> > > > > I have also applied the small patch, inlined below, to hook-up
> > > > > the LAN controller. Unfortunately it doesn't seem to be receiving
> > > > > any interrupts. Perhaps I am missing something?
> > > > 
> > > > Are you sure 28 is the correct number in the irqpin IRQ space? Seems 
> > > > strange to me. Should be 1 perhaps (counting from 0), or 2 - not sure how 
> > > > that mapping would look like.
> > > 
> > > Thanks!
> > > 
> > > 0 seems to be the lucky number, I have SMSC (and NFS root) working
> > > on marzen-reference.
> > 
> > s/0/1/
> 
> After all that it seems that I miss-tested the code somehow.
> 
> It turns out that 2 is the lucky number.

My, what a mess I have made.

It seems that I miss-tested again (using non-reference boot instead
of reference boot).

Unfortunately I am not able to get the NIC running after all.


Booting Linux on physical CPU 0x0
Linux version 3.9.0-rc2-00004-gb1480a8 (horms at ayumi.isobedori.kobe.vergenet.net) (gcc version 4.5.2 (Sourcery G++ Lite 2011.03-41) ) #1642 SMP Wed Apr 10 10:28:59 JST 2013
CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c53c7d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine: marzen, model: marzen
debug: ignoring loglevel setting.
Memory policy: ECC disabled, Data cache writealloc
On node 0 totalpages: 262144
free_area_init_node: node 0, pgdat c0534c00, node_mem_map c082b000
  Normal zone: 1520 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 194560 pages, LIFO batch:31
  HighMem zone: 528 pages used for memmap
  HighMem zone: 67584 pages, LIFO batch:15
PERCPU: Embedded 5 pages/cpu @c1033000 s6720 r0 d13760 u32768
pcpu-alloc: s6720 r0 d13760 u32768 alloc=8*4096
pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260624
Kernel command line: console=ttySC2,115200 earlyprintk=sh-sci.2,115200 ignore_loglevel root=/dev/nfs ip=on
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
__ex_table already sorted, skipping sort
Memory: 1024MB = 1024MB total
Memory: 1033972k/1033972k available, 14604k reserved, 270336K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
    lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
      .text : 0xc0008000 - 0xc037fc60   (3552 kB)
      .init : 0xc0380000 - 0xc0511a40   (1607 kB)
      .data : 0xc0512000 - 0xc05357c0   ( 142 kB)
       .bss : 0xc05357c0 - 0xc0560274   ( 171 kB)
Hierarchical RCU implementation.
NR_IRQS:16 nr_irqs:16 16
sched_clock: 32 bits at 1kHz, resolution 976562ns, wraps every 4194303999ms
Calibrating delay loop (skipped) preset value.. 1000.00 BogoMIPS (lpj=488000)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
Setting up static identity map for 0xc02db328 - 0xc02db380
CPU1: Booted secondary processor
CPU2: Booted secondary processor
CPU3: Booted secondary processor
Brought up 4 CPUs
SMP: Total of 4 processors activated (4000.00 BogoMIPS).
CPU: All CPU(s) started in SVC mode.
devtmpfs: initialized
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
sh-pfc pfc-r8a7779: r8a7779_pfc support registered
renesas_intc_irqpin fe78001c.irqpin: driving 4 irqs
No ATAGs?
bio: create slab <bio-0> at 0
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
sh_tmu sh_tmu.0: Runtime PM disabled, clock forced on.
sh_tmu sh_tmu.0: used for clock events
sh_tmu sh_tmu.0: used for periodic clock events
sh_tmu sh_tmu.1: Runtime PM disabled, clock forced on.
sh_tmu sh_tmu.1: used as clock source
Switching to clocksource sh_tmu.1
Clockevents: could not switch to one-shot mode:
Clockevents: could not switch to one-shot mode:
Clockevents: could not switch to one-shot mode:
 dummy_timer is not functional.
 dummy_timer is not functional.
Clockevents: could not switch to one-shot mode: dummy_timer is not functional.
 dummy_timer is not functional.
NET: Registered protocol family 2
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
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
bounce pool size: 64 pages
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
io scheduler noop registered
io scheduler deadline registered (default)
gpio_rcar gpio_rcar.0: driving 32 GPIOs
gpio_rcar gpio_rcar.1: driving 32 GPIOs
gpio_rcar gpio_rcar.2: driving 32 GPIOs
gpio_rcar gpio_rcar.3: driving 32 GPIOs
gpio_rcar gpio_rcar.4: driving 32 GPIOs
gpio_rcar gpio_rcar.5: driving 32 GPIOs
gpio_rcar gpio_rcar.6: driving 9 GPIOs
SuperH SCI(F) driver initialized
sh-sci sh-sci.0: Runtime PM disabled, clock forced on.
sh-sci.0: ttySC0 at MMIO 0xffe40000 (irq = 120) is a scif
sh-sci sh-sci.1: Runtime PM disabled, clock forced on.
sh-sci.1: ttySC1 at MMIO 0xffe41000 (irq = 121) is a scif
sh-sci sh-sci.2: Runtime PM disabled, clock forced on.
sh-sci.2: ttySC2 at MMIO 0xffe42000 (irq = 122) is a scif
console [ttySC2] enabled
sh-sci sh-sci.3: Runtime PM disabled, clock forced on.
sh-sci.3: ttySC3 at MMIO 0xffe43000 (irq = 123) is a scif
sh-sci sh-sci.4: Runtime PM disabled, clock forced on.
sh-sci.4: ttySC4 at MMIO 0xffe44000 (irq = 124) is a scif
sh-sci sh-sci.5: Runtime PM disabled, clock forced on.
sh-sci.5: ttySC5 at MMIO 0xffe45000 (irq = 125) is a scif
sata_rcar fc600000.sata: Runtime PM disabled, clock forced on.
scsi0 : sata_rcar
ata1: SATA max UDMA/133 irq 132
smsc911x: Driver version 2008-10-21
libphy: smsc911x-mdio: probed
smsc911x 18000000.lan0 eth0: attached PHY driver [Generic PHY] (mii_bus:phy_addr=18000000.lan0-ff:01, irq=-1)
smsc911x 18000000.lan0 eth0: MAC Address: 2e:09:0a:00:3c:de
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-platform: EHCI generic platform driver
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
rcar_thermal ffc48000.thermal: 1 sensor proved
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
TCP: cubic registered
ata1: link resume succeeded after 1 retries
ata1: SATA link down (SStatus 0 SControl 300)
smsc911x 18000000.lan0 eth0: ISR failed signaling test (IRQ 256)
IP-Config: Failed to open eth0
IP-Config: No network devices available
Freeing init memory: 1604K


boot (Linux 3.9.0-rc2-00004-gb1480a8, BusyBox v1.16.0.git, kexec-tools 2.0.1-git)
/ # ip link set up dev eth0
smsc911x 18000000.lan0 eth0: ISR failed signaling test (IRQ 256)
ip: SIOCSIFFLAGS: No such device
/ # cat /proc/interrupts 
           CPU0       CPU1       CPU2       CPU3       
 59:          0          0          0          0       GIC  fe78001c.irqpin
 60:          0          0          0          0       GIC  fe78001c.irqpin
 61:          0          0          0          0       GIC  fe78001c.irqpin
 62:          0          0          0          0       GIC  fe78001c.irqpin
 64:      24370          0          0          0       GIC  sh_tmu.0
122:         97          0          0          0       GIC  sh-sci.2:mux
132:          0          0          0          0       GIC  sata_rcar
173:          0          0          0          0       GIC  gpio_rcar.0
174:          0          0          0          0       GIC  gpio_rcar.1
175:          0          0          0          0       GIC  gpio_rcar.2
176:          0          0          0          0       GIC  gpio_rcar.3
177:          0          0          0          0       GIC  gpio_rcar.4
178:          0          0          0          0       GIC  gpio_rcar.5
179:          0          0          0          0       GIC  gpio_rcar.6
256:          0          0          0          0  fe78001c.irqpin  eth0
IPI0:          0          0          0          0  CPU wakeup interrupts
IPI1:          0      24330      23977      24350  Timer broadcast interrupts
IPI2:        470        458         73         74  Rescheduling interrupts
IPI3:         56         37         40         35  Function call interrupts
IPI4:          0          0          0          0  Single function call interrupts
IPI5:          0          0          0          0  CPU stop interrupts
Err:          0
