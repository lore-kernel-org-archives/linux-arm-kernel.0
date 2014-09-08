From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 8 Sep 2014 15:14:34 +0100
Subject: [PATCH 1/2] arm64: psci: respect MIGRATE_INFO_TYPE
In-Reply-To: <CAJ5Y-eb3jJSaR4VCPFe+A+PVbLAbyVGBAcb+_zsOQQ=Rhk9Q0g@mail.gmail.com>
References: <1409915540-20044-1-git-send-email-mark.rutland@arm.com>
 <1409915540-20044-2-git-send-email-mark.rutland@arm.com>
 <CAJ5Y-eZqWsLT1ERWsdzCQASgzCfFTgn6fCBCpc7ceMoU2ONkNA@mail.gmail.com>
 <20140905141345.GF20164@leverpostej>
 <CAJ5Y-eb3jJSaR4VCPFe+A+PVbLAbyVGBAcb+_zsOQQ=Rhk9Q0g@mail.gmail.com>
Message-ID: <20140908141434.GJ12081@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

> >> Guessing there is no way for us to know which CPU the UP TOS is
> >> running on and only deny hotplug on that CPU?
> >
> > In the comment above I mention we can use MIGRATE_INFO_UP_CPU for that.
> > I started down that route, but the plumbing for it ended up looking a
> > little crazy so I thought it was better for the moment to have a simple
> > solution that we can backport to stable.
> 
> Ah. I faintly recollect experiencing similar craziness when I was
> adding v0.2 support.

Yeah, it's lot of churny fun with many function prototypes changing
about. I wasn't too keen on rushing that, though I would like to get
around to it at some point.

> > No systems with a UP trusted OS (migrateable or not) have hit my radar
> > yet, and we're currently broken for them anyhow. So for the moment it
> > didn't seem worthwhile implementing support for those. We can add the
> > requisite MIGRATE_INFO_UP_CPU and MIGRATE calls in a later series.
> 
> Ok.
> 
> Acked-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>

Thanks.

Does that apply to both patches or just the arm64 one?

Mark.
