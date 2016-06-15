From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Wed, 15 Jun 2016 10:50:57 +0100
Subject: Versatile Express randomly fails to boot - Versatile Express to
 be removed from nightly testing
In-Reply-To: <57612092.2070504@arm.com>
References: <20150330140333.GJ24899@n2100.arm.linux.org.uk>
 <55196228.5050805@arm.com> <20150330150552.GK24899@n2100.arm.linux.org.uk>
 <55196E31.80803@arm.com> <551AD902.9090401@arm.com>
 <20150402141336.GI24899@n2100.arm.linux.org.uk> <551D7EAB.1000200@arm.com>
 <1465918285.2840.41.camel@linaro.org>
 <20160614155220.GB1041@n2100.armlinux.org.uk> <5760346A.10903@arm.com>
 <20160614164944.GC1041@n2100.armlinux.org.uk>
 <1465982868.2829.20.camel@linaro.org> <57612092.2070504@arm.com>
Message-ID: <1465984257.2829.27.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-06-15 at 10:32 +0100, Sudeep Holla wrote:
> > That didn't fix things, but I noticed this morning there are PL310
> > errata workarounds too that we should have enabled:
> >
> > PL310_ERRATA_769419
> > PL310_ERRATA_727915
> > PL310_ERRATA_588369
> >
> 
> I had all the above enabled in my config which doesn't help either.

Thanks for letting me know, that's saved me from a tedious morning of
testing. Though did you also have the A9 errata enabled?

BTW, I noticed the PL310 Cache ID reports RTL version 3, which doesn't
appear in the list of versions in cache-l2x0.h and doesn't match the TRM
shipped on the vexpress CD, which is for version 2 (r1p0).

Anyway, I'll test various Linux versions with the L2 cache removed from
device-tree to see if that reliably fixes things.

-- 
Tixy
