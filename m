From: david@lechnology.com (David Lechner)
Date: Thu, 11 Jan 2018 11:22:32 -0600
Subject: [PATCH v5 01/44] dt-bindings: clock: Add new bindings for TI
 Davinci PLL clocks
In-Reply-To: <CAHCN7xKORFriQ2Gjx85OsCUzHO-mavCQXLOzh5D3n4kEG=i-Yg@mail.gmail.com>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
 <1515377863-20358-2-git-send-email-david@lechnology.com>
 <ebd677dc-44a4-5053-2509-e3ee948ccf98@ti.com>
 <22409e49-5c14-4068-b137-7535afaf90d7@lechnology.com>
 <0f90b5f7-f21e-5f81-1154-9a815bbb786d@ti.com>
 <ba7fa842-cfc5-6f6f-f9bf-09c74ab08ec2@lechnology.com>
 <5aacc350-6236-2e4f-35bb-a681fc9d47e7@ti.com>
 <CAHCN7x+ZYezmEU_0mF=6_gF14DZxKnuDp1Cx=aC2=eN_QLNdJQ@mail.gmail.com>
 <fd162516-cddc-e857-ce60-2cd89303971e@lechnology.com>
 <CAHCN7xKORFriQ2Gjx85OsCUzHO-mavCQXLOzh5D3n4kEG=i-Yg@mail.gmail.com>
Message-ID: <40501635-6f5b-20c9-f8bc-d17e26b58426@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/2018 06:45 AM, Adam Ford wrote:
> On Wed, Jan 10, 2018 at 8:50 PM, David Lechner <david@lechnology.com> wrote:
>> On 01/10/2018 04:24 PM, Adam Ford wrote:
>>>
>>>
>>> I am available tomorrow to build and test patches against the
>>> da850-evm.  I just need to know which version(s) to test.
>>
>>
>> Great. As per the cover letter:
>>
>> You can find a working branch with everything included in the
>> "common-clk-v5"
>> branch of https://github.com/dlech/ev3dev-kernel.git.
> 
> I wasn't sure if things had changed after some of the dialog about the
> bindings and device tree.

Not yet. ;-)

> 
> Here is my log with DEBUG_LL and CONFIG_EARLY_PRINTK set :
> 
> Starting kernel ...
> 
> Uncompressing Linux... done, booting the kernel.
> Booting Linux on physical CPU 0x0
> Linux version 4.15.0-rc4-g8564e0f (aford at ubuntu16) (gcc version 7.2.0
> (Buildroot 2017.11.1-00021-g7b43660)) #2 PREEMPT Thu Jan 11 06:35:29
> CST 2018
> CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=0005317f
> CPU: VIVT data cache, VIVT instruction cache
> OF: fdt: Machine model: DA850/AM1808/OMAP-L138 EVM

OK, using device tree...

