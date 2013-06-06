From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 6 Jun 2013 17:19:13 +0100
Subject: [PATCH v3 5/6] arm64/xen: introduce CONFIG_XEN and hypercall.S
 on ARM64
In-Reply-To: <20130606144212.GK28479@arm.com>
References: <alpine.DEB.2.02.1306041712100.4589@kaball.uk.xensource.com>
 <1370434530-22428-5-git-send-email-stefano.stabellini@eu.citrix.com>
 <1471793.18ZhhAHKN9@wuerfel> <20130606144212.GK28479@arm.com>
Message-ID: <alpine.DEB.2.02.1306061703570.4589@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 6 Jun 2013, Catalin Marinas wrote:
> Hi Arnd,
> 
> On Wed, Jun 05, 2013 at 01:44:55PM +0100, Arnd Bergmann wrote:
> > On Wednesday 05 June 2013 13:15:29 Stefano Stabellini wrote:
> > > diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> > > index c95c5cb..79dd13d 100644
> > > --- a/arch/arm64/Makefile
> > > +++ b/arch/arm64/Makefile
> > > @@ -37,6 +37,7 @@ TEXT_OFFSET := 0x00080000
> > >  export TEXT_OFFSET GZFLAGS
> > >  
> > >  core-y         += arch/arm64/kernel/ arch/arm64/mm/
> > > +core-$(CONFIG_XEN)             += arch/arm64/xen/
> > >  libs-y         := arch/arm64/lib/ $(libs-y)
> > >  libs-y         += $(LIBGCC)
> > >  
> > > diff --git a/arch/arm64/xen/Makefile b/arch/arm64/xen/Makefile
> > > new file mode 100644
> > > index 0000000..be24040
> > > --- /dev/null
> > > +++ b/arch/arm64/xen/Makefile
> > > @@ -0,0 +1,2 @@
> > > +xen-arm-y      += $(addprefix ../../arm/xen/, enlighten.o grant-table.o)
> > > +obj-y          := xen-arm.o hypercall.o
> > 
> > I think it would be nicer to redirect the entire directory, not just
> > the enlighten.o and grant-table.o files. You could do in arch/arm64/Makefile:
> > 
> > core-(CONFIG_XEN) += arch/arm/xen/
> > 
> > That leaves a small difference in hypercall.o, which I think you can
> > handle with an #ifdef.
> 
> Sorry, I missed this part. I want to keep the AArch64 assembly under
> arm64, even if it is small.

That's fine, I don't have a strong opinion on this, I am happy either way.

In this case the v3 of the series is the one we want.
I'll submit a pull request to you for it during the next couple of days.
