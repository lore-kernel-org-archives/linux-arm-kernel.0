From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 22 Sep 2016 18:46:03 +0800
Subject: [PATCH 0/8] crypto: omap-sham: convert to sg based data engine
In-Reply-To: <1474298539-23897-1-git-send-email-t-kristo@ti.com>
References: <1474298539-23897-1-git-send-email-t-kristo@ti.com>
Message-ID: <20160922104603.GJ5884@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2016 at 06:22:11PM +0300, Tero Kristo wrote:
> Hi,
> 
> This series converts the omap-sham buffer handling towards a scatterlist
> approach. This avoids the need to have a huge internal buffer within the
> driver, and also allows us to properly implement export/import for the
> driver. I tried splitting up the changes to some sane patches, but this
> was rather difficult due to the fact that this is largely a complete
> rewrite of portions of the driver. Patch #6 is a prime example of this
> being pretty large, but splitting this up would break bisectability.
> Hopefully the patch is still understandable though.
> 
> Crypto manager tests work fine at least on omap3/am3/am4/dra7 SoC:s.
> (Something is broken with test farm again and could not try omap2/omap4.)
> 
> Also tested tcrypt SHA performance on DRA7 and it seems to be working
> fine with different buffer sizes.
> 
> My test branch is also available here for interested parties:
> tree: https://github.com/t-kristo/linux-pm.git
> breanch: 4.8-rc1-crypto

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
