From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 2 Feb 2016 11:16:16 +0800
Subject: [PATCH 02/11] crypto: sunxi-ss: prevent compilation on 64-bit
In-Reply-To: <1454348370-3816-3-git-send-email-andre.przywara@arm.com>
References: <1454348370-3816-1-git-send-email-andre.przywara@arm.com>
 <1454348370-3816-3-git-send-email-andre.przywara@arm.com>
Message-ID: <20160202031616.GA16987@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 01, 2016 at 05:39:21PM +0000, Andre Przywara wrote:
> The driver for the sunxi-ss crypto engine is not entirely 64-bit safe,
> compilation on arm64 spits some warnings.
> The proper fix was deemed to involved [1], so since 64-bit SoCs won't
> have this IP block we just disable this driver for 64-bit.
> 
> [1]: http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/399988.html
>      (and the reply)
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

I still use COMPILE_TEST to test compile these drivers.  So while
I don't have a problem with this patch per se, please continue to
ensure that it doesn't generate warnings on 64-bit platforms.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
