From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Wed, 10 Oct 2012 08:54:47 +0100
Subject: [Xen-devel] [PATCH 5/9] ARM: Xen: fix initial build problems:
In-Reply-To: <201210091821.27818.arnd@arndb.de>
References: <1349796183-30648-1-git-send-email-arnd@arndb.de>
 <1349796183-30648-6-git-send-email-arnd@arndb.de>
 <alpine.DEB.2.02.1210091630170.29539@kaball.uk.xensource.com>
 <201210091821.27818.arnd@arndb.de>
Message-ID: <1349855687.6952.75.camel@dagon.hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-10-09 at 19:21 +0100, Arnd Bergmann wrote:
> On Tuesday 09 October 2012, Stefano Stabellini wrote:
> > >  config XEN
> > >       bool "Xen guest support on ARM (EXPERIMENTAL)"
> > >       depends on EXPERIMENTAL && ARM && OF
> > > +     depends on !CPU_V6
> > >       help
> > >         Say Y if you want to run Linux in a Virtual Machine on Xen on ARM.
> > 
> > Considering that we rely on the virtualization extensions, this one can
> > be:
> > 
> >     depends on CPU_V7
> > 
> > The rest looks fine. I can submit a second patch to change !CPU_V6 into
> > CPU_V7 later, if you prefer.
> 
> CPU_V6 and CPU_V7 are not exclusive, I saw the problem when building a
> combined kernel for both V6 and V7. The code also needs to depend on ARMv7
> with virtualization extensions, but that is a different issue. We don't
> actually have a configuration symbol for that yet, as far as I can tell.

I don't think the guest kernels (including dom0) need the extensions to
run under Xen, they are only need by Xen itself. The guests should just
see a relatively normal v7 processor. 

Stefano, does that sound right?

Ian.
