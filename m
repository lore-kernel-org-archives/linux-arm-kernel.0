From: mturquette@baylibre.com (Michael Turquette)
Date: Mon, 22 Feb 2016 12:23:20 -0800
Subject: [PATCH 2/3] clk: mvebu: add AP806 core clock driver
In-Reply-To: <CAL_Jsq+iiUBcTdnqzFWLJ+5jPvq0rmWgBboab4xyj1dQyDQE+Q@mail.gmail.com>
References: <1455521698-7905-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1455521698-7905-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160222025357.GE15973@rob-hp-laptop>
 <20160222091423.4756a579@free-electrons.com> <20160222141617.GA14970@lunn.ch>
 <20160222183203.2278.60153@quark.deferred.io>
 <CAL_Jsq+iiUBcTdnqzFWLJ+5jPvq0rmWgBboab4xyj1dQyDQE+Q@mail.gmail.com>
Message-ID: <20160222202320.2278.62793@quark.deferred.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Rob Herring (2016-02-22 11:42:49)
> On Mon, Feb 22, 2016 at 12:32 PM, Michael Turquette
> <mturquette@baylibre.com> wrote:
> > Quoting Andrew Lunn (2016-02-22 06:16:17)
> >> > Such information will come later, and we can rework the drivers and DT
> >> > bindings accordingly. Those DT bindings cannot be stable, as the
> >> > platform is under heavy development and we'll probably discover some
> >> > issues down the road.
> >>
> >> Hi Thomas
> >>
> >> Maybe add a big fat warning that the bindings are unstable, and the DT
> >> blob must be kept in sync with the kernel?
> >
> > +1 and feel free to blame the lack of documentation.  No one can expect
> > bindings to be finalized when the chip topology is not fully understood.
> 
> I can understand not understanding the full clock tree. I have "full"
> documentation of a Marvell chip and don't understand the clock tree
> fully. But I can't believe you don't have some sense of how many
> clocks you have to deal with. 10? 100? 1000? What I see is 2 nodes of
> a single register each for clocks at roughly the same address. That
> tells me your binding is too fine grained. If you really don't know
> what is right, then err on the side of a single clock provider node
> and don't put the clock details in DT.

I like the "err on the side of caution" part. I'll add that to
clock-bindings.txt.

Regards,
Mike

> 
> Rob
