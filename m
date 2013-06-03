From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 3 Jun 2013 17:51:53 +0100
Subject: [PATCH v2 5/5] arm64/xen: introduce CONFIG_XEN and hypercall.S
 on ARM64
In-Reply-To: <20130603162517.GC32295@arm.com>
References: <alpine.DEB.2.02.1306031157020.4589@kaball.uk.xensource.com>
 <1370273624-26976-5-git-send-email-stefano.stabellini@eu.citrix.com>
 <20130603162517.GC32295@arm.com>
Message-ID: <alpine.DEB.2.02.1306031745460.4589@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 3 Jun 2013, Catalin Marinas wrote:
> On Mon, Jun 03, 2013 at 04:33:44PM +0100, Stefano Stabellini wrote:
> > --- /dev/null
> > +++ b/arch/arm64/xen/hypercall.S
> ...
> > +/*
> > + * The Xen hypercall calling convention is very similar to the ARM AEBI
> > + * procedure calling convention: the first paramter is passed in x0, the
> > + * second in x1, the third in x2 and the fourth in x3. Considering that
> > + * Xen hypercalls have 5 arguments at most, the fifth paramter is passed
> > + * in rx, differently from the procedure calling convention of using the
> > + * stack for that case.
> 
> You may want to use the AArch64 ABI here where parameters are passed in
> x0-x7, return in x0.

We already do this, we just need to update the comment.


> BTW, I think it's missing a MAINTAINERS file update.

Yep, I'll make those changes.


> Otherwise, the series looks good. How do you plan to upstream this?

Good question.
Traditionally Xen stuff goes to Linus directly via one of the Xen trees
(Konrad's or mine), but since this is the very first Xen patch series
for arm64 if you prefer I can submit a pull request to you instead.
Just let me know, I am happy either way.

In any case, are you OK with sending it upstream during the next merge
window?
