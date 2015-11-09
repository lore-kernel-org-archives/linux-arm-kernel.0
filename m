From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 09 Nov 2015 17:16:05 +0100
Subject: [PATCH 1/3] xen/arm: introduce xen_read_wallclock
In-Reply-To: <alpine.DEB.2.02.1511091348440.23825@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1511051706560.13541@kaball.uk.xensource.com>
 <7480268.6Ff8Mvx46N@wuerfel>
 <alpine.DEB.2.02.1511091348440.23825@kaball.uk.xensource.com>
Message-ID: <17175481.GKnbuH0F1P@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 November 2015 13:53:30 Stefano Stabellini wrote:
> On Fri, 6 Nov 2015, Arnd Bergmann wrote:
> > I'm not quite sure about how the split between pvclock_wall_clock and
> > the delta works. Normally I'd expect that pvclock_wall_clock is the wallclock
> > time as it was at boot, while delta is the number of expired nanoseconds
> > since boot. However it is unclear why the latter has a longer range
> > (539 years starting at boot, rather than 126 years starting in 1970).
> 
> Actually we already have a sec overflow field in struct shared_info on
> the hypervisor side, called wc_sec_hi. I just need to make use of it in
> Linux. See:
> 
> http://xenbits.xen.org/gitweb/?p=xen.git;a=blob_plain;f=xen/include/public/xen.h;hb=HEAD
> 
> Thanks for raising my attention to the problem,

Sounds good for Xen on ARM. This same interface is also used on
KVM, right? Does the extension also work there?

	Arnd
