From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 30 Sep 2015 15:50:34 +0100
Subject: [PATCH v2 0/7] hwrng: Add support for STMicroelectronics' RNG IP
In-Reply-To: <20150930142812.GA19039@gondor.apana.org.au>
References: <1442497557-9271-1-git-send-email-lee.jones@linaro.org>
 <20150918140756.GK9249@gondor.apana.org.au>
 <CAF2Aj3h7Jy=tpYdZTdbxAJwa=147_hAu3reOFrbEh=JdrMFWLQ@mail.gmail.com>
 <20150918151137.GA10763@gondor.apana.org.au>
 <20150918155112.GE3218@x1> <20150929142932.GY27197@x1>
 <20150930134757.GA18408@gondor.apana.org.au>
 <20150930141539.GD27197@x1>
 <20150930142812.GA19039@gondor.apana.org.au>
Message-ID: <20150930145034.GE27197@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Sep 2015, Herbert Xu wrote:
> On Wed, Sep 30, 2015 at 03:15:39PM +0100, Lee Jones wrote:
> >
> > > I prefer not to merge patches that cannot be tested.  Without
> > > the DT bits in patch 6 the other five patches are useless.  So
> > > I think patch 6 should be applied together with the other five
> > > which add the driver.
> > 
> > That's crazy talk.  If all subsystem maintainers abide by this rule
> > there would be chaos.  We'd either need to send pull-requests to each
> > other for every set which crossed a subsystems boundary, or 1000's of
> > merge conflicts would ensue at merge time.
> > 
> > The (sensible) rule we normally stick to is; as long as there isn't
> > a _build_ dependency, then the patches should filter though their
> > respective trees; _functional_ dependencies have nothing to do with
> > us as maintainers.  Another chaos preventing rule we abide by is; thou
> > shalt not apply patches belonging to other maintainer's subsystems
> > without the appropriate Ack-by and a subsequent "you may take this
> > though your tree" and/or "please send me an immutable pull-request".
> 
> So you want the series to be merged in two parts via two different
> trees where neither can be tested? That sounds crazy to me.

Who is going to checkout the HWRNG tree and run-test it on it's own on
all of the required hardware?  No one.  Agreed, subsystem trees should
be bisectably (new word? :D) buildable as per my first rule above, but
that's it.  Per-subsystem repos are not designed to be tested for
full-functionality orthogonally, that's the point of Stephen's -next
tree.

Please take my other points into consideration too.  The kernel would
be unmainatinable if we all stuck to your rule.  No-one else has that
rule, and for good reason.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
