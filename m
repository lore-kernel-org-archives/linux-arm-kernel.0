From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Tue, 19 Feb 2013 17:28:21 +0000
Subject: [PATCH LINUX] xen: event channel arrays are xen_ulong_t and not
 unsigned long
In-Reply-To: <20130219172645.GA97631@ocelot.phlegethon.org>
References: <1361285327.1051.115.camel@zakaz.uk.xensource.com>
 <1361285357-26696-1-git-send-email-ian.campbell@citrix.com>
 <alpine.DEB.2.02.1302191642230.4654@kaball.uk.xensource.com>
 <1361294248.1051.136.camel@zakaz.uk.xensource.com>
 <20130219172645.GA97631@ocelot.phlegethon.org>
Message-ID: <1361294901.1051.137.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-02-19 at 17:26 +0000, Tim Deegan wrote:
> At 17:17 +0000 on 19 Feb (1361294248), Ian Campbell wrote:
> > On Tue, 2013-02-19 at 17:11 +0000, Stefano Stabellini wrote:
> > > On Tue, 19 Feb 2013, Ian Campbell wrote:
> > > > +/*
> > > > + * We cannot use xchg because it does not support 8-byte
> > > > + * values. However it is safe to use {ldr,dtd}exd directly because all
> > > > + * platforms which Xen can run on support those instructions.
> > > > + */
> > > > +static inline xen_ulong_t xchg_xen_ulong(xen_ulong_t *ptr, xen_ulong_t val)
> > > > +{
> > > > +       xen_ulong_t oldval;
> > > > +       unsigned int tmp;
> > > > +
> > > > +       wmb();
> > > > +       asm volatile("@ read_evtchn_pending_sel\n"
> > >                            ^ do we need this?
> > 
> > It means that the .s files (if you create them) and such are a bit more
> > readable, it's not that uncommon in the ARM inline assembly.
> 
> +1.  s/read_evtchn_pending_sel/xchg_xen_ulong/ though.

Damn, yes. I just sent v3 too :-(

Ian.
