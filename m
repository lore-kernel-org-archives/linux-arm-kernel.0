From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 8 Nov 2010 10:38:56 +0100
Subject: linux-next: omap2plus_defconfig not building
In-Reply-To: <eace9c309e371630528bc9f8fa208705@mail.gmail.com>
References: <4CBD707F.6050204@ti.com>
	<1287488255.18646.110.camel@e102109-lin.cambridge.arm.com>
	<eace9c309e371630528bc9f8fa208705@mail.gmail.com>
Message-ID: <20101108093856.GQ16938@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Nov 08, 2010 at 11:35:16AM +0530, Anand Gadiyar wrote:
> Catalin Marinas wrote:
> >
> > On Tue, 2010-10-19 at 11:18 +0100, Anand Gadiyar wrote:
> > > Commit ba1b9be5cd in linux-next (ARM: Add SWP/SWPB emulation for ARMv7
> > > processors (v5)) introduced arch/arm/kernel/swp_emulate.c. This file
> > > gets compiled when the omap2plus_defconfig is built - the
> > > omap2plus_defconfig builds OMAP2420, OMAP2430, OMAP3 and OMAP4 in one
> > > image, and has CPU_V6 and CPU_V7 both enabled.
> >
> > This patch should fix it:
> >
> >
> > ARM: Do not enable SWP emulation if CPU_V6 && CPU_V7
> >
> > From: Catalin Marinas <catalin.marinas@arm.com>
> >
> > This option uses LDREXB/STREXB to emulate SWPB but these instructions
> > are not supported on all the ARMv6 processors.
> >
> > Reported-by: Anand Gadiyar <gadiyar@ti.com>
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Leif Lindholm <Leif.Lindholm@arm.com>
> 
> Hi Catalin, Leif,
> 
> I can't find this patch in linux-next. Hope we haven't missed it.
> Tony acked this btw.
> 
> Strangely, the omap2plus_defconfig in v2.6.37-rc1 no longer gets
> CONFIG_SWP_EMULATE enabled even without this patch - I can't figure
> out why.
I guess that's simply because v2.6.37-rc1 doesn't have ba1b9be5cd.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
