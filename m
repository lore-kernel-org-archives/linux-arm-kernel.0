From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 09 Nov 2015 21:45:50 +0100
Subject: [PATCH 3/3] xen/arm: set the system time in Xen via the
 XENPF_settime hypercall
In-Reply-To: <alpine.DEB.2.02.1511091741480.23825@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1511051706560.13541@kaball.uk.xensource.com>
 <alpine.DEB.2.02.1511091714460.23825@kaball.uk.xensource.com>
 <alpine.DEB.2.02.1511091741480.23825@kaball.uk.xensource.com>
Message-ID: <5034618.DZpKjPX0Jn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 November 2015 17:42:50 Stefano Stabellini wrote:
> On Mon, 9 Nov 2015, Stefano Stabellini wrote:
> > On Mon, 9 Nov 2015, Arnd Bergmann wrote:
> > > On Monday 09 November 2015 14:10:22 Stefano Stabellini wrote:
> > > 
> > > Just to make sure that this is actually the correct interface
> > > that you want to call:
> > > 
> > > __current_kernel_time{,64}() is the fastest interface we have
> > > to get an approximation of the current time, while ignoring
> > > all of the locking.
> > > 
> > > Is is possible that you instead want ktime_get_real_ts64(),
> > > which gives you the time as precise as the kernel knows it,
> > > but uses locking?
> > 
> > I am not 100% sure. Can I call ktime_get_real_ts64 from a
> > pvclock_gtod notifier_call function?
> 
> It doesn't look like it: we would be getting the tk_core seqcount twice.

Ok, I see. I'm still unsure what this is all good for, but at
least this call appears to be safe.

	Arnd
