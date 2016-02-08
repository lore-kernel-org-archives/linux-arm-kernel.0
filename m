From: ian.campbell@citrix.com (Ian Campbell)
Date: Mon, 8 Feb 2016 15:59:32 +0000
Subject: [PATCH] xen/arm: correctly handle DMA mapping of compound pages
In-Reply-To: <alpine.DEB.2.02.1602081542410.27008@kaball.uk.xensource.com>
References: <1454938450-26282-1-git-send-email-ian.campbell@citrix.com>
 <alpine.DEB.2.02.1602081542410.27008@kaball.uk.xensource.com>
Message-ID: <1454947172.17191.4.camel@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-02-08 at 15:46 +0000, Stefano Stabellini wrote:
> On Mon, 8 Feb 2016, Ian Campbell wrote:
> > Currently xen_dma_map_page concludes that DMA to anything other than
> > the head page of a compound page must be foreign, since the PFN of the
> > page is that of the head.
> > 
> > Fix the check to instead consider the whole of a compound page to be
> > local if the PFN of the head passes the 1:1 check.
> > 
> > We can never see a compound page which is a mixture of foreign and
> > local sub-pages.
> > 
> > The comment already correctly described the intention, but fixup the
> > spelling and some grammar.
> > 
> > This fixes the various SSH protocol errors which we have been seeing
> > on the cubietrucks in our automated test infrastructure.
> > 
> > This has been broken since "xen/arm: use hypercall to flush caches in
> > map_page" (3567258d281b), which was in v3.19-rc1.
> 
> checkpatch.pl reports a small style issue with this statement.

Damn, I added that para after I'd already run checkpatch.

> [...]
> 
> To take care of 64k pages, this needs to be:
> 
{...]

> Since you are at it, it might be worth adding brackets.

Will do on both counts. v2 on its way.

Ian.
