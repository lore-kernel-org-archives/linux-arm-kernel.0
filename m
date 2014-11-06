From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 6 Nov 2014 22:32:18 +0800
Subject: [PATCH v5 4/4] crypto: Add Allwinner Security System crypto
 accelerator
In-Reply-To: <20141106142633.GK2989@lukather>
References: <544A9FEA.6020304@gmail.com> <20141030171933.GR21251@lukather>
 <20141031072030.GA7563@gondor.apana.org.au>
 <20141031081323.GS21251@lukather>
 <20141031081803.GA8012@gondor.apana.org.au>
 <20141031095706.GA8054@lukather>
 <20141031100522.GA8655@gondor.apana.org.au>
 <20141103093446.GG11263@lukather>
 <20141103103528.GA30154@gondor.apana.org.au>
 <20141106142633.GK2989@lukather>
Message-ID: <20141106143217.GA3636@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 06, 2014 at 03:26:33PM +0100, Maxime Ripard wrote:
> 
> But you still haven't explain why the driver, while it doesn't handle
> the user space buffer at any time, should be worried that the data the
> framework has given him are actually mapped.

Encryption is used by IPsec and SKBs can be allocated in highmem.
algif also exposes all ciphers to user-space memory which can also
be in highmem.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
