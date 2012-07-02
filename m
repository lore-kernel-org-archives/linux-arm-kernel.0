From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 2 Jul 2012 13:37:03 +0200
Subject: [PATCH v5 4/9] arm: mach-mvebu: add support for Armada 370 and
 Armada XP with DT
In-Reply-To: <4FEB30A7.3000809@codethink.co.uk>
References: <1340805290-9051-1-git-send-email-gregory.clement@free-electrons.com>
 <1340805290-9051-5-git-send-email-gregory.clement@free-electrons.com>
 <4FEB30A7.3000809@codethink.co.uk>
Message-ID: <20120702133703.7c693ed3@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Wed, 27 Jun 2012 17:11:19 +0100,
Ben Dooks <ben.dooks@codethink.co.uk> a ?crit :

> > diff --git a/arch/arm/mach-mvebu/common.h b/arch/arm/mach-mvebu/common.h
> > index f0eaa21..1b1e679 100644
> > --- a/arch/arm/mach-mvebu/common.h
> > +++ b/arch/arm/mach-mvebu/common.h
> > @@ -17,4 +17,7 @@
> >
> >   void mvebu_restart(char mode, const char *cmd);
> 
> If you set it when you probed the device, you'd not need
> to export it in the header.

As per the discussion with Russell King on your patch 3/3 about the
restart() hook, we had to keep this function prototype as it is.

> > +void armada_370_xp_init_irq(void);
> > +asmlinkage void  armada_370_xp_handle_irq(struct pt_regs *regs);
> 
> You shouldn't need linkage info with a function declaration.

Good point, fixed!

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
