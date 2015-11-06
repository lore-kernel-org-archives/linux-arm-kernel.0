From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 6 Nov 2015 12:56:39 +0800
Subject: [PATCH] crypto: sun4i-ss: add missing statesize
In-Reply-To: <20151105160719.GG6114@lukather>
References: <1446709737-11316-1-git-send-email-clabbe.montjoie@gmail.com>
 <20151105160719.GG6114@lukather>
Message-ID: <20151106045639.GA14722@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 05, 2015 at 08:07:19AM -0800, Maxime Ripard wrote:
> 
> On Thu, Nov 05, 2015 at 08:48:57AM +0100, LABBE Corentin wrote:
> > sun4i-ss implementaton of md5/sha1 is via ahash algorithms.
> > A recent change make impossible to load them without giving statesize.
> 
> Which one?

We recently disabled ahash drivers that do not declare statesize
because it can lead to a crash when the driver is used through
algif.

Not declaring statesize is a bug anyway but the fact that it
is exported through algif makes it much worse.

> > This patch specifiy statesize for sha1 and md5.
> > 
> > Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> > Cc: stable at vger.kernel.org
> 
> Please also add a Fixes tag (and the stable version it applies to).

I don't see the point for a fixes tag as it would simply refer
to the original patch-set that added the driver.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
