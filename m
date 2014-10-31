From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 31 Oct 2014 16:18:03 +0800
Subject: [PATCH v5 4/4] crypto: Add Allwinner Security System crypto
 accelerator
In-Reply-To: <20141031081323.GS21251@lukather>
References: <1413728182-13569-1-git-send-email-clabbe.montjoie@gmail.com>
 <1413728182-13569-5-git-send-email-clabbe.montjoie@gmail.com>
 <20141021191149.GQ21108@lukather> <544A9FEA.6020304@gmail.com>
 <20141030171933.GR21251@lukather>
 <20141031072030.GA7563@gondor.apana.org.au>
 <20141031081323.GS21251@lukather>
Message-ID: <20141031081803.GA8012@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 31, 2014 at 09:13:23AM +0100, Maxime Ripard wrote:
>
> I don't understand here. Why would other drivers *not* being affected?
> 
> If the scatter list passed by AF_ALG can be in highmem, I guess it's
> the case for every driver out there. Almost every kernel code I've
> seen so far makes the assumption that the memory it has is mapped and
> accessible.
> 
> Somehow, it's the driver's fault now, and not the part of kernel that
> actually does the allocation?

If you are implementing a crypto driver that is meant to handle
requests from the crypto API then yes you need to handle highmem.

As I said if enough drivers are unable to address highmem and
require copying/software fallbacks then we could provide this
through the API and the driver would then only need to declare
its lack of highmem support or use a helper.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
