From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Mon, 22 Jul 2013 16:00:20 -0400
Subject: [PATCH v3] xen/arm: enable PV control for ARM
In-Reply-To: <alpine.DEB.2.02.1307221545030.4893@kaball.uk.xensource.com>
References: <1374490654-13373-1-git-send-email-julien.grall@linaro.org>
 <20130722134934.GB32221@e106331-lin.cambridge.arm.com>
 <alpine.DEB.2.02.1307221459200.4893@kaball.uk.xensource.com>
 <20130722143920.GC32221@e106331-lin.cambridge.arm.com>
 <alpine.DEB.2.02.1307221545030.4893@kaball.uk.xensource.com>
Message-ID: <20130722200020.GT30300@phenom.dumpdata.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 22, 2013 at 03:46:34PM +0100, Stefano Stabellini wrote:
> On Mon, 22 Jul 2013, Mark Rutland wrote:
> > On Mon, Jul 22, 2013 at 03:09:35PM +0100, Stefano Stabellini wrote:
> > > On Mon, 22 Jul 2013, Mark Rutland wrote:
> > > > Hi,
> > > > 
> > > > [Adding Catalin to Cc]
> > > > 
> > > > On Mon, Jul 22, 2013 at 11:57:34AM +0100, Julien Grall wrote:
> > > > > Enable power management from the toolstack for ARM guest.
> > > > > 
> > > > > Signed-off-by: Julien Grall <julien.grall@linaro.org>
> > > > > 
> > > > > ---
> > > > >     Changes in v3:
> > > > >         - Fix condition to compile cpu_hotplug.o
> > > > >     Changes in v2:
> > > > >         - Don't compile xen/cpu_hotplug.o with ARM64
> > > > 
> > > > My arm64 cpu hotplug series is going to be dependent on not compiling
> > > > xen/cpu_hotplug.o. Currently I'm not able to compile an arm64 kernel
> > > > with my patches and Xen support.
> > > > 
> > > > How do you intend to push this? I'd like to ensure my cpu hotplug series
> > > > is able to go in for the next merge window.
> > > 
> > > This patch does exactly that: it makes sure cpu_hotplug is not compiled
> > > on ARM64.
> > 
> > Sorry, what I meant was that my series is going to be entirely dependent
> > on this patch or it'll break bisection. That'll make merging things a
> > little painful as I'll need a stable branch with this patch to base my
> > series upon.
> > 
> > Another option would be to split this patch into two parts, one enabling
> > power management and one fixing things up for HOTPLUG_CPU on arm64. That
> > way I could take the arm64 HOTPLUG_CPU fix in my series adding arm64
> > HOTPLUG_CPU support.
> > 
> > Would that be acceptable? Have I missed something?
> 
> As I am very sensitive to painful merging situations, I think we could
> split the patch in two and send upstream the fix (not compiling
> cpu_hotplug.o on ARM64) in 3.11-rc2 or rc3.  Konrad, what do you think?

Sure, prep a patch and send it my way.
