From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 1 Jun 2016 00:51:42 -0700
Subject: [RFC v2] dma-mapping: Use unsigned long for dma_attrs
In-Reply-To: <574E746A.2030806@samsung.com>
References: <1464609246-6948-1-git-send-email-k.kozlowski@samsung.com>
 <1464609246-6948-2-git-send-email-k.kozlowski@samsung.com>
 <20160531170420.GB25366@infradead.org>
 <574E746A.2030806@samsung.com>
Message-ID: <20160601075142.GA1700@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 01, 2016 at 07:36:42AM +0200, Krzysztof Kozlowski wrote:
> > No really for this patch, but I would much prefer to document them next
> > to the code in the long run.  Also I really think these BIT() macros
> > are a distraction compared to the (1 << N) notation.
> 
> Not much difference to me but maybe plain number:
> ...	0x01u
> ...	0x02u
> ?

I prefer the little bit shifts, but even the explicit values are much
better than the obsfucating macros :)  Anyway, your patch and in the end
all three methods will get the work done.

> > I'd just kill this helper, much easier to simply open code it in the
> > caller.
> 
> Keeping it for now helps reducing the number of changes in the patch.
> The patch will be quite big as it has to replace all the uses atomically.
> 
> I can get rid of the helper in consecutive patch.

Sounds fine.
