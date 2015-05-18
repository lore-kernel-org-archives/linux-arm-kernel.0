From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 18 May 2015 09:24:49 +0200
Subject: [PATCH v9 4/4] crypto: Add Allwinner Security System crypto
 accelerator
In-Reply-To: <20150518004121.GA11910@gondor.apana.org.au>
References: <1431608341-10936-1-git-send-email-clabbe.montjoie@gmail.com>
 <1431608341-10936-5-git-send-email-clabbe.montjoie@gmail.com>
 <20150517104508.468b032f@bbrezillon>
 <20150517103440.GA7800@gondor.apana.org.au>
 <20150517124811.797fab32@bbrezillon>
 <20150518004121.GA11910@gondor.apana.org.au>
Message-ID: <20150518092449.2364d21e@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Herbert,

On Mon, 18 May 2015 08:41:21 +0800
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> On Sun, May 17, 2015 at 12:48:11PM +0200, Boris Brezillon wrote:
> > 
> > Yep, but then they shouldn't be declared with CRYPTO_ALG_ASYNC and as an

                                                                  not ^

> > ablkcipher algorithm (*Asynchronous* Block Cipher), right ?
> 
> Right.  They can still use ablkcipher but should clear the ASYNC
> bit.

Okay, just to be sure, what does "Asynchronous" mean in ablkcipher or
ahash ?
Is it related to the fact that crypto operations can be done in
multiple steps (e.g.: one set_key + several encrypt chunk operations),
or is this something else ?

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
