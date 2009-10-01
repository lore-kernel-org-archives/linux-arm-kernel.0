From: simon.kagstrom@netinsight.net (Simon Kagstrom)
Date: Thu, 1 Oct 2009 11:26:44 +0200
Subject: [PATCH] ARM: OpenRD base: Initialize PCI express, i2c and UART 1
In-Reply-To: <4A9540B7.1000404@einfochips.com>
References: <20090826094230.574eda24@marrow.netinsight.se>
	<20090826155708.3dfe4ad2@marrow.netinsight.se>
	<4A9540B7.1000404@einfochips.com>
Message-ID: <20091001112644.3bc72ba9@marrow.netinsight.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Aug 2009 19:33:35 +0530
Dhaval Vasa <dhaval.vasa@einfochips.com> wrote:

> Simon Kagstrom wrote:
> > On Wed, 26 Aug 2009 09:42:30 +0200
> > Simon Kagstrom <simon.kagstrom@netinsight.net> wrote:
> > 
> >> ARM: OpenRD base: Initialize PCI express, i2c and UART 1
> > 
> >> diff --git a/arch/arm/mach-kirkwood/openrd_base-setup.c b/arch/arm/mach-kirkwood/openrd_base-setup.c
> >> index f9a2166..003db06 100644
> >> --- a/arch/arm/mach-kirkwood/openrd_base-setup.c
> >> +++ b/arch/arm/mach-kirkwood/openrd_base-setup.c
> >> @@ -64,6 +64,7 @@ static void __init openrd_base_init(void)
> >>  	kirkwood_mpp_conf(openrd_base_mpp_config);
> >>  
> >>  	kirkwood_uart0_init();
> >> +	kirkwood_uart1_init();
> > 
> > After looking at the openrd design I realised that this might not be
> > such a hot idea. The UART1 pins are multiplexed with the SD card, so
> > I'm not sure what happens if you have both of these initialized at the
> > same time.
> > 
> > Anyone knows how Kirkwood behaves when on-board devices use pins which
> > are multiplexed for something else?
> > 
> 
> On Marvell LSP, default SD card is selected; and user has an option of 
> selecting UART (either RS-232 or RS-485) using command line argument and 
> u-boot environment variable.
> 
> Even if you initialize both at the same time, there is no issue as 
> selection of SD/UART1 is based on MPP (GPIO) pin - 28, 34.
> 
> I am working on patch to add SD/UART1 selection for in-tree.  So, you 
> can keep this init routine.

A small ping about this patch: Is it acceptable as it is or should I
rework it (since apparently it's safe anyway)?

// Simon
