From: willy@infradead.org (Matthew Wilcox)
Date: Wed, 16 May 2018 04:23:47 -0700
Subject: vm_fault_t conversion, for real
In-Reply-To: <20180516054348.15950-1-hch@lst.de>
References: <20180516054348.15950-1-hch@lst.de>
Message-ID: <20180516112347.GB20670@bombadil.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2018 at 07:43:34AM +0200, Christoph Hellwig wrote:
> this series tries to actually turn vm_fault_t into a type that can be
> typechecked and checks the fallout instead of sprinkling random
> annotations without context.

Yes, why should we have small tasks that newcomers can do when the mighty
Christoph Hellwig can swoop in and take over from them?  Seriously,
can't your talents find a better use than this?

> The first one fixes a real bug in orangefs, the second and third fix
> mismatched existing vm_fault_t annotations on the same function, the
> fourth removes an unused export that was in the chain.  The remainder
> until the last one do some not quite trivial conversions, and the last
> one does the trivial mass annotation and flips vm_fault_t to a __bitwise
> unsigned int - the unsigned means we also get plain compiler type
> checking for the new ->fault signature even without sparse.

Yes, that was (part of) the eventual goal.  Well done.  Would you like
a biscuit?
