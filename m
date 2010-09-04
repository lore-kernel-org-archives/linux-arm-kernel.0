From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 4 Sep 2010 11:55:50 +0100
Subject: [PATCH 4/6] ARM: Do not call test_for_ipi or test_for_ltrirq
	on UP systems
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02CCFE7590@dbde02.ent.ti.com>
References: <20100819073810.GR12184@atomide.com>
	<4C6CFBAF.6020407@canonical.com>
	<20100819095705.GU12184@atomide.com>
	<20100819102025.GA32151@n2100.arm.linux.org.uk>
	<20100820120622.GL25742@atomide.com>
	<20100830225527.GC11597@atomide.com>
	<20100902133637.GJ26319@n2100.arm.linux.org.uk>
	<20100902161659.GJ11597@atomide.com>
	<20100902162124.GN11597@atomide.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02CCFE7590@dbde02.ent.ti.com>
Message-ID: <20100904105550.GB12674@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 03, 2010 at 05:30:57PM +0530, Shilimkar, Santosh wrote:
> > diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
> > index bb2ef60..b8c1ec7 100644
> > --- a/arch/arm/kernel/entry-armv.S
> > +++ b/arch/arm/kernel/entry-armv.S
> > @@ -40,6 +40,11 @@
> >  	bne	asm_do_IRQ
> > 
> >  #ifdef CONFIG_SMP
> Do we need this code to be under " CONFIG_SMP" now ?

Yes, otherwise we get link errors for things like do_IPI and do_local_timer.
