From: will.deacon@arm.com (Will Deacon)
Date: Thu, 2 Sep 2010 11:40:08 +0100
Subject: [PATCH 45/74] SPEAr : SEV Send event to secondary CPUs
In-Reply-To: <20100902102256.GO26319@n2100.arm.linux.org.uk>
References: <cover.1283161023.git.viresh.kumar@st.com>	<861ddbfab51ade4893ef92df4bcfa9b203844a9c.1283161023.git.viresh.kumar@st.com>
	<20100902102256.GO26319@n2100.arm.linux.org.uk>
Message-ID: <003f01cb4a8b$372d0d00$a5872700$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

[added Jeff Ohlstein]

> On Mon, Aug 30, 2010 at 04:09:09PM +0530, Viresh KUMAR wrote:
> > diff --git a/arch/arm/mach-spear13xx/include/mach/smp.h b/arch/arm/mach-spear13xx/include/mach/smp.h
> > index 6e028a1..e2e55fc 100644
> > --- a/arch/arm/mach-spear13xx/include/mach/smp.h
> > +++ b/arch/arm/mach-spear13xx/include/mach/smp.h
> > @@ -24,6 +24,12 @@
> >  		cpunum &= 0x0F;				\
> >  	})
> >
> > +/*
> > + * set_event() is used to wake up secondary core from wfe using sev. Booting
> > + * code puts the second core into wfe(standby).
> > + */
> > +#define set_event()	__asm__ __volatile__ ("sev" : : : "memory")
> 
> This shouldn't be something that platforms define on their own.  Please
> add a sev() macro to arch/arm/include/asm/system.h instead.  Also take a
> look at arch/arm/mach-omap2/omap-smp.c for an alternative idea about how
> to handle this.

There was patch posted last month from Code Aurora:

http://lists.infradead.org/pipermail/linux-arm-kernel/2010-July/021401.html

which proposed adding a sev() macro to processor.h. They also added
a wfe() macro, so maybe all of this should go in system.h instead.

Will
