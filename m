From: lee.jones@linaro.org (Lee Jones)
Date: Sun, 20 Sep 2015 05:39:02 +0100
Subject: [PATCH v2 0/7] hwrng: Add support for STMicroelectronics' RNG IP
In-Reply-To: <20150920012347.GA21913@gondor.apana.org.au>
References: <1442497557-9271-1-git-send-email-lee.jones@linaro.org>
 <20150918140756.GK9249@gondor.apana.org.au>
 <CAF2Aj3h7Jy=tpYdZTdbxAJwa=147_hAu3reOFrbEh=JdrMFWLQ@mail.gmail.com>
 <20150918151137.GA10763@gondor.apana.org.au>
 <20150918155112.GE3218@x1>
 <20150918231213.GA14278@gondor.apana.org.au>
 <20150919092145.GG3218@x1>
 <20150920012347.GA21913@gondor.apana.org.au>
Message-ID: <20150920043902.GA3039@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 20 Sep 2015, Herbert Xu wrote:

> On Sat, Sep 19, 2015 at 10:21:45AM +0100, Lee Jones wrote:
> >
> > That's not how it works.  It's helpful, more often than not, to submit
> > the entire set to each maintainer concerned so they can keep up with
> > the general conversation.  By only sending specific patches to
> > maintainers you essentially blinker them to the bigger picture.
> > 
> > As a maintainer you should _know_ that you can't apply patches from
> > other subsystems without appropriate Acks.  I'm sure you'd take
> > exception to another maintainer who started accepting patches for
> > subsystems you are responsible for.  This works both ways.
> 
> No you are mistaken.  You should only put patches which have
> dependencies on each other in a series.  If the patches can be
> applied independently of each other there is no need to have
> them in a single series.

That's just not true.  I've explained why it's important for everyone
involved to see the bigger picture.  Let me use this set in an
example.  The patches can (and should) be applied separately, but they
are heavily entwined.  Let's say I only sent the ARM patch to Maxime
(the STi Maintainer) and only sent you the driver and the binding
document.  There's a chance Maxime could apply the DTS changes prior
to a proper review of the bindings.  Granted, one way round this would
be to place the DTS changes into a holding-pen until the binding has
been accepted, but this method is highly impractical and puts
unnecessary burden on the contributor.

There are 1000's of examples where all parties need to see reviews on
other, related but not dependant, parts of a set.  For many of the
sets I review it's critical for me what else is going on in related
diffs.  I guess for the subsystems you maintain it's less of an issue,
but still, it _is_ how people tend to submit code and there is no good
reason for you to dictate otherwise.

> Obviously if they can go into different trees then they cannot
> have dependencies.
> 
> Cheers,

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
