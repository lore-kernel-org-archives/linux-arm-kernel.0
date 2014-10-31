From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 31 Oct 2014 15:20:30 +0800
Subject: [PATCH v5 4/4] crypto: Add Allwinner Security System crypto
 accelerator
In-Reply-To: <20141030171933.GR21251@lukather>
References: <1413728182-13569-1-git-send-email-clabbe.montjoie@gmail.com>
 <1413728182-13569-5-git-send-email-clabbe.montjoie@gmail.com>
 <20141021191149.GQ21108@lukather> <544A9FEA.6020304@gmail.com>
 <20141030171933.GR21251@lukather>
Message-ID: <20141031072030.GA7563@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 30, 2014 at 06:19:33PM +0100, Maxime Ripard wrote:
>
> > With AF_ALG and cryptodev, the SG is in highmem. Verified with some
> > PageHighMem().
> 
> Then fix AF_ALG and cryptodev, because all of the other drivers might
> be affected.

No it's the driver that needs to be fixed.  Of course if there
are enough drivers it may be worthwhile adding either copying or
a software fallback for highmem requests.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
