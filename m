From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 24 Sep 2012 20:04:00 -0400
Subject: [PATCH] ARM: Orion5x: Fix too small coherent pool.
In-Reply-To: <CAOesGMgMEVZtLPct9OFUq1JDjauOH2gyr4j6o1esEVrwtsGcPQ@mail.gmail.com>
References: <1348466073-22726-1-git-send-email-andrew@lunn.ch>
 <20120924163716.GR5469@titan.lakedaemon.net>
 <20120924173739.GG14266@lunn.ch> <5060E9BA.7010806@gmail.com>
 <20120924234518.GU5469@titan.lakedaemon.net>
 <CAOesGMgMEVZtLPct9OFUq1JDjauOH2gyr4j6o1esEVrwtsGcPQ@mail.gmail.com>
Message-ID: <20120925000400.GW5469@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2012 at 04:47:35PM -0700, Olof Johansson wrote:
> On Mon, Sep 24, 2012 at 4:45 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> > On Tue, Sep 25, 2012 at 01:16:10AM +0200, Sebastian Hesselbarth wrote:
> >> On 09/24/2012 07:37 PM, Andrew Lunn wrote:
> >> >On Mon, Sep 24, 2012 at 12:37:16PM -0400, Jason Cooper wrote:
> >> >>On Mon, Sep 24, 2012 at 07:54:33AM +0200, Andrew Lunn wrote:
> >> >>>Some Orion5x devices allocate their coherent buffers from atomic
> >> >>>context. Increase size of atomic coherent pool to make sure such the
> >> >>>allocations won't fail during boot.
> >> >>>
> >> >>>Signed-off-by: Andrew Lunn<andrew@lunn.ch>
> >> >>
> >> >>Acked-by: Jason Cooper<jason@lakedaemon.net>
> >> >>
> >> >>btw - we should take this to it's logical conclusion and have Sebastian
> >> >>check Dove.  Sebastian?
> >> >
> >> >I did think about that. It probably hits if you have two sata
> >> >devices. However, all current Dove machines have just one.
> >>
> >> I did boot arm-soc/for-next on Cubox and looks like 256k pool for atomic
> >> coherent allocations is enough. I booted with sata, sdhci0, eth0, i2c0,
> >> spi0, and both pcie ports forced on without any pcie devices attached.
> >
> > Thanks for testing, Sebastian.
> >
> > Andrew, I'll put this into a late/fixes branch for arm-soc and send it
> > on up.
> 
> I can just apply it in fixes here with your ack and send it up for 3.6 tonight.

Oops, already sent the pull request.  Which ever you prefer is fine with
me.  I just wanted another round of am, build, push, request-pull. ;-)

thx,

Jason.
