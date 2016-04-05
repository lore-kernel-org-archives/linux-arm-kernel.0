From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 5 Apr 2016 20:49:43 +0800
Subject: [PATCH RESEND] crypto: sun4i-ss: Replace spinlock_bh by
 spin_lock_irq{save|restore}
In-Reply-To: <1458745884-27798-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1458745884-27798-1-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <20160405124943.GN13048@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2016 at 04:11:24PM +0100, LABBE Corentin wrote:
> The current sun4i-ss driver could generate data corruption when ciphering/deciphering.
> It occurs randomly on end of handled data.
> No root cause have been found and the only way to remove it is to replace
> all spin_lock_bh by their irq counterparts.
> 
> Fixes: 6298e948215f ("crypto: sunxi-ss - Add Allwinner Security System crypto accelerator")
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> Cc: stable <stable@vger.kernel.org>

Applied.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
