From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 20 Jul 2013 19:38:47 +0200
Subject: [RESEND PATCH v7 00/22] MBus DT binding: The return of PCIe
In-Reply-To: <20130720165855.GB26625@lunn.ch>
References: <1373900271-4722-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130720165855.GB26625@lunn.ch>
Message-ID: <20130720173847.GC26625@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 20, 2013 at 06:58:55PM +0200, Andrew Lunn wrote:
> On Mon, Jul 15, 2013 at 11:57:29AM -0300, Ezequiel Garcia wrote:
> > Here's the new MBus DT binding, implementing the changes proposed
> > by Thomas when we discussed the previous patchset:
> > 
> >   http://www.spinics.net/lists/arm-kernel/msg257170.html
> > 
> > As far as I know, this round fixes *all* the concerns raised in the past
> > and therefore I'd like to get Acked-by's from all the parties involved
> > on the respective patches, and particularly for the DT binding.
> > 
> > If there's anything left to review, we'll be glad to fix it quickly,
> > so don't hesitate in providing your feedback!
> > 
> > I'm sure many of you are dying to test this new MBus thing, so to make
> > it easier for those courageous enough, I've pushed a public branch:
> > 
> >   https://github.com/MISL-EBU-System-SW/mainline-public/tree/marvell-mvebu-mbus-v7
> 
> Hi Ezequiel
> 
> I just tried this in my Kirkwood QNAP.
> 
> Uncompressing Linux... done, booting the kernel.
> Booting Linux on physical CPU 0x0
> Linux version 3.11.0-rc1-00022-g44e8c39 (lunn at londo.lunn.ch) (gcc version 4.3.43
> CPU: Feroceon 88FR131 [56251311] revision 1 (ARMv5TE), cr=00053977
> CPU: VIVT data cache, VIVT instruction cache
> Machine: Marvell Kirkwood (Flattened Device Tree), model: QNAP TS219 family
> bootconsole [earlycon0] enabled
> Memory policy: ECC disabled, Data cache writeback
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
> Kernel command line: root=/dev/sda2 console=ttyS0,115200 earlyprintk
> PID hash table entries: 2048 (order: 1, 8192 bytes)
> Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
> Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
> Memory: 513268K/524288K available (4247K kernel code, 241K rwdata, 1148K rodata)
> Virtual kernel memory layout:
>     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
>     vmalloc : 0xe0800000 - 0xff000000   ( 488 MB)
>     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
>     modules : 0xbf000000 - 0xc0000000   (  16 MB)
>       .text : 0xc0008000 - 0xc054d050   (5397 kB)
>       .init : 0xc054e000 - 0xc0576520   ( 162 kB)
>       .data : 0xc0578000 - 0xc05b4420   ( 242 kB)
>        .bss : 0xc05b4420 - 0xc064e104   ( 616 kB)
> SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> Preemptible hierarchical RCU implementation.
> NR_IRQS:114
> sched_clock: 32 bits at 200MHz, resolution 5ns, wraps every 21474ms
> Console: colour dummy device 80x30
> Calibrating delay loop... 1587.60 BogoMIPS (lpj=7938048)
> pid_max: default: 32768 minimum: 301
> Mount-cache hash table entries: 512
> CPU: Testing write buffer coherency: ok
> Setting up static identity map for 0xc040e888 - 0xc040e8c4
> pinctrl core: initialized pinctrl subsystem
> regulator-dummy: no parameters
> NET: Registered protocol family 16
> DMA: preallocated 256 KiB pool for atomic coherent allocations
> Kirkwood: MV88F6282-Rev-A0, TCLK=200000000.
> Feroceon L2: Enabling L2
> Feroceon L2: Cache support initialised.
> bio: create slab <bio-0> at 0
> mvebu-pcie pcie-controller.1: PCIe0.0: cannot get tgt/attr for mem window
> mvebu-pcie pcie-controller.1: PCIe1.0: cannot get tgt/attr for mem window

Hi Ezequiel

I just put some debug into mvebu_get_tgt_attr():

slot 0, PCI_SLOT(devfn) 1
type 512, rtype 512
slot 0, PCI_SLOT(devfn) 1
type 512, rtype 512
slot 0, PCI_SLOT(devfn) 1
type 512, rtype 512
slot 0, PCI_SLOT(devfn) 1
type 512, rtype 256
mvebu-pcie pcie-controller.1: PCIe0.0: cannot get tgt/attr for mem window -2
slot 0, PCI_SLOT(devfn) 2
type 512, rtype 512
slot 0, PCI_SLOT(devfn) 2
type 512, rtype 512
slot 0, PCI_SLOT(devfn) 2
type 512, rtype 512
slot 0, PCI_SLOT(devfn) 2
type 512, rtype 256

Any ideas?

    Thanks
	Andrew
