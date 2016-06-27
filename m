From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 27 Jun 2016 13:00:31 +0800
Subject: [PATCHv2 06/27] crypto: ahash: increase the maximum allowed
 statesize
In-Reply-To: <5770B283.8000902@ti.com>
References: <1466601840-18486-1-git-send-email-t-kristo@ti.com>
 <1466601840-18486-7-git-send-email-t-kristo@ti.com>
 <20160624103209.GA19607@gondor.apana.org.au>
 <5770B283.8000902@ti.com>
Message-ID: <20160627050031.GA5673@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 27, 2016 at 07:58:43AM +0300, Tero Kristo wrote:
>
> Ok, I think I need to allocate the storage space locally then within
> the driver. Would it be ok to call kmalloc / free in the export /
> import implementation of the driver? The size of the unhashed buffer
> in omap-sham is unfortunately rather large.

The allocation should usually be done from the request_alloc
function, i.e., you set the reqsize and the user does the allocation
for you.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
