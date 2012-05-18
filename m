From: horms@verge.net.au (Simon Horman)
Date: Fri, 18 May 2012 12:30:42 +0900
Subject: [PATCH 00/08] mach-shmobile: Emma Mobile EV2 support V3
In-Reply-To: <20120518014424.GL19000@verge.net.au>
References: <20120516064449.32286.77941.sendpatchset@w520>
 <20120518014424.GL19000@verge.net.au>
Message-ID: <20120518033041.GA15280@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 18, 2012 at 10:44:26AM +0900, Simon Horman wrote:
> Hi Magnus,
> 
> I have tested these patches on top of the soc-new branch of
> rafael's renesas tree, revision 5658c94, which is based on
> v3.4-rc6.
> 
> I also have the cherry picked following patches before applying your patches.
> 
> serial8250-em: clk_get() IS_ERR() error handling fix
> serial8250-em: Emma Mobile UART driver V2
> serial8250: Introduce serial8250_register_8250_port()
> serial8250: Clean up default map and dl code
> serial8250: Use dl_read()/dl_write() on RM9K
> serial8250: Use dl_read()/dl_write() on Alchemy
> serial8250: Add dl_read()/dl_write() callbacks
> 8250.c: less than 2400 baud fix.
> serial/8250_pci: Clear FIFOs for Intel ME Serial Over Lan device on BI
> tegra, serial8250: add ->handle_break() uart_port op
> clocksource: em_sti: Add DT support
> clocksource: em_sti: Emma Mobile STI driver V2
> clockevents: Make clockevents_config() a global symbol
> 
> I have added the follwing patch of yours
> 
> gpio: Emma Mobile GPIO driver V2
> 
> And one of my own, which just fixes a build problem
> in rafael's tree.
> 
> ARM: mach-types: Manually add KZM-A9-GT
> 
> On Wed, May 16, 2012 at 03:44:49PM +0900, Magnus Damm wrote:
> > mach-shmobile: Emma Mobile EV2 support V3
> > 
> > [PATCH 01/08] mach-shmobile: Emma Mobile EV2 SoC base support V3
> 
> Tested-by: Simon Horman <horms@verge.net.au>
> 
> > [PATCH 02/08] ARM: Undelete KZM9D mach-type V3
> 
> I did not need this patch with the base I am using,
> so I did not test it.
> 
> Reviewed-by: Simon Horman <horms@verge.net.au>
> 
> > [PATCH 03/08] mach-shmobile: KZM9D board support V3
> 
> Tested-by: Simon Horman <horms@verge.net.au>
> 
> > [PATCH 04/08] mach-shmobile: Emma Mobile EV2 SMP support V3
> 
> Tested-by: Simon Horman <horms@verge.net.au>
> 
> > [PATCH 05/08] mach-shmobile: Emma Mobile EV2 GPIO support V3
> 
> I am only seeing interripts for em_gio.0, is there a
> way to exercise em_gio.1 .. 4 ?
> 
> Duplicate names for interrupts, that is
> each of em_gio.0..4 have two entries in /proc/interripts.
> Is this intentional?
> 
>  99:         32          0       GIC  em_gio.0
>  100:          0          0       GIC  em_gio.0
>  101:          0          0       GIC  em_gio.1
>  102:          0          0       GIC  em_gio.1
>  103:          0          0       GIC  em_gio.2
>  104:          0          0       GIC  em_gio.2
>  105:          0          0       GIC  em_gio.3
>  106:          0          0       GIC  em_gio.3
>  107:          0          0       GIC  em_gio.4
>  108:          0          0       GIC  em_gio.4
>  157:      35952          0       GIC  em_sti.0
> 
> > [PATCH 06/08] mach-shmobile: KZM9D board Ethernet support V3
> 
> Tested-by: Simon Horman <horms@verge.net.au>
> 
> > [PATCH 07/08] mach-shmobile: Emma Mobile EV2 DT support V3
> 
> I applied this and the resulting kernel booted.
> 
> > [PATCH 08/08] mach-shmobile: Use DT_MACHINE for KZM9D V3
> 
> I applied this and the resulting kernel did not boot.
> I saw nothing after the uboot prompt..

Thanks for walking me through how to manually adding the dtb to the zImage.

Tested-by: Simon Horman <horms@verge.net.au>

> Lastly, could you consider suppling a patch which provides a defconfig?
