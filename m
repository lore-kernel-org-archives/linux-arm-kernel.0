From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 18 May 2015 16:33:08 +0800
Subject: [PATCH v9 4/4] crypto: Add Allwinner Security System crypto
 accelerator
In-Reply-To: <20150518092449.2364d21e@bbrezillon>
References: <1431608341-10936-1-git-send-email-clabbe.montjoie@gmail.com>
 <1431608341-10936-5-git-send-email-clabbe.montjoie@gmail.com>
 <20150517104508.468b032f@bbrezillon>
 <20150517103440.GA7800@gondor.apana.org.au>
 <20150517124811.797fab32@bbrezillon>
 <20150518004121.GA11910@gondor.apana.org.au>
 <20150518092449.2364d21e@bbrezillon>
Message-ID: <20150518083308.GB18195@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 18, 2015 at 09:24:49AM +0200, Boris Brezillon wrote:
> 
> Okay, just to be sure, what does "Asynchronous" mean in ablkcipher or
> ahash ?
> Is it related to the fact that crypto operations can be done in
> multiple steps (e.g.: one set_key + several encrypt chunk operations),
> or is this something else ?

It gives you the ability to postpone the processing.  However
it doesn't mean that you have to postpone the processing.  For
instance, all of our sync software algorithms are also available
through the async interface for obvious reasons.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
