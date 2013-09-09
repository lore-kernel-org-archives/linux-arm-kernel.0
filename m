From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 9 Sep 2013 16:37:34 +0900
Subject: [PATCH 01/04] ARM: shmobile: Initial r8a7791 SoC support
In-Reply-To: <CACRpkdacYC-CKbr-=pzN=nLWgBqk4CCQS3rG8LDASKjg3uBP=Q@mail.gmail.com>
References: <20130904034525.12546.24775.sendpatchset@w520>
 <20130904034557.12546.97503.sendpatchset@w520>
 <CACRpkdb7QkqCmTMua1yJNJxSAWff=0f6a2SWkf6K9SqbW0BOVg@mail.gmail.com>
 <20130909001611.GE21921@verge.net.au>
 <CACRpkdacYC-CKbr-=pzN=nLWgBqk4CCQS3rG8LDASKjg3uBP=Q@mail.gmail.com>
Message-ID: <CANqRtoQirDKYS-vGH-pbrXH52WWDe8q77XzdLBGApbf5XRkH=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Mon, Sep 9, 2013 at 3:55 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Sep 9, 2013 at 2:16 AM, Simon Horman <horms@verge.net.au> wrote:
>
>> So on those two counts my preference would be for any enhancements
>> to be done as incremental patches on top of this series.
>
> Again: do such enhancements even exist?

There are several incremental patches available for r8a7791, but since
this is a new and rare platform it won't be the first SoC we convert
to common clocks. So CCF development will happen on r8a7791, but it
won't be the first platform.

To be able to start using common clocks we first need to break out the
basic building blocks and then tie them in on one SoC at a time. These
basic building blocks of course need to use already-existing CCF bits
for gating, dividers and plls. We will also need some special handling
like for instance polling of registers to wait for rate change.

So the issue in my opinion is not so much the SoC specific bits.
Instead it's the shared CCF bits that need work. The real question is
probably if new SoC support needs to block on framework support. I'm
all about incremental changes. If there is something special that
needs extra focus then of course we will work on that.

Cheers,

/ magnus
