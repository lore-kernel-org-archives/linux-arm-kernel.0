From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 23 Jun 2016 18:44:57 +0800
Subject: [PATCH v3 02/10] crypto: marvell: Check engine is not already
 running when enabling a req
In-Reply-To: <576A753B.7070507@free-electrons.com>
References: <20160622103324.GA30918@gondor.apana.org.au>
 <576A753B.7070507@free-electrons.com>
Message-ID: <20160623104457.GC10350@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2016 at 01:23:39PM +0200, Romain Perier wrote:
> Hello,
> 
> Le 22/06/2016 12:33, Herbert Xu a ?crit :
> >Romain Perier <romain.perier@free-electrons.com> wrote:
> >>Add a BUG_ON() call when the driver tries to launch a crypto request
> >>while the engine is still processing the previous one. This replaces
> >>a silent system hang by a verbose kernel panic with the associated
> >>backtrace to let the user know that something went wrong in the CESA
> >>driver.
> >
> >Hmm, so how can this happen?
> If it is triggerable then we better
> >try to recover from it more gracefully.  If it is not triggerable
> >then why bother?
> >
> 
> Well, It does not happen with the current driver (in mainline). This
> is bug I had when I added support to chain requests. Take a look at
> the patch 008/010, it changes the way the requests are "prepared".
> If you really enable a request while the engine is running, that's
> very hard to debug. This is more useful to have a backtrace to let
> the user know that something is wrong instead of having a silent
> system hang. That's easier to debug and you can detect regressions.

OK.  All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
