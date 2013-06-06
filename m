From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 6 Jun 2013 10:27:24 +0100
Subject: [Xen-devel] [PATCH v4 5/6] arm64/xen: introduce CONFIG_XEN on
 ARM64
In-Reply-To: <1370509419.24512.224.camel@zakaz.uk.xensource.com>
References: <alpine.DEB.2.02.1306051605030.4589@kaball.uk.xensource.com>
 <1370451727-26826-5-git-send-email-stefano.stabellini@eu.citrix.com>
 <1370509419.24512.224.camel@zakaz.uk.xensource.com>
Message-ID: <20130606092723.GC28479@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 06, 2013 at 10:03:39AM +0100, Ian Campbell wrote:
> On Wed, 2013-06-05 at 18:02 +0100, Stefano Stabellini wrote:
> > + * the second in r1/x1, the third in r2/x2 and the fourth in r3/x3.
> > + * Considering that Xen hypercalls have 5 arguments at most, the fifth
> > + * paramter is always passed in r4/x4, differently from the ARM
> > + * procedure calling convention of using the stack for that case.
> 
> and "parameter" again.
> 
> Strictly speaking the fifth argument handling only differs from the
> 32-bit PCS, not the 64-bit one. Splitting hairs a bit there.

I agree, just add "the fifth in x4" without "differently from ...", it's
not relevant. You can also remove references to r? registers, they are
only called x?.

-- 
Catalin
