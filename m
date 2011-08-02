From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 2 Aug 2011 16:11:15 +0800
Subject: [PATCH v8 0/3] add the GPMI controller driver for IMX23/IMX28
In-Reply-To: <4E37970C.4070903@freescale.com>
References: <20110722055731.GI26837@S2100-06.ap.freescale.net>
	<4E292FCF.6010608@freescale.com>
	<CAHMSPgMHrqWcJ=BThDLgQ=XyTBDCMvNS4SVjQWfk=Jf682TEig@mail.gmail.com>
	<4E2F6F90.7030207@freescale.com>
	<CAHMSPgPC4whyskfuFGeFd7WHx-=5htezWajm_rNi9Xa+03PV0A@mail.gmail.com>
	<20018.24364.787244.956361@ipc1.ka-ro>
	<CAHMSPgM5W8=mE4sRDGMMfo39fvThBo_jrdG8hyhJNQ_ceV=_pA@mail.gmail.com>
	<4E32823C.3060007@freescale.com>
	<CAHMSPgMTf1UnMyvsSZM1in-FEAoWyS5VSdczsxfHgujGJ0DFtw@mail.gmail.com>
	<4E37970C.4070903@freescale.com>
Message-ID: <20110802081115.GC17297@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 02, 2011 at 02:19:56PM +0800, Huang Shijie wrote:
> Hi,
> >On Fri, Jul 29, 2011 at 11:49 AM, Huang Shijie<b32955@freescale.com>  wrote:
> >>? 2011?07?29? 15:40, Koen Beel ??:
> >>>Hi,
> >>>
> >>>On Fri, Jul 29, 2011 at 9:20 AM, Lothar Wa?mann<LW@karo-electronics.de>
> >>>  wrote:
> >>>>Hi,
> >>>>
> >>>>Koen Beel writes:
> >>>>>Hi,
> >>>>>
> >>>>>I have test on mx23evk board. Still see the same issues.
> >>>>>
> >>>>>On Wed, Jul 27, 2011 at 3:53 AM, Huang Shijie<b32955@freescale.com>
> >>>>>  wrote:
> >>>>>>Hi,
> >>>>>>
> >>>>>>Thanks for your test.
> >>>>>>
> >>>>>>>Hi,
> >>>>>>>
> >>>>>>>It's not really working for me.
> >>>>>>>I've applied all gpmi-nand driver patches and the dma driver patches.
> >>>>>>>
> >>>>>>>I have added following kernel parameters:
> >>>>>>>mtdparts=gpmi-nand:20m(boot),-(user) ubi.mtd=1 root=ubi0:rootfs0
> >>>>>>>rootfstype=ubifs gpmi_debug_init
> >>>>>>>
> >>>>>>>During boot I get already get DMA timeout:
> >>>>>>>[    2.560000] [ start_dma_without_bch_irq : 392 ] DMA timeout, last
> >>>>>>>DMA
> >>>>>>>:1
> >>>>>>>[    3.560000] [ start_dma_with_bch_irq : 427 ] bch timeout!!!
> >>>>>>>...
> >>>>>>>(see log file in attach line 89)
> >>>>>I still see this DMA timeout when booting.
> >>>>>What kernel parameters do you use? I still use same as above.
> >>>>>
> >>>>Do you have an SD card in the system? I'm getting the same error when
> >>>>accessing an SD card. Without SD card I can use the flash without any
> >>>>errors.
> >>>No SD card in the system. At least not on my mx23evk board.
> >>>My real target hardware has a SDIO wifi chip.
> >>Does it conflict with the GPMI?
> >Well I don't know if it conflicts. From what Lothar says I assume
> >there might be a conflict between gpmi and sdio.
> Yes, the conflict between gpmi and other module(such as SD in MX6Q)
> is THE prime reason
> which caused the DMA timeout.
> 
> I am debuging the IMX6Q now, and meet the same problem.
> 
I do not follow on this.  SD on i.mx6q does not use apbh-dma at all.
How will it conflict with gpmi regarding to dma timeout?

-- 
Regards,
Shawn
