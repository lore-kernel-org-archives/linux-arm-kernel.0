From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 3 Jun 2013 17:43:29 +0100
Subject: [Xen-devel] [PATCH v2 5/5] arm64/xen: introduce CONFIG_XEN and
 hypercall.S on ARM64
In-Reply-To: <1370277455.24512.46.camel@zakaz.uk.xensource.com>
References: <alpine.DEB.2.02.1306031157020.4589@kaball.uk.xensource.com>
 <1370273624-26976-5-git-send-email-stefano.stabellini@eu.citrix.com>
 <20130603162517.GC32295@arm.com>
 <1370277455.24512.46.camel@zakaz.uk.xensource.com>
Message-ID: <20130603164329.GD32295@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 03, 2013 at 05:37:35PM +0100, Ian Campbell wrote:
> On Mon, 2013-06-03 at 17:25 +0100, Catalin Marinas wrote:
> > On Mon, Jun 03, 2013 at 04:33:44PM +0100, Stefano Stabellini wrote:
> > > --- /dev/null
> > > +++ b/arch/arm64/xen/hypercall.S
> > ...
> > > +/*
> > > + * The Xen hypercall calling convention is very similar to the ARM AEBI
> > > + * procedure calling convention: the first paramter is passed in x0, the
> > > + * second in x1, the third in x2 and the fourth in x3. Considering that
> > > + * Xen hypercalls have 5 arguments at most, the fifth paramter is passed
> 
>                                                           parameter
> 
> > > + * in rx, differently from the procedure calling convention of using the
> 
>           ^x4 not rx
> 
> > > + * stack for that case.
> > 
> > You may want to use the AArch64 ABI here where parameters are passed in
> > x0-x7, return in x0.
> 
> I think that is actually what we are doing (up to 5 arguments), the
> "Considering that ..." bit at the end is a left over of the 32 bit
> version I think.

Yes, only the comment needs updating.

-- 
Catalin
