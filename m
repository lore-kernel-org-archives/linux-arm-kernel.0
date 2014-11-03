From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 3 Nov 2014 10:34:46 +0100
Subject: [PATCH v5 4/4] crypto: Add Allwinner Security System crypto
 accelerator
In-Reply-To: <20141031100522.GA8655@gondor.apana.org.au>
References: <1413728182-13569-1-git-send-email-clabbe.montjoie@gmail.com>
 <1413728182-13569-5-git-send-email-clabbe.montjoie@gmail.com>
 <20141021191149.GQ21108@lukather> <544A9FEA.6020304@gmail.com>
 <20141030171933.GR21251@lukather>
 <20141031072030.GA7563@gondor.apana.org.au>
 <20141031081323.GS21251@lukather>
 <20141031081803.GA8012@gondor.apana.org.au>
 <20141031095706.GA8054@lukather>
 <20141031100522.GA8655@gondor.apana.org.au>
Message-ID: <20141103093446.GG11263@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 31, 2014 at 06:05:22PM +0800, Herbert Xu wrote:
> On Fri, Oct 31, 2014 at 10:57:06AM +0100, Maxime Ripard wrote:
> >
> > On a 3.18-rc2 kernel:
> > 
> > $ git grep kmap -- crypto/
> > crypto/ahash.c:                         walk->data = kmap(walk->pg);
> > crypto/ahash.c:                         walk->data = kmap_atomic(walk->pg);
> > crypto/async_tx/async_memcpy.c:         dest_buf = kmap_atomic(dest) + dest_offset;
> > crypto/async_tx/async_memcpy.c:         src_buf = kmap_atomic(src) + src_offset;
> > crypto/scatterwalk.c:                   return kmap_atomic(scatterwalk_page(walk)) +
> > crypto/shash.c:                         data = kmap_atomic(sg_page(sg));
> > crypto/shash.c:                         data = kmap_atomic(sg_page(sg));
> > 
> > None of the drivers are.
> 
> What do you mean? It's precisely because the page can be in highmem
> that we are mapping it.  If it's not in highmem it'll be a noop.

What I mean is that since you are saying that drivers should do the
kmap themselves, then *all* of the drivers are broken if they are not
using it. And all of them are missing this kmap.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141103/645f2c2e/attachment-0001.sig>
