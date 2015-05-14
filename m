From: tyler.baker@linaro.org (Tyler Baker)
Date: Thu, 14 May 2015 06:55:14 -0700
Subject: [GIT PULL]Hisilicon hip04 soc and D01 board DT updates for v4.2
In-Reply-To: <CANMBJr7wTQOU=hfv4XoQFH_Gghr14ORaoiZnT1wN8jFJTPpPXg@mail.gmail.com>
References: <554CC781.9010705@hisilicon.com> <2096767.GyPuANEUdq@wuerfel>
 <555217BA.4090109@hisilicon.com>
 <CANMBJr5JQF1D43bCmV-w9hxemmMQJkvTG+gD98r_H=F6g=9Bqw@mail.gmail.com>
 <555461A3.40802@hisilicon.com>
 <CANMBJr7wTQOU=hfv4XoQFH_Gghr14ORaoiZnT1wN8jFJTPpPXg@mail.gmail.com>
Message-ID: <CANMBJr6bOu9-w_gODrJO_4-VczXOo024wnyhAtndFGTGrWUs6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 May 2015 at 06:36, Tyler Baker <tyler.baker@linaro.org> wrote:
> Hi Wei,
>
> On 14 May 2015 at 01:49, Wei Xu <xuwei5@hisilicon.com> wrote:
>>
>>
>> On 5/13/2015 8:20 PM, Tyler Baker wrote:
>>> Hi Wei/Arnd,
>>>
>>> On 12 May 2015 at 08:09, Wei Xu <xuwei5@hisilicon.com> wrote:
>>>>
>>>>
>>>> On 5/12/2015 4:06 PM, Arnd Bergmann wrote:
>>>>> On Friday 08 May 2015 15:26:09 Wei Xu wrote:
>>>>>> ARM: DT: Hisilicon hip04 soc and D01 board updates for 4.2
>>>>>>
>>>>>> - Add hip04 GPIO nodes
>>>>>> - Add NANDC nodes for hip04 and D01 board
>>>>>> - Add hip04 ethernet related nodes
>>>>>>
>>>>>>
>>>>
>>>> Hi Arnd,
>>>>
>>>>> Pulled into next/dt, thanks!
>>>
>>> When this was pulled into arm-soc, the kernelci.org bot reported
>>> hip04-d01 boot failures[1]. Before bisecting, I decided to wait a day
>>> and double check the status of -next in case there were needed
>>> dependencies from other trees. However, now there are the same
>>> hip04-d01 boot failures in next-20150513[2]. My robot has bisected[3]
>>> these boot failures down to...
>>>
>>> 828fcfe3c84ade68ecc3f1ba78baebc1654977f3 is the first bad commit
>>> commit 828fcfe3c84ade68ecc3f1ba78baebc1654977f3
>>> Author: Zhou Wang <wangzhou.bry@gmail.com>
>>> Date:   Wed Mar 25 14:57:45 2015 +0800
>>>
>>>     ARM: dts: hip04: add GPIO pieces
>>>
>>>     Hisilicon Soc hip04 has four GPIO controllers, each one has 32
>>>     GPIOs and can be configured to be an interrupt controller.The GPIO
>>>     controllers are compatible with the snps,dw-apb-gpio driver.
>>>     This patch add the corresponding device tree nodes.
>>>
>>>     Acked-by: Linus Walleij <linus.walleij@linaro.org>
>>>     Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
>>>     Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
>>
>> Hi Tyler,
>>
>>> This commit does not revert cleanly from -next, so I reverted all
>>> three commits in this pull request on top of next-20150513 and this
>>> get the hip04-d01 booting again.
>>
>> It is a little strange.
>> I checked to this commit "28837bc3e732610ebc7c88ce205dbe43245b1cb8"
>> at "git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git".
>> and compiled with "hisi_defconfig".
>>
>> It is booting OK and the log is as below.
>> And I have also uploaded the binary at "https://github.com/hisilicon/boards/tree/master/D01/for-tyler".
>> Could you please confirm it again?
>
> It appears we are using different image formats to boot. The link
> above shows .kernel, .monitor, .text...can I split the kernel//dtb out
> from .kernel?
>
> I am using zImage and hip04-d01.dtb directly[1] with UEFI to TFTP
> boot. Could you try this method?

