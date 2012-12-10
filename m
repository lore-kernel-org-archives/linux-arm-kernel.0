From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 10 Dec 2012 17:31:29 +0000
Subject: [ARM] head.S change broke platform device registration?
In-Reply-To: <CAHod+GcXC=SY-=KZecwtbbH6VVSrdXX7jHGPX98rKxdAQrfdMw@mail.gmail.com>
References: <50B88A59.6070207@arm.com>
 <CAHod+GeZQx6-pUHPocbyMJCLawMUhrZuZf=mrgWax=L7eNJGhg@mail.gmail.com>
 <20121130143435.GP19440@n2100.arm.linux.org.uk>
 <CAHod+GdXfZb1OHapJBYpCD74svYyaGaiZpqHLPtjHbWGa-3eLA@mail.gmail.com>
 <20121204221851.GJ14363@n2100.arm.linux.org.uk>
 <CAHod+Gd6NJsuJVRos52e9+NcweqcSu=HArT_qoV0ygb_Xbfaiw@mail.gmail.com>
 <20121205235836.GR14363@n2100.arm.linux.org.uk>
 <20121207122809.GT14363@n2100.arm.linux.org.uk>
 <20121207134929.GA1969@linaro.org>
 <CAHod+GcXC=SY-=KZecwtbbH6VVSrdXX7jHGPX98rKxdAQrfdMw@mail.gmail.com>
Message-ID: <20121210173129.GB1953@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 10, 2012 at 06:23:44PM +0100, Marko Kati? wrote:
> > I've posted a separate patch which ought to accomplish the appropriate
> > change to safe_svc_maskall
> > ([PATCH] ARM: head: Remove boot-time HYP mode check for v5 and below)
> >
> > I've done a compile-disassemble sanity-check for v5 and v7 to make sure
> > that the results are sane, but I can't check whether it fixed the
> > problem for the affected hardware.
> >
> > Marko, can you give it a try?
> >
> > Cheers
> > ---Dave
> >
> 
> Yes, your patch fixes the problem. With this patch the kernel boots with the
> correct machine ID.

OK, that gives us confidence that this patch is useful.  I'll send it to
Russell's patch system so that he can decide about merging it.

If you can get any more detail about what exactly is going on here, that
would still be useful though.  I still suspect that this patch should
not be needed... but I'm happy to be proved wrong if the real cause is
found.  

Cheers
---Dave
