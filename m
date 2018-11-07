From: olof@lixom.net (Olof Johansson)
Date: Wed, 7 Nov 2018 09:28:11 -0800
Subject: [GIT PULL] ARM: SoC fixes
In-Reply-To: <CAHk-=whF7kBo49-BFTUc-by+HB_0qNw_=+d24TydO2mYwwsWMQ@mail.gmail.com>
References: <20181107171023.zoo6qox5eewy3pmk@localhost>
 <CAHk-=whF7kBo49-BFTUc-by+HB_0qNw_=+d24TydO2mYwwsWMQ@mail.gmail.com>
Message-ID: <CAOesGMg3uHJ7YB95skjcVK39kudAGGjKo6909d--LDZmqeE1HA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 7, 2018 at 9:17 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Nov 7, 2018 at 9:10 AM Olof Johansson <olof@lixom.net> wrote:
> >
> > ARM: SoC fixes
>
> Pulled.
>
> > I was a bit too trigger happy to enable PREEMPT on multi_v7_defconfig,
> > and it ended up regressing at least BeagleBone XM boards.
>
> Odd. Did it hit some "may_sleep()" test in a driver that is hidden by
> preempt being off? Otherwise I don't see how/why preempt should fail
> in a board-specific manner..

The board hangs early during boot and the usual way of collecting
early console doesn't seem to work when attempted (I haven't tried
personally).

It's one of the major non-SMP platforms covered by tests. I'd be
surprised if it turns out to be truly _board_ specific (and rather
specific to OMAP3), but we don't have enough data yet. Chances are it
either shuffles some timing around or indeed hits a may_sleep() test
somewhere.

(I just realized I might have missed to attribute Guillaume in the
revert patch. Sorry about that).


-Olof


-Olof
