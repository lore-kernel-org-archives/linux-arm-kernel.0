From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 10 Sep 2015 17:26:54 +0800
Subject: [PATCH] crypto: sun4i-ss Fix a possible driver hang with ciphers
In-Reply-To: <1441801627-31820-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1441801627-31820-1-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <20150910092654.GB28753@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 09, 2015 at 02:27:07PM +0200, LABBE Corentin wrote:
> The sun4i_ss_opti_poll function cipher data until the output miter have
> a length of 0.
> If the crypto API client, give more SGs than necessary this could result
> in an infinite loop.
> Fix it by checking for remaining bytes, just like sun4i_ss_cipher_poll().
> 
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>

Applied.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
