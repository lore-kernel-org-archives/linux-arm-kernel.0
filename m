From: rnayak@ti.com (Rajendra Nayak)
Date: Fri, 11 Feb 2011 10:51:37 +0530
Subject: [PATCH 3/3] OMAP4: clockdomain: Add wkup/sleep dependency support
In-Reply-To: <alpine.DEB.2.00.1102102209080.21991@utopia.booyaka.com>
References: <1297084631-27474-1-git-send-email-rnayak@ti.com>
	<1297084631-27474-2-git-send-email-rnayak@ti.com>
	<1297084631-27474-3-git-send-email-rnayak@ti.com>
	<1297084631-27474-4-git-send-email-rnayak@ti.com>
	<alpine.DEB.2.00.1102101905160.21991@utopia.booyaka.com>
	<3754d10e94217aa81846aa1d41fe0a9d@mail.gmail.com>
	<alpine.DEB.2.00.1102102135220.21991@utopia.booyaka.com>
	<74b7dfbe67e19da4358f7df0bc4dd8f1@mail.gmail.com>
	<alpine.DEB.2.00.1102102209080.21991@utopia.booyaka.com>
Message-ID: <478620b0abf7ff99cb41192dd4ee9e6d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Paul Walmsley [mailto:paul at pwsan.com]
> Sent: Friday, February 11, 2011 10:44 AM
> To: Rajendra Nayak
> Cc: linux-omap at vger.kernel.org; Kevin Hilman; Benoit Cousson;
linux-arm-kernel at lists.infradead.org
> Subject: RE: [PATCH 3/3] OMAP4: clockdomain: Add wkup/sleep dependency
support
>
> Hi Rajendra
>
> On Fri, 11 Feb 2011, Rajendra Nayak wrote:
>
> > Failing silently is going to make it more difficult to identify and
fix.
> > Maybe a WARN in else?
> >
> > 	if (cd->clkdm) {
> > 		...
> > 	} else
> > 		WARN()
>
> I was thinking it might be nice to put it right next to the
> _clkdm_lookup()s in clkdm_init(), since the _clkdm_lookup is what is
> actually failing.  Then we could do a
>
> if (!cd->clkdm)
> 	continue;
>
> in the SoC-specific *_all_wkdep/sleepdep* code, just to keep the system
> from crashing...
>
> Does that sound okay to you?

Yep, that sounds better.

Thanks,
Rajendra

>
>
> - Paul