> Memory policy: Data cache writethrough
> cma: Reserved 16 MiB at 0xc2c00000
> DaVinci da850/omap-l138 variant 0x0
> random: fast init done
> Built 1 zonelists, mobility grouping on.  Total pages: 16256
> Kernel command line: console=ttyS2,115200n8 root=PARTUUID= rw
> rootfstype=ext4 rootwait
> Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
> Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
> Memory: 42164K/65536K available (4548K kernel code, 280K rwdata, 1044K
> rodata, 232K init, 143K bss, 6988K reserved, 16384K cma-reserved)
> Virtual kernel memory layout:
>      vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>      fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
>      vmalloc : 0xc4800000 - 0xff800000   ( 944 MB)
>      lowmem  : 0xc0000000 - 0xc4000000   (  64 MB)
>      modules : 0xbf000000 - 0xc0000000   (  16 MB)
>        .text : 0x(ptrval) - 0x(ptrval)   (4550 kB)
>        .init : 0x(ptrval) - 0x(ptrval)   ( 232 kB)
>        .data : 0x(ptrval) - 0x(ptrval)   ( 281 kB)
>         .bss : 0x(ptrval) - 0x(ptrval)   ( 144 kB)
> SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> Preemptible hierarchical RCU implementation.
>          Tasks RCU enabled.
> NR_IRQS: 245
> clocksource: timer0_1: mask: 0xffffffff max_cycles: 0xffffffff,
> max_idle_ns: 79635851949 ns
> sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every
> 89478484971ns
> Console: colour dummy device 80x30
> Calibrating delay loop... 148.88 BogoMIPS (lpj=744448)
> pid_max: default: 32768 minimum: 301
> Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
> Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
> CPU: Testing write buffer coherency: ok
> Setting up static identity map for 0xc0008400 - 0xc0008458
> Hierarchical SRCU implementation.
> devtmpfs: initialized
> clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff,
> max_idle_ns: 19112604462750000 ns
> futex hash table entries: 256 (order: -1, 3072 bytes)
> pinctrl core: initialized pinctrl subsystem
> NET: Registered protocol family 16
> DMA: preallocated 256 KiB pool for atomic coherent allocations
> cpuidle: using governor menu
> mux: initialized RTC_ALARM
> mux: Setting register RTC_ALARM
> mux:    PINMUX0 (0x00000000) = 0x44080000 -> 0x24080000
> edma 1c00000.edma: memcpy is disabled
> edma 1c00000.edma: TI EDMA DMA engine driver
> edma 1e30000.edma: memcpy is disabled
> edma 1e30000.edma: TI EDMA DMA engine driver
> i2c_davinci 1c22000.i2c: could not find pctldev for node
> /soc at 1c00000/pinmux at 14120/pinmux_i2c0_pins, deferring probe
> clocksource: Switched to clocksource timer0_1
> NET: Registered protocol family 2
> TCP established hash table entries: 1024 (order: 0, 4096 bytes)
> TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
> TCP: Hash tables configured (established 1024 bind 1024)
> UDP hash table entries: 256 (order: 0, 4096 bytes)
> UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
> NET: Registered protocol family 1
> RPC: Registered named UNIX socket transport module.
> RPC: Registered udp transport module.
> RPC: Registered tcp transport module.
> RPC: Registered tcp NFSv4.1 backchannel transport module.
> Initialise system trusted keyrings
> workingset: timestamp_bits=30 max_order=14 bucket_order=0
> Key type asymmetric registered
> Asymmetric key parser 'x509' registered
> Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
> io scheduler noop registered (default)
> io scheduler mq-deadline registered
> io scheduler kyber registered
> pinctrl-single 1c14120.pinmux: 160 pins at pa fdfe34a6 size 80
> Serial: 8250/16550 driver, 3 ports, IRQ sharing disabled
> 1c42000.serial: ttyS0 at MMIO 0x1c42000 (irq = 25, base_baud =
> 9375000) is a TI DA8xx/66AK2x
> 1d0c000.serial: ttyS1 at MMIO 0x1d0c000 (irq = 53, base_baud =
> 8250000) is a TI DA8xx/66AK2x
> 1d0d000.serial: ttyS2 at MMIO 0x1d0d000 (irq = 61, base_baud =
> 8250000) is a TI DA8xx/66AK2x
> console [ttyS2] enabled

If you are getting to this point, you probably don't need DEBUG_LL.
It looks like "earlyprint" is not being passed to the command line
anyway, so CONFIG_EARLY_PRINTK is not actually doing anything.

> brd: module loaded
> libphy: Fixed MDIO Bus: probed
> davinci_mdio 1e24000.mdio: failed to get device clock
> davinci_mdio: probe of 1e24000.mdio failed with error -2

It looks like this needs a clock-names property in the device tree.
Please make this change and try again:

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 08a9817..fd3e316 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -713,6 +713,7 @@
  			#size-cells = <0>;
  			reg = <0x224000 0x1000>;
  			clocks = <&psc1 5>;
+			clock-names = "fck";
  			status = "disabled";
  		};
  		eth0: ethernet at 220000 {


> i2c /dev entries driver
> davinci_mmc 1c40000.mmc: Using DMA, 4-bit mode
> NET: Registered protocol family 10
> Segment Routing with IPv6
> sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
> NET: Registered protocol family 17
> Loading compiled-in X.509 certificates
> mmc0: host does not support reading read-only switch, assuming
> write-enable
> mmc0: new high speed SDHC card at address b368
> mmcblk0: mmc0:b368 00000 3.75 GiB
>   mmcblk0: p1 p2
> pca953x 0-0020: 0-0020 supply vcc not found, using dummy regulator
> pca953x 0-0020: failed reading register
> pca953x: probe of 0-0020 failed with error -121

I'm not sure why there is an error here. I'm using I2C0 on my board,
so I am fairly confident that it is not a problem introduced by this
series.

> console [netcon0] enabled
> netconsole: network logging started
> davinci_emac 1e20000.ethernet: incompatible machine/device type for
> reading mac address
> hctosys: unable to open rtc device (rtc0)
> 

What is normally the next line after this in a working boot?

Also please try passing "clk_ignore_unused" to the kernel command line.
