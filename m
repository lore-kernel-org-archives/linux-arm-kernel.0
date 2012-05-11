From: horms@verge.net.au (Simon Horman)
Date: Fri, 11 May 2012 16:13:08 +0900
Subject: [PATCH] mach-shmobile: Emma Mobile EV2 SMP prototype code
In-Reply-To: <20120509075407.5991.60556.sendpatchset@w520>
References: <20120509075407.5991.60556.sendpatchset@w520>
Message-ID: <20120511071305.GD17741@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2012 at 04:54:07PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Prototype code that adds SMP support to EMEV2.
> 
> At this point only the most basic form of SMP operation
> is supported. TWD and CPU Hotplug support is excluded.
> 
> Based on V1 of the Emma Mobile EV2 code. Needs to be
> reworked to coexist with DT. Work in progress.

Hi Magnus,

I tried out this patch on top of the next branch of Rafael's
renesas tree (5658c94) plus V2 of your Emma Mobile EV2 code but
I am only seeing one CPU.  Do I need some other tweaks?

The list of patches I have applied is as follows:

mach-shmobile: Emma Mobile EV2 SMP prototype code
ARM: mach-types: Manually add KZM-A9-GT
mach-shmobile: KZM9D board prototype support
mach-shmobile: Emma Mobile EV2 SoC base support
serial8250-em: Add DT support
serial8250-em: clk_get() IS_ERR() error handling fix
serial8250-em: Emma Mobile UART driver V2
serial8250: Introduce serial8250_register_8250_port()
serial8250: Clean up default map and dl code
serial8250: Use dl_read()/dl_write() on RM9K
serial8250: Use dl_read()/dl_write() on Alchemy
serial8250: Add dl_read()/dl_write() callbacks
8250.c: less than 2400 baud fix.
serial/8250_pci: Clear FIFOs for Intel ME Serial Over Lan device on BI
tegra, serial8250: add ->handle_break() uart_port op
clocksource: em_sti: Add DT support
clocksource: em_sti: Emma Mobile STI driver V2
clockevents: Make clockevents_config() a global symbol


And yes, I did enable CONFIG_SMP :)
