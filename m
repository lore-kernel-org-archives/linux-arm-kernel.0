From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Oct 2012 18:21:27 +0000
Subject: [PATCH 5/9] ARM: Xen: fix initial build problems:
In-Reply-To: <alpine.DEB.2.02.1210091630170.29539@kaball.uk.xensource.com>
References: <1349796183-30648-1-git-send-email-arnd@arndb.de>
 <1349796183-30648-6-git-send-email-arnd@arndb.de>
 <alpine.DEB.2.02.1210091630170.29539@kaball.uk.xensource.com>
Message-ID: <201210091821.27818.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 October 2012, Stefano Stabellini wrote:
> >  config XEN
> >       bool "Xen guest support on ARM (EXPERIMENTAL)"
> >       depends on EXPERIMENTAL && ARM && OF
> > +     depends on !CPU_V6
> >       help
> >         Say Y if you want to run Linux in a Virtual Machine on Xen on ARM.
> 
> Considering that we rely on the virtualization extensions, this one can
> be:
> 
>     depends on CPU_V7
> 
> The rest looks fine. I can submit a second patch to change !CPU_V6 into
> CPU_V7 later, if you prefer.

CPU_V6 and CPU_V7 are not exclusive, I saw the problem when building a
combined kernel for both V6 and V7. The code also needs to depend on ARMv7
with virtualization extensions, but that is a different issue. We don't
actually have a configuration symbol for that yet, as far as I can tell.

	Arnd
