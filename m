From: prylowski@metasoft.pl (Rafal Prylowski)
Date: Fri, 08 Feb 2013 09:33:19 +0100
Subject: [PATCH 2/2] ARM: ep93xx: bump IRQ offset to 64
In-Reply-To: <1360168544-20376-1-git-send-email-linus.walleij@linaro.org>
References: <1360168544-20376-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <5114B84F.10103@metasoft.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[added H Hartley Sweeten to CC list]

Hi Linus,

I boot-tested your patch on EDB9315A with 3.8rc6 kernel.
No problems observed; if you want, you can add:
Tested-by: Rafal Prylowski <prylowski@metasoft.pl>

Here is boot console log:

Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0x0
Linux version 3.8.0-rc6EP-1+ (prylowski at server2.localdomain) (gcc version 4.6.3
(GCC) ) #1367 Fri Feb 8 09:08:21 CET 2013
CPU: ARM920T [41129200] revision 0 (ARMv4T), cr=c0007177
CPU: VIVT data cache, VIVT instruction cache
Machine: Cirrus Logic EDB9315A Evaluation Board
bootconsole [earlycon0] enabled
Memory policy: ECC disabled, Data cache writeback
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16192
Kernel command line: root=/dev/nfs nfsroot=192.168.0.2:/DATA/ARM/EP93XX/rootfs/_
_isdn2net-1.38.1.09/rootfs ip=dhcp console=ttyAM0 earlyprintk
PID hash table entries: 256 (order: -2, 1024 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
__ex_table already sorted, skipping sort
Memory: 32MB 32MB = 64MB total
Memory: 61196k/61196k available, 4340k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xc6800000 - 0xff000000   ( 904 MB)
    lowmem  : 0xc0000000 - 0xc6000000   (  96 MB)
      .text : 0xc0008000 - 0xc034f91c   (3359 kB)
      .init : 0xc0350000 - 0xc036beb0   ( 112 kB)
      .data : 0xc036c000 - 0xc0393000   ( 156 kB)
       .bss : 0xc0393000 - 0xc03a5080   (  73 kB)
SLUB: Genslabs=13, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
NR_IRQS:184
VIC @fefb0000: id 0x00041190, vendor 0x41
VIC @fefc0000: id 0x00041190, vendor 0x41
sched_clock: 32 bits at 100 Hz, resolution 10000000ns, wraps every 4294967286ms
Console: colour dummy device 80x30
Calibrating delay loop... 99.73 BogoMIPS (lpj=498688)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
Setting up static identity map for 0xc02b71c8 - 0xc02b7204
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
ep93xx clock: PLL1 running at 400 MHz, PLL2 at 192 MHz
ep93xx clock: FCLK 200 MHz, HCLK 100 MHz, PCLK 50 MHz
bio: create slab <bio-0> at 0
ep93xx-dma ep93xx-dma-m2p: EP93xx M2P DMA ready
ep93xx-dma ep93xx-dma-m2m: EP93xx M2M DMA ready
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
i2c-gpio i2c-gpio.0: using pins 49 (SDA) and 48 (SCL)
NET: Registered protocol family 2
TCP established hash table entries: 512 (order: 0, 4096 bytes)
TCP bind hash table entries: 512 (order: -1, 2048 bytes)
TCP: Hash tables configured (established 512 bind 512)
TCP: reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
jffs2: version 2.2. (NAND) ?? 2001-2006 Red Hat, Inc.
msgmni has been set to 119
io scheduler noop registered
io scheduler deadline registered (default)
Serial: AMBA driver
apb:uart1: ttyAM0 at MMIO 0x808c0000 (irq = 116) is a AMBA
console [ttyAM0] enabled, bootconsole disabled
console [ttyAM0] enabled, bootconsole disabled
apb:uart2: ttyAM1 at MMIO 0x808d0000 (irq = 118) is a AMBA
apb:uart3: ttyAM2 at MMIO 0x808e0000 (irq = 119) is a AMBA
ep93xx-ide ep93xx-ide: version 1.0
scsi0 : ep93xx-ide
ata1: PATA max UDMA/66 irq 104
physmap platform flash device: 01000000 at 60000000
physmap-flash.0: Found 1 x16 devices at 0x0 in 16-bit bank. Manufacturer ID 0x00
0089 Chip ID 0x000018
Intel/Sharp Extended Query Table at 0x0031
Intel/Sharp Extended Query Table at 0x0031
Using buffer write method
cfi_cmdset_0001: Erase suspend on write enabled
Searching for RedBoot partition table in physmap-flash.0 at offset 0xfe0000
5 RedBoot partitions found on MTD device physmap-flash.0
Creating 5 MTD partitions on "physmap-flash.0":
0x000000000000-0x000000040000 : "RedBoot"
0x000000120000-0x000000920000 : "root.jffs2"
0x000000920000-0x000000a80000 : "kernel"
0x000000fc0000-0x000000fc1000 : "RedBoot config"
mtd: partition "RedBoot config" doesn't end on an erase block -- force read-only
0x000000fe0000-0x000001000000 : "FIS directory"
ep93xx-spi ep93xx-spi.0: master is unqueued, this is deprecated
ep93xx-spi ep93xx-spi.0: EP93xx SPI Controller at 0x808a0000 irq 117
ep93xx-eth version 0.1 loading
eth0: ep93xx on-chip ethernet, IRQ 103, 00:60:2b:03:43:d5
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ep93xx-ohci ep93xx-ohci: EP93xx OHCI
ep93xx-ohci ep93xx-ohci: new USB bus registered, assigned bus number 1
ep93xx-ohci ep93xx-ohci: irq 120, io mem 0x80020000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
ep93xx-rtc ep93xx-rtc: rtc core: registered ep93xx-rtc as rtc0
softdog: Software Watchdog Timer: 0.08 initialized. soft_noboot=0 soft_margin=60
 sec soft_panic=0 (nowayout=0)
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
TCP: cubic registered
NET: Registered protocol family 17
NET: Registered protocol family 15
Key type dns_resolver registered
drivers/rtc/hctosys.c: unable to open rtc device (rtc1)
Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 192.168.0.1, my address is 192.168.0.49
IP-Config: Complete:
     device=eth0, hwaddr=00:60:2b:03:43:d5, ipaddr=192.168.0.49, mask=255.255.25
5.0, gw=192.168.0.1
     host=192.168.0.49, domain=, nis-domain=(none)
     bootserver=0.0.0.0, rootserver=192.168.0.2, rootpath=
     nameserver0=192.168.0.1VFS: Mounted root (nfs filesystem) on device 0:10.
Freeing init memory: 108K
init started: BusyBox v1.19.3 (2012-04-25 12:12:10 CEST)
ip: RTNETLINK answers: File exists
ip: SIOCSIFHWADDR: Device or resource busy
ip: RTNETLINK answers: File exists
ln: /etc/mtab: File exists

Please press Enter to activate this console. udevd[433]: specified group 'audio'
 unknown




BusyBox v1.19.3 (2012-04-25 12:12:10 CEST) built-in shell (ash)
Enter 'help' for a list of built-in commands.

# cat /proc/interrupts
           CPU0
 68:       1727      GPIO  ep93xx timer
 81:          0      GPIO  ep93xx-pata-rx
 82:          0      GPIO  ep93xx-pata-tx
103:       2086       VIC  eth0
104:          0       VIC  ep93xx-ide
116:        115       VIC  uart-pl010
117:          0       VIC  ep93xx-spi
120:          0       VIC  ohci_hcd:usb1
Err:          0
#


Thanks,
RP.


On 2013-02-06 17:35, Linus Walleij wrote:
> The EP93XX IRQs offset from zero, which is illegal, since Linux
> IRQ 0 is NO_IRQ.
> 
> Cc: Florian Fainelli <florian@openwrt.org>
> Cc: Ryan Mallon <rmallon@gmail.com>
> Cc: Todor Colov <todorcolov@gmail.com>
> Cc: Rafal Prylowski <prylowski@metasoft.pl>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> It'd be nice if someone using the EP93xx could test this patch
> on top of the latest v3.8 RC.
> ---
>  arch/arm/mach-ep93xx/core.c              |   6 +-
>  arch/arm/mach-ep93xx/include/mach/irqs.h | 122 ++++++++++++++++---------------
>  2 files changed, 67 insertions(+), 61 deletions(-)
> 
> diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
> index e85bf17..4490b04 100644
> --- a/arch/arm/mach-ep93xx/core.c
> +++ b/arch/arm/mach-ep93xx/core.c
> @@ -179,8 +179,10 @@ struct sys_timer ep93xx_timer = {
>   *************************************************************************/
>  void __init ep93xx_init_irq(void)
>  {
> -	vic_init(EP93XX_VIC1_BASE, 0, EP93XX_VIC1_VALID_IRQ_MASK, 0);
> -	vic_init(EP93XX_VIC2_BASE, 32, EP93XX_VIC2_VALID_IRQ_MASK, 0);
> +	vic_init(EP93XX_VIC1_BASE, EP93XX_VIC1_IRQ_BASE,
> +		 EP93XX_VIC1_VALID_IRQ_MASK, 0);
> +	vic_init(EP93XX_VIC2_BASE, EP93XX_VIC2_IRQ_BASE,
> +		 EP93XX_VIC2_VALID_IRQ_MASK, 0);
>  }
>  
>  
> diff --git a/arch/arm/mach-ep93xx/include/mach/irqs.h b/arch/arm/mach-ep93xx/include/mach/irqs.h
> index ff98390..a96c50e 100644
> --- a/arch/arm/mach-ep93xx/include/mach/irqs.h
> +++ b/arch/arm/mach-ep93xx/include/mach/irqs.h
> @@ -5,69 +5,73 @@
>  #ifndef __ASM_ARCH_IRQS_H
>  #define __ASM_ARCH_IRQS_H
>  
> -#define IRQ_EP93XX_COMMRX		2
> -#define IRQ_EP93XX_COMMTX		3
> -#define IRQ_EP93XX_TIMER1		4
> -#define IRQ_EP93XX_TIMER2		5
> -#define IRQ_EP93XX_AACINTR		6
> -#define IRQ_EP93XX_DMAM2P0		7
> -#define IRQ_EP93XX_DMAM2P1		8
> -#define IRQ_EP93XX_DMAM2P2		9
> -#define IRQ_EP93XX_DMAM2P3		10
> -#define IRQ_EP93XX_DMAM2P4		11
> -#define IRQ_EP93XX_DMAM2P5		12
> -#define IRQ_EP93XX_DMAM2P6		13
> -#define IRQ_EP93XX_DMAM2P7		14
> -#define IRQ_EP93XX_DMAM2P8		15
> -#define IRQ_EP93XX_DMAM2P9		16
> -#define IRQ_EP93XX_DMAM2M0		17
> -#define IRQ_EP93XX_DMAM2M1		18
> -#define IRQ_EP93XX_GPIO0MUX		19
> -#define IRQ_EP93XX_GPIO1MUX		20
> -#define IRQ_EP93XX_GPIO2MUX		21
> -#define IRQ_EP93XX_GPIO3MUX		22
> -#define IRQ_EP93XX_UART1RX		23
> -#define IRQ_EP93XX_UART1TX		24
> -#define IRQ_EP93XX_UART2RX		25
> -#define IRQ_EP93XX_UART2TX		26
> -#define IRQ_EP93XX_UART3RX		27
> -#define IRQ_EP93XX_UART3TX		28
> -#define IRQ_EP93XX_KEY			29
> -#define IRQ_EP93XX_TOUCH		30
> +#define EP93XX_VIC1_IRQ_BASE		64
> +#define EP93XX_VIC2_IRQ_BASE		(EP93XX_VIC1_IRQ_BASE + 32)
> +#define EP93XX_VIC2_IRQ_END		(EP93XX_VIC2_IRQ_BASE + 32)
> +
> +#define IRQ_EP93XX_COMMRX		(EP93XX_VIC1_IRQ_BASE + 2)
> +#define IRQ_EP93XX_COMMTX		(EP93XX_VIC1_IRQ_BASE + 3)
> +#define IRQ_EP93XX_TIMER1		(EP93XX_VIC1_IRQ_BASE + 4)
> +#define IRQ_EP93XX_TIMER2		(EP93XX_VIC1_IRQ_BASE + 5)
> +#define IRQ_EP93XX_AACINTR		(EP93XX_VIC1_IRQ_BASE + 6)
> +#define IRQ_EP93XX_DMAM2P0		(EP93XX_VIC1_IRQ_BASE + 7)
> +#define IRQ_EP93XX_DMAM2P1		(EP93XX_VIC1_IRQ_BASE + 8)
> +#define IRQ_EP93XX_DMAM2P2		(EP93XX_VIC1_IRQ_BASE + 9)
> +#define IRQ_EP93XX_DMAM2P3		(EP93XX_VIC1_IRQ_BASE + 10)
> +#define IRQ_EP93XX_DMAM2P4		(EP93XX_VIC1_IRQ_BASE + 11)
> +#define IRQ_EP93XX_DMAM2P5		(EP93XX_VIC1_IRQ_BASE + 12)
> +#define IRQ_EP93XX_DMAM2P6		(EP93XX_VIC1_IRQ_BASE + 13)
> +#define IRQ_EP93XX_DMAM2P7		(EP93XX_VIC1_IRQ_BASE + 14)
> +#define IRQ_EP93XX_DMAM2P8		(EP93XX_VIC1_IRQ_BASE + 15)
> +#define IRQ_EP93XX_DMAM2P9		(EP93XX_VIC1_IRQ_BASE + 16)
> +#define IRQ_EP93XX_DMAM2M0		(EP93XX_VIC1_IRQ_BASE + 17)
> +#define IRQ_EP93XX_DMAM2M1		(EP93XX_VIC1_IRQ_BASE + 18)
> +#define IRQ_EP93XX_GPIO0MUX		(EP93XX_VIC1_IRQ_BASE + 19)
> +#define IRQ_EP93XX_GPIO1MUX		(EP93XX_VIC1_IRQ_BASE + 20)
> +#define IRQ_EP93XX_GPIO2MUX		(EP93XX_VIC1_IRQ_BASE + 21)
> +#define IRQ_EP93XX_GPIO3MUX		(EP93XX_VIC1_IRQ_BASE + 22)
> +#define IRQ_EP93XX_UART1RX		(EP93XX_VIC1_IRQ_BASE + 23)
> +#define IRQ_EP93XX_UART1TX		(EP93XX_VIC1_IRQ_BASE + 24)
> +#define IRQ_EP93XX_UART2RX		(EP93XX_VIC1_IRQ_BASE + 25)
> +#define IRQ_EP93XX_UART2TX		(EP93XX_VIC1_IRQ_BASE + 26)
> +#define IRQ_EP93XX_UART3RX		(EP93XX_VIC1_IRQ_BASE + 27)
> +#define IRQ_EP93XX_UART3TX		(EP93XX_VIC1_IRQ_BASE + 28)
> +#define IRQ_EP93XX_KEY			(EP93XX_VIC1_IRQ_BASE + 29)
> +#define IRQ_EP93XX_TOUCH		(EP93XX_VIC1_IRQ_BASE + 30)
>  #define EP93XX_VIC1_VALID_IRQ_MASK	0x7ffffffc
>  
> -#define IRQ_EP93XX_EXT0			32
> -#define IRQ_EP93XX_EXT1			33
> -#define IRQ_EP93XX_EXT2			34
> -#define IRQ_EP93XX_64HZ			35
> -#define IRQ_EP93XX_WATCHDOG		36
> -#define IRQ_EP93XX_RTC			37
> -#define IRQ_EP93XX_IRDA			38
> -#define IRQ_EP93XX_ETHERNET		39
> -#define IRQ_EP93XX_EXT3			40
> -#define IRQ_EP93XX_PROG			41
> -#define IRQ_EP93XX_1HZ			42
> -#define IRQ_EP93XX_VSYNC		43
> -#define IRQ_EP93XX_VIDEO_FIFO		44
> -#define IRQ_EP93XX_SSP1RX		45
> -#define IRQ_EP93XX_SSP1TX		46
> -#define IRQ_EP93XX_GPIO4MUX		47
> -#define IRQ_EP93XX_GPIO5MUX		48
> -#define IRQ_EP93XX_GPIO6MUX		49
> -#define IRQ_EP93XX_GPIO7MUX		50
> -#define IRQ_EP93XX_TIMER3		51
> -#define IRQ_EP93XX_UART1		52
> -#define IRQ_EP93XX_SSP			53
> -#define IRQ_EP93XX_UART2		54
> -#define IRQ_EP93XX_UART3		55
> -#define IRQ_EP93XX_USB			56
> -#define IRQ_EP93XX_ETHERNET_PME		57
> -#define IRQ_EP93XX_DSP			58
> -#define IRQ_EP93XX_GPIO_AB		59
> -#define IRQ_EP93XX_SAI			60
> +#define IRQ_EP93XX_EXT0			(EP93XX_VIC2_IRQ_BASE + 0)
> +#define IRQ_EP93XX_EXT1			(EP93XX_VIC2_IRQ_BASE + 1)
> +#define IRQ_EP93XX_EXT2			(EP93XX_VIC2_IRQ_BASE + 2)
> +#define IRQ_EP93XX_64HZ			(EP93XX_VIC2_IRQ_BASE + 3)
> +#define IRQ_EP93XX_WATCHDOG		(EP93XX_VIC2_IRQ_BASE + 4)
> +#define IRQ_EP93XX_RTC			(EP93XX_VIC2_IRQ_BASE + 5)
> +#define IRQ_EP93XX_IRDA			(EP93XX_VIC2_IRQ_BASE + 6)
> +#define IRQ_EP93XX_ETHERNET		(EP93XX_VIC2_IRQ_BASE + 7)
> +#define IRQ_EP93XX_EXT3			(EP93XX_VIC2_IRQ_BASE + 8)
> +#define IRQ_EP93XX_PROG			(EP93XX_VIC2_IRQ_BASE + 9)
> +#define IRQ_EP93XX_1HZ			(EP93XX_VIC2_IRQ_BASE + 10)
> +#define IRQ_EP93XX_VSYNC		(EP93XX_VIC2_IRQ_BASE + 11)
> +#define IRQ_EP93XX_VIDEO_FIFO		(EP93XX_VIC2_IRQ_BASE + 12)
> +#define IRQ_EP93XX_SSP1RX		(EP93XX_VIC2_IRQ_BASE + 13)
> +#define IRQ_EP93XX_SSP1TX		(EP93XX_VIC2_IRQ_BASE + 14)
> +#define IRQ_EP93XX_GPIO4MUX		(EP93XX_VIC2_IRQ_BASE + 15)
> +#define IRQ_EP93XX_GPIO5MUX		(EP93XX_VIC2_IRQ_BASE + 16)
> +#define IRQ_EP93XX_GPIO6MUX		(EP93XX_VIC2_IRQ_BASE + 17)
> +#define IRQ_EP93XX_GPIO7MUX		(EP93XX_VIC2_IRQ_BASE + 18)
> +#define IRQ_EP93XX_TIMER3		(EP93XX_VIC2_IRQ_BASE + 19)
> +#define IRQ_EP93XX_UART1		(EP93XX_VIC2_IRQ_BASE + 20)
> +#define IRQ_EP93XX_SSP			(EP93XX_VIC2_IRQ_BASE + 21)
> +#define IRQ_EP93XX_UART2		(EP93XX_VIC2_IRQ_BASE + 22)
> +#define IRQ_EP93XX_UART3		(EP93XX_VIC2_IRQ_BASE + 23)
> +#define IRQ_EP93XX_USB			(EP93XX_VIC2_IRQ_BASE + 24)
> +#define IRQ_EP93XX_ETHERNET_PME		(EP93XX_VIC2_IRQ_BASE + 25)
> +#define IRQ_EP93XX_DSP			(EP93XX_VIC2_IRQ_BASE + 26)
> +#define IRQ_EP93XX_GPIO_AB		(EP93XX_VIC2_IRQ_BASE + 27)
> +#define IRQ_EP93XX_SAI			(EP93XX_VIC2_IRQ_BASE + 28)
>  #define EP93XX_VIC2_VALID_IRQ_MASK	0x1fffffff
>  
> -#define NR_EP93XX_IRQS			(64 + 24)
> +#define NR_EP93XX_IRQS			(EP93XX_VIC2_IRQ_END + 24)
>  
>  #define EP93XX_BOARD_IRQ(x)		(NR_EP93XX_IRQS + (x))
>  #define EP93XX_BOARD_IRQS		32
> 
