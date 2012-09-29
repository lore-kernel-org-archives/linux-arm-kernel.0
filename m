From: olof@lixom.net (Olof Johansson)
Date: Sat, 29 Sep 2012 10:31:27 -0700
Subject: ARM SoC tree,
 Was: Re: [PATCH 05/12] ARM: ixp4xx: use __iomem for MMIO
In-Reply-To: <m3y5jskbir.fsf@intrepid.localdomain>
References: <1348868177-21205-1-git-send-email-arnd@arndb.de>
 <1348868177-21205-6-git-send-email-arnd@arndb.de>
 <m3lift6rru.fsf_-_@intrepid.localdomain>
 <201209291458.16112.arnd@arndb.de>
 <m3y5jskbir.fsf@intrepid.localdomain>
Message-ID: <CAOesGMh9PCjoiUZZZtPFBrsOfO+QhjW_bSdCOf0b_uXd_Jx2qA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 29, 2012 at 10:02 AM, Krzysztof Halasa <khc@pm.waw.pl> wrote:

> It would be different if my tree included e.g. core ARM changes - but it
> doesn't. What's the _real_ reason for asking me to push my changes
> indirectly?

The reason is that when all ARM platform maintainers pushed code
straight to Linus, no one was making sure that the code meets a
quality bar and each vendor only focused on just their own stuff.

As an end result, over the years lots of crap got pushed straight to
Linus, code that we have now spent about a year and a half doing
massive cleanups and restructurings of. No vendors really talked to
each other, all of them solved their own problems their own way
without figuring out how to work better together and build
infrastructure for their common requirements. Linus finally lost his
patience with the massive churn of duplicated reinvented code and
there was a huge blow up about it. See http://lwn.net/Articles/439326/
for background.

> Also, not that it's the most important, but how is it better for anyone
> to delay changes - which are completely orthogonal to arm-soc - for
> additional months? Doesn't "release early, release often" make sense
> anymore?

Nothing is delayed by going through arm-soc. We're closing down our
tree for new (large) pull requests around the same time where you
should no longer add them to your -next branch either (-rc6/-rc7 time
frame).

Small fixups, and of course bugfixes, are welcome closer to the merge
window but the major chances should all have landed by then.


-Olof
