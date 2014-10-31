From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 31 Oct 2014 18:05:22 +0800
Subject: [PATCH v5 4/4] crypto: Add Allwinner Security System crypto
 accelerator
In-Reply-To: <20141031095706.GA8054@lukather>
References: <1413728182-13569-1-git-send-email-clabbe.montjoie@gmail.com>
 <1413728182-13569-5-git-send-email-clabbe.montjoie@gmail.com>
 <20141021191149.GQ21108@lukather> <544A9FEA.6020304@gmail.com>
 <20141030171933.GR21251@lukather>
 <20141031072030.GA7563@gondor.apana.org.au>
 <20141031081323.GS21251@lukather>
 <20141031081803.GA8012@gondor.apana.org.au>
 <20141031095706.GA8054@lukather>
Message-ID: <20141031100522.GA8655@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 31, 2014 at 10:57:06AM +0100, Maxime Ripard wrote:
>
> On a 3.18-rc2 kernel:
> 
> $ git grep kmap -- crypto/
> crypto/ahash.c:                         walk->data = kmap(walk->pg);
> crypto/ahash.c:                         walk->data = kmap_atomic(walk->pg);
> crypto/async_tx/async_memcpy.c:         dest_buf = kmap_atomic(dest) + dest_offset;
> crypto/async_tx/async_memcpy.c:         src_buf = kmap_atomic(src) + src_offset;
> crypto/scatterwalk.c:                   return kmap_atomic(scatterwalk_page(walk)) +
> crypto/shash.c:                         data = kmap_atomic(sg_page(sg));
> crypto/shash.c:                         data = kmap_atomic(sg_page(sg));
> 
> None of the drivers are.

What do you mean? It's precisely because the page can be in highmem
that we are mapping it.  If it's not in highmem it'll be a noop.

Admittedly I haven't tested highmem since moving over to x86-64
some years ago, but it definitely used to work on x86-32.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