For good measure, I tried booting next-20150514 on the D01 hardware in
the Linaro lab to confirm the same failure I see locally. It fails to
boot as well[1].

>
>> Thanks!
>>
>> Best Regards,
>> Wei
>>
>> / # SC00$
>> DDR INIT OK!!!
>> GPIO INIT OK!!!
>> Boot firmware EVB_SECURE_UEFI_BIOS built at 21:21:53 on May  6 2015
>> add-symbol-file /home/joyx/develop/github-uefi/Build/D01/DEBUG_GCC49/ARM/HisiPkg/D01BoardPkg/Sec/Sec/Sec/DEBUG/ArmPlatformSec.dll 0xF0100180
>> Trust Zone Configuration is disabled
>> UEFI firmware (version EVB_SECURE_UEFI_BIOS built at 18:53:44 on May  6 2015)
>> add-symbol-file /home/joyx/develop/github-uefi/Build/D01/DEBUG_GCC49/ARM/ArmPlatformPkg/PrePi/PeiMPCore/DEBUG/ArmPlatformPrePiMPCore.dll 0xF0120180
>> add-symbol-file /home/joyx/develop/github-uefi/Build/D01/DEBUG_GCC49/ARM/MdeModulePkg/Core/Dxe/DxeMain/DEBUG/DxeCore.dll 0x6FAD8240
>> add-symbol-file /home/joyx/develop/github-uefi/Build/D01/DEBUG_GCC49/ARM/MdeModulePkg/Core/Dxe/DxeMain/DEBUG/DxeCore.dll 0x6FAD8000
>> add-symbol-file /home/joyx/develop/github-uefi/Build/D01/DEBUG_GCC49/ARM/ArmPkg/Drivers/CpuDxe/CpuDxe/DEBUG/ArmCpuDxe.dll 0x6FA83240
>> add-symbol-file /home/joyx/develop/github-uefi/Build/D01/DEBUG_GCC49/ARM/MdeModulePkg/Core/RuntimeDxe/RuntimeDxe/DEBUG/RuntimeDxe.dll 0x6FA9F240
>> add-symbol-file /home/joyx/develop/github-uefi/Build/D01/DEBUG_GCC49/ARM/MdeModulePkg/Universal/SecurityStubDxe/SecurityStubDxe/DEBUG/SecurityStubDxe.dll 0x6FA7E240
>> add-symbol-file /home/joyx/develop/github-uefi/Build/D01/DEBUG_GCC49/ARM/MdeModulePkg/Universal/Variable/EmuRuntimeDxe/EmuVariableRuntimeDxe/DEBUG/EmuVariableRuntimeDxe.dll 0x6FA97240
>> add-symbol-file /home/joyx/develop/github-uefi/Build/D01/DEBUG_GCC49/ARM/EmbeddedPkg/EmbeddedMonotonicCounter/EmbeddedMonotonicCounter/DEBUG/EmbeddedMonotonicCounter.dll 0x6FA93240
>> add-symbol-file /home/joyx/develop/github-uefi/Build/D01/DEBUG_GCC49/ARM/EmbeddedPkg/ResetRuntimeDxe/ResetRuntimeDxe/DEBUG/Reset.dll 0x6AAC9240
>> add-symbol-file /home/joyx/develop/github-uefi/Build/D01/DEBUG_GCC49/ARM/EmbeddedPkg/RealTimeClockRuntimeDxe/RealTimeClockRuntimeDxe/DEBUG/RealTimeClock.dll 0x6AAC3240
>> add-symbol-file /home/joyx/develop/github-uefi/Build/D01/DEBUG_GCC49/ARM/EmbeddedPkg/MetronomeDxe/MetronomeDxe/DEBUG/MetronomeDxe.dll 0x6FA79240
>> add-symbol-file /home/joyx/develop/github-uefi/Build/D01/DEBUG_GCC49/ARM/MdeModulePkg/Universal/HiiDatabaseDxe/HiiDatabaseDxe/DEBUG/HiiDatabase.dll 0x6FA61240
>> NandFlashInit start
>> [NANDFlash]  Vendor[0]: MICRON,       MakerCode[0]:    0x0002C
>> [NANDFlash]  ChipSize[0]: 0x20000000, BlockSize[0]:    0x20000
>> [NANDFlash]  PageSize[0]: 0x00000800, PagePerBlock[0]: 0x00040
>> NAND Flash Init OK! Status = Success
>>
>> Auto boot or not ?(Press 's' to Boot Menu)
>> Now wait for 2 seconds...
>>
>> Not Press 's', Start Auto Boot!
>>
>> Transmit  OS from FLASH to DDR now, please wait![CopyNandToMem : 509]
>> [CopyNandToMem : 533]PageNumCopy = 1400!
>>
>> The .kernel file is transmitted ok!
>>
>> Copy Bootwrapper from FLASH to SRAM...[CopyNandToMem : 509]
>> [CopyNandToMem : 533]PageNumCopy = 40!
>>
>> The .text file is transmitted ok!
>> [CopyNandToMem : 509]
>> [CopyNandToMem : 533]PageNumCopy = 40!
>> The .monitor file is transmitted ok!
>> [CopyNandToMem : 509]
>> [CopyNandToMem : 533]PageNumCopy = 3000!
>> THE .FILESYSTEM FILE IS TRANSMITTED OK!
>> MOVE PC TEXT_SRAM_BASE
>> C01$
>> &#C02$
>> &#C03$
>> &#C10$
>> &#C11$
>> &#C12$
>> &#C13$
>> &#C20$
>> &#C21$
>> &#C22$
>> &#C23$
>> &#C30$
>> &#C31$
>> &#C32$
>> &#C33$
>> &#[    0.000000] Booting Linux on physical CPU 0x0
>> [    0.000000] Linux version 4.1.0-rc3-00364-g28837bc (joyx at f00297740a) (gcc version 4.9.1 20140505 (prerelease) (crosstool-NG linaro-1.13.1-4.9-2014.05 - Linaro GCC 2014.05) ) #10 SMP PREEMPT Thu May 14 5
>> [    0.000000] CPU: ARMv7 Processor [413fc0f2] revision 2 (ARMv7), cr=10c5387d
>> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
>> [    0.000000] Machine model: Hisilicon D01 Development Board
>> [    0.000000] Ignoring memory block 0x4c0000000 - 0x800000000
>> [    0.000000] earlycon: no match for ttyS0,115200
>> [    0.000000] Memory policy: Data cache writealloc
>> [    0.000000] PERCPU: Embedded 9 pages/cpu @edf46000 s15040 r0 d21824 u36864
>> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 784912
>> [    0.000000] Kernel command line: console=ttyS0,115200 initrd=0x10d00000,0x1800000 rdinit=/linuxrc earlyprintk
>> [    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
>> [    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
>> [    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
>> [    0.000000] Memory: 3089052K/3145728K available (4416K kernel code, 148K rwdata, 920K rodata, 220K init, 241K bss, 56676K reserved, 0K cma-reserved, 2367488K highmem)
>> [    0.000000] Virtual kernel memory layout:
>> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>> [    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
>> [    0.000000]     vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
>> [    0.000000]     lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
>> [    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
>> [    0.000000]       .text : 0xc0008000 - 0xc053e2ac   (5337 kB)
>> [    0.000000]       .init : 0xc053f000 - 0xc0576000   ( 220 kB)
>> [    0.000000]       .data : 0xc0576000 - 0xc059b240   ( 149 kB)
>> [    0.000000]        .bss : 0xc059e000 - 0xc05da504   ( 242 kB)
>> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
>> [    0.000000] Preemptible hierarchical RCU implementation.
>> [    0.000000]  Additional per-CPU info printed with stalls.
>> [    0.000000] NR_IRQS:16 nr_irqs:16 16
>> [    0.000000] Architected cp15 timer(s) running at 50.00MHz (phys).
>> [    0.000000] clocksource arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0xb8812736b, max_idle_ns: 440795202655 ns
>> [    0.000003] sched_clock: 56 bits at 50MHz, resolution 20ns, wraps every 4398046511100ns
>> [    0.000012] Switching to timer-based delay loop, resolution 20ns
>> [    0.000082] clocksource arm,sp804: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 38225208935 ns
>> [    0.000100] sched_clock: 32 bits at 50MHz, resolution 20ns, wraps every 42949672950ns
>> [    0.000892] Console: colour dummy device 80x30
>> [    0.000969] Calibrating delay loop (skipped), value calculated using timer frequency.. 100.00 BogoMIPS (lpj=500000)
>> [    0.001007] pid_max: default: 32768 minimum: 301
>> [    0.001276] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
>> [    0.001302] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
>> [    0.002711] CPU: Testing write buffer coherency: ok
>> [    0.003235] /cpus/cpu at 0 missing clock-frequency property
>> [    0.003279] /cpus/cpu at 1 missing clock-frequency property
>> [    0.003324] /cpus/cpu at 2 missing clock-frequency property
>> [    0.003370] /cpus/cpu at 3 missing clock-frequency property
>> [    0.003420] /cpus/cpu at 100 missing clock-frequency property
>> [    0.003474] /cpus/cpu at 101 missing clock-frequency property
>> [    0.003533] /cpus/cpu at 102 missing clock-frequency property
>> [    0.003597] /cpus/cpu at 103 missing clock-frequency property
>> [    0.003665] /cpus/cpu at 200 missing clock-frequency property
>> [    0.003737] /cpus/cpu at 201 missing clock-frequency property
>> [    0.003814] /cpus/cpu at 202 missing clock-frequency property
>> [    0.003892] /cpus/cpu at 203 missing clock-frequency property
>> [    0.003976] /cpus/cpu at 300 missing clock-frequency property
>> [    0.004065] /cpus/cpu at 301 missing clock-frequency property
>> [    0.004158] /cpus/cpu at 302 missing clock-frequency property
>> [    0.004255] /cpus/cpu at 303 missing clock-frequency property
>> [    0.004284] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
>> [    0.004418] Setting up static identity map for 0x10008280 - 0x100082d8
>> [    0.004716] HiP04 MCPM initialized
>> [    0.270900] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
>> [    0.338352] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
>> [    0.405920] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
>> [    0.473505] CPU4: thread -1, cpu 0, socket 1, mpidr 80000100
>> [    0.541041] CPU5: thread -1, cpu 1, socket 1, mpidr 80000101
>> [    0.608577] CPU6: thread -1, cpu 2, socket 1, mpidr 80000102
>> [    0.676148] CPU7: thread -1, cpu 3, socket 1, mpidr 80000103
>> [    0.743715] CPU8: thread -1, cpu 0, socket 2, mpidr 80000200
>> [    0.811255] CPU9: thread -1, cpu 1, socket 2, mpidr 80000201
>> [    0.878793] CPU10: thread -1, cpu 2, socket 2, mpidr 80000202
>> [    0.946347] CPU11: thread -1, cpu 3, socket 2, mpidr 80000203
>> [    1.013975] CPU12: thread -1, cpu 0, socket 3, mpidr 80000300
>> [    1.081452] CPU13: thread -1, cpu 1, socket 3, mpidr 80000301
>> [    1.149029] CPU14: thread -1, cpu 2, socket 3, mpidr 80000302
>> [    1.216575] CPU15: thread -1, cpu 3, socket 3, mpidr 80000303
>> [    1.216795] Brought up 16 CPUs
>> [    1.216899] SMP: Total of 16 processors activated (1600.00 BogoMIPS).
>> [    1.216919] CPU: All CPU(s) started in HYP mode.
>> [    1.216937] CPU: Virtualization extensions available.
>> [    1.218912] devtmpfs: initialized
>> [    1.251514] VFP support v0.3: implementor 41 architecture 4 part 30 variant f rev 0
>> [    1.252528] clocksource jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
>> [    1.252759] pinctrl core: initialized pinctrl subsystem
>> [    1.270099] NET: Registered protocol family 16
>> [    1.270878] DMA: preallocated 256 KiB pool for atomic coherent allocations
>> [    1.292650] Serial: AMBA PL011 UART driver
>> [    1.314826] SCSI subsystem initialized
>> [    1.316126] usbcore: registered new interface driver usbfs
>> [    1.316282] usbcore: registered new interface driver hub
>> [    1.316760] usbcore: registered new device driver usb
>> [    1.319857] Switched to clocksource arch_sys_counter
>> [    1.344958] NET: Registered protocol family 2
>> [    1.346746] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
>> [    1.346931] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
>> [    1.347242] TCP: Hash tables configured (established 8192 bind 8192)
>> [    1.347441] UDP hash table entries: 512 (order: 2, 16384 bytes)
>> [    1.347523] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
>> [    1.348142] NET: Registered protocol family 1
>> [    1.348941] RPC: Registered named UNIX socket transport module.
>> [    1.348964] RPC: Registered udp transport module.
>> [    1.348982] RPC: Registered tcp transport module.
>> [    1.349001] RPC: Registered tcp NFSv4.1 backchannel transport module.
>> [    1.349542] Unpacking initramfs...
>> [    4.036110] Freeing initrd memory: 24576K (c0d00000 - c2500000)
>> [    4.041270] futex hash table entries: 4096 (order: 6, 262144 bytes)
>> [    4.068647] NFS: Registering the id_resolver key type
>> [    4.068740] Key type id_resolver registered
>> [    4.068764] Key type id_legacy registered
>> [    4.069265] bounce: pool size: 64 pages
>> [    4.069794] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
>> [    4.069833] io scheduler noop registered
>> [    4.069864] io scheduler deadline registered
>> [    4.070380] io scheduler cfq registered (default)
>> [    4.217934] Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
>> [    4.222002] console [ttyS0] disabled
>> [    4.222186] e4007000.uart: ttyS0 at MMIO 0xe4007000 (irq = 413, base_baud = 10500000) is a 16550A
>> [    6.529131] console [ttyS0] enabled
>> [    6.542635] [drm] Initialized drm 1.1.0 20060810
>> [    6.560545] ahci ea000000.sata: controller can't do NCQ, turning off CAP_NCQ
>> [    6.584199] ahci ea000000.sata: controller can't do FBS, turning off CAP_FBS
>> [    6.608078] ahci ea000000.sata: SSS flag set, parallel bus scan disabled
>> [    6.630673] ahci ea000000.sata: AHCI 0001.0300 32 slots 4 ports 6 Gbps 0xf impl platform mode
>> [    6.659316] ahci ea000000.sata: flags: sntf stag pm led clo only pmp slum part ccc sxs boh
>> [    6.693851] scsi host0: ahci
>> [    6.704676] scsi host1: ahci
>> [    6.715455] scsi host2: ahci
>> [    6.726248] scsi host3: ahci
>> [    6.736636] ata1: SATA max UDMA/133 mmio [mem 0xea000000-0xeaffffff] port 0x100 irq 404
>> [    6.763580] ata2: SATA max UDMA/133 mmio [mem 0xea000000-0xeaffffff] port 0x180 irq 404
>> [    6.790470] ata3: SATA max UDMA/133 mmio [mem 0xea000000-0xeaffffff] port 0x200 irq 404
>> [    6.817320] ata4: SATA max UDMA/133 mmio [mem 0xea000000-0xeaffffff] port 0x280 irq 404
>> [    8.002404] ata1: SATA link down (SStatus 0 SControl 300)
>> [    9.251149] ata2: SATA link down (SStatus 0 SControl 300)
>> [   11.174898] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> [   11.296724] ata3.00: ATA-8: ST500LM021-1KJ152, 0001SDM1, max UDMA/133
>> [   11.318388] ata3.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 0/32)
>> [   12.470360] ata3.00: configured for UDMA/133
>> [   12.525550] scsi 2:0:0:0: Direct-Access     ATA ST500LM021-1KJ15 SDM1 PQ: 0 ANSI: 5
>> [   12.554663] sd 2:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/465 GiB)
>> [   12.579879] sd 2:0:0:0: [sda] 4096-byte physical blocks
>> [   12.597919] sd 2:0:0:0: [sda] Write Protect is off
>> [   12.614225] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
>> [   12.687389]  sda: sda1 sda2
>> [   12.699532] sd 2:0:0:0: [sda] Attached SCSI disk
>> [   13.739898] ata4: SATA link down (SStatus 0 SControl 300)
>> [   18.127498] libphy: hip04_mdio_bus: probed
>> [   18.736446] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
>> [   18.758364] ehci-platform: EHCI generic platform driver
>> [   18.776239] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
>> [   18.797023] ohci-platform: OHCI generic platform driver
>> [   18.814956] usbcore: registered new interface driver usb-storage
>> [   18.835964] mousedev: PS/2 mouse device common for all mice
>> [   18.855836] failed to find reboot-offset property
>> [   18.871770] hisi-reboot: probe of e3e00000.sysctrl failed with error -22
>> [   18.894752] Synopsys Designware Multimedia Card Interface Driver
>> [   18.916759] usbcore: registered new interface driver usbhid
>> [   18.935450] usbhid: USB HID core driver
>> [   18.951098] NET: Registered protocol family 10
>> [   18.968938] sit: IPv6 over IPv4 tunneling driver
>> [   18.986387] NET: Registered protocol family 17
>> [   19.001496] Key type dns_resolver registered
>> [   19.016036] Registering SWP/SWPB emulation handler
>> [   19.034460] hctosys: unable to open rtc device (rtc0)
>> [   19.054127] ttyS0 - failed to request DMA
>> [   19.068154] Freeing unused kernel memory: 220K (c053f000 - c0576000)
>> mount: mounting /dev/sda1 on /mnt/sda1 failed: No such file or directory
>> [RCS]: /etc/init.d/S01udev
>> Starting mdev...
>> [   19.984050] random: sshd urandom read with 8 bits of entropy available
>> /var/empty must be owned by root and not group or world-writable.
>>
>> Please press Enter to activate this console.
>> Welcome to HiLinux.
>> / # cat /proc/device-tree/soc/
>> cat: read error: Is a directory
>> / # cat /proc/device-tree/soc/
>> #address-cells                gpio at 4003000/
>> #size-cells                   interrupt-controller at c01000/
>> arm-pmu/                      interrupt-parent
>> compatible                    mdio/
>> dual_timer at 3000000/           name
>> ethernet at 2800000/             nand at 4020000/
>> ethernet at 2880000/             ppe at 28c0000/
>> ethernet at 28b0000/             ranges
>> fabric/                       sata at a000000/
>> gpio at 4000000/                 sysctrl/
>> gpio at 4001000/                 uart at 4007000/
>> gpio at 4002000/
>> / # cat /proc/device-tree/soc/
>>
>>
>>
>>>>
>>>> Thanks!
>>>>
>>>> Best Regards,
>>>> Wei
>>>>
>>>>>       Arnd
>>>>>
>>>>> .
>>>>>
>>>>
>>>>
>>>> _______________________________________________
>>>> linux-arm-kernel mailing list
>>>> linux-arm-kernel at lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>
>>> Tyler
>>>
>>> [1] http://kernelci.org/boot/all/job/arm-soc/kernel/v4.1-rc3-170-g28837bc3e732/
>>> [2] http://kernelci.org/boot/all/job/next/kernel/next-20150513/
>>> [3] https://ci.linaro.org/view/people/job/tbaker-boot-bisect-bot/28/console
>>>
>>> .
>>>
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> Cheers,
>
> Tyler
>
> [1] http://lava.kernelci.org/scheduler/job/85333/log_file

Cheers,

Tyler

[1] https://validation.linaro.org/scheduler/job/350310/log_file
