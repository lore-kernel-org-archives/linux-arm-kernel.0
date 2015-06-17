From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 17 Jun 2015 17:34:02 +0200
Subject: [PATCH v7 05/14] crypto: marvell/CESA: add TDMA support
In-Reply-To: <20150617150808.GA14915@gondor.apana.org.au>
References: <20150617122533.GA13185@gondor.apana.org.au>
 <1434547922-10363-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150617150808.GA14915@gondor.apana.org.au>
Message-ID: <20150617173402.7946bbb0@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 17 Jun 2015 23:08:08 +0800
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> On Wed, Jun 17, 2015 at 03:32:02PM +0200, Boris Brezillon wrote:
> >
> > Hi Herbert,
> > 
> > I send you this patch alone so that you can verify I'm now properly
> > manipulating the SG list. Once I have your confirmation I'll send
> > the whole series again and annoy all the people in Cc one more time
> > ;-).
> 
> Thanks.  The only problem that I can see is the fact you're not
> checking for req->src == req->dst.  If they're equal then you must
> not map it twice.  Instead it should be mapped as DMA_BIDIRECTIONAL.

I can check for that too, but note that it doesn't prevent one from
providing different scatterlist structures pointing to the same memory
region.
This being said, checking for req->src == req->dst should fix the case
where dst and src are pointing to the same scatterlist, which is a good
start.

Thanks,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
