From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Mar 2012 13:39:36 +0000
Subject: [PATCH] ARM: SPEAr600: Add device-tree support to SPEAr600 boards
In-Reply-To: <201203151138.51508.sr@denx.de>
References: <1331650032-15274-1-git-send-email-sr@denx.de>
 <4F61AFAB.6080301@st.com> <201203151138.51508.sr@denx.de>
Message-ID: <201203151339.36173.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 March 2012, Stefan Roese wrote:
> On Thursday 15 March 2012 10:00:27 Viresh Kumar wrote:
> > On 3/15/2012 2:18 PM, Stefan Roese wrote:
> > >>> > > +static const struct of_device_id vic_of_match[] __initconst = {
> > >>> > > +     { .compatible = "arm,pl190-vic", .data = vic_of_init, },
> > >>> > > +     { /* Sentinel */ }
> > >>> > > +};
> > >>> > > +
> > >>> > > +static void __init spear6xx_dt_init_irq(void)
> > >>> > > +{
> > >>> > > +     of_irq_init(vic_of_match);
> > >>> > > +}
> > >>> > > +
> > >> > 
> > >> > What about adding this routine in vic.c file, which can then be used
> > >> > by all platforms, instead of replicating this code.
> > > 
> > > We can't move vic_of_match to the vic.c, since there are differences
> > > between the boards using it. And only moving spear6xx_dt_init_irq()
> > > (renamed of course) doesn't seem worth it.
> > 
> > I knew this. Actually my thought was, we have two compatible strings for
> > vic: pl190 and pl192.
> > 
> > So, create two vic_of_match* arrays and two vic*_dt_init_irq() routines.
> > That will solve the issue i believe.
> 
> I still don't think its worth it. But please feel free to send an add-on 
> patch, to "clean this up".

What's wrong with one vic_dt_init_irq() function and an array with two entries?

	Arnd
