From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 22 Jun 2016 18:33:24 +0800
Subject: [PATCH v3 02/10] crypto: marvell: Check engine is not already
 running when enabling a req
In-Reply-To: <1466496520-28806-3-git-send-email-romain.perier@free-electrons.com>
Message-ID: <20160622103324.GA30918@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Romain Perier <romain.perier@free-electrons.com> wrote:
> Add a BUG_ON() call when the driver tries to launch a crypto request
> while the engine is still processing the previous one. This replaces
> a silent system hang by a verbose kernel panic with the associated
> backtrace to let the user know that something went wrong in the CESA
> driver.

Hmm, so how can this happen? If it is triggerable then we better
try to recover from it more gracefully.  If it is not triggerable
then why bother?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
