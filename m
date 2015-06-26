From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 26 Jun 2015 17:32:54 +0900
Subject: [PATCH] crypto: mv_cesa - fix up for of_get_named_gen_pool()
 rename
In-Reply-To: <20150625155605.GI4853@kw.sim.vm.gnt>
References: <CABxcv=m4juAMHaMYSB+8O8cEX+YZCJ0cArS2wN-YGpTBgWe-CA@mail.gmail.com>
 <1435221470-5382-1-git-send-email-simon.guinot@sequanux.org>
 <20150625153006.GA11513@gondor.apana.org.au>
 <20150625155605.GI4853@kw.sim.vm.gnt>
Message-ID: <20150626083254.GA18367@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 25, 2015 at 05:56:05PM +0200, Simon Guinot wrote:
> On Thu, Jun 25, 2015 at 11:30:06PM +0800, Herbert Xu wrote:
> > On Thu, Jun 25, 2015 at 10:37:50AM +0200, Simon Guinot wrote:
> > > This patch fixes the following build error:
> > > 
> > > drivers/crypto/mv_cesa.c: In function 'mv_cesa_get_sram':
> > > drivers/crypto/mv_cesa.c:1037: error: implicit declaration of function 'of_get_named_gen_pool'
> > > drivers/crypto/mv_cesa.c:1038: warning: assignment makes pointer from integer without a cast
> > > scripts/Makefile.build:258: recipe for target 'drivers/crypto/mv_cesa.o' failed
> > > 
> > > Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> > 
> > This patch doesn't compile.
> 
> It does compile. How it could not ?
> But since the issue has already been fixed, it doesn't really matter.

It breaks the build of mv_cesa in the crypto tree as well as the
cryptodev tree while without your patch the mv_cesa builds just
fine.  If your patch isn't meant for these trees then you should
clearly say so.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
