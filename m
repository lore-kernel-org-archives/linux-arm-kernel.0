From: horms@verge.net.au (Simon Horman)
Date: Wed, 20 Apr 2016 08:48:55 +1000
Subject: [GIT PULL] Renesas ARM Based SoC Drivers Updates for v4.7
In-Reply-To: <CAMuHMdWtZg2A62vr9hDua+wvMnqTQVPeTQO7a=GZGoBzusz5Tg@mail.gmail.com>
References: <cover.1459732456.git.horms+renesas@verge.net.au>
 <20160413194354.GQ19945@localhost>
 <CAMuHMdUbNcbLdQYG037MiDRAe1dr7ohRK625vb16oM8W19WEFw@mail.gmail.com>
 <20160413202328.GS19945@localhost>
 <CAMuHMdXniFngia63Um6LN_5MKrFtJGQPeFFe7=e7Dj6A_X6PTw@mail.gmail.com>
 <20160415003346.GA31938@verge.net.au>
 <CAMuHMdWpdzMcCDcBo3jrRbuS9LzZ71A0GbVUR=YE_e4F_9+6hA@mail.gmail.com>
 <20160418035506.GB3578@verge.net.au>
 <CAMuHMdWtZg2A62vr9hDua+wvMnqTQVPeTQO7a=GZGoBzusz5Tg@mail.gmail.com>
Message-ID: <20160419224852.GA9826@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2016 at 09:25:20AM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Mon, Apr 18, 2016 at 5:55 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Fri, Apr 15, 2016 at 08:35:48AM +0200, Geert Uytterhoeven wrote:
> >> On Fri, Apr 15, 2016 at 2:33 AM, Simon Horman <horms@verge.net.au> wrote:
> >> > On Thu, Apr 14, 2016 at 10:19:04AM +0200, Geert Uytterhoeven wrote:
> >> >> On Wed, Apr 13, 2016 at 10:23 PM, Olof Johansson <olof@lixom.net> wrote:
> >> >> > On Wed, Apr 13, 2016 at 09:57:39PM +0200, Geert Uytterhoeven wrote:
> >> >> >> On Wed, Apr 13, 2016 at 9:43 PM, Olof Johansson <olof@lixom.net> wrote:
> >> >> >> > On Mon, Apr 04, 2016 at 10:22:56AM +0900, Simon Horman wrote:
> >> >> >> >> Geert Uytterhoeven (2):
> >> >> >> >>       ARM: shmobile: timer: Fix preset_lpj leading to too short delays
> >> >> >> >>       ARM: shmobile: timer: Drop support for Cortex A8
> >>
> >> >> Simon: I'm a bit surprised to see that "ARM: shmobile: timer: Fix preset_lpj
> >> >> leading to too short delays" got postponed to v4.7, while commit 406663ed61c8
> >> >> ("ARM: shmobile: defconfig: Do not enable CONFIG_CPU_BPREDICT_DISABLE") is
> >> >> already in v4.6-rc1.  The latter makes bad behavior due to too short delays
> >> >> more likely to happen.
> >> >>
> >> >> Sorry for not noticing before.
> >> >
> >> > Likewise, sorry for the mix-up.
> >> >
> >> > I can think of two ways to resolve this, likely there are others:
> >> > 1. Submit "ARM: shmobile: timer: Fix preset_lpj leading to too short delays"
> >> >    or conversely
> >> > 2. Submit a reversion of 406663ed61c8 ("ARM: shmobile: defconfig: Do not
> >> >    enable CONFIG_CPU_BPREDICT_DISABLE") as a fix for v4.6.
> >> >
> >> > Or perhaps it is a problem that can just be ironed out in v4.7.
> >> > Let me know what you think.
> >>
> >> I prefer option 1, i.e. fixing the bug instead of papering over it in
> >> the defconfig.
> >> Users may not use the defconfig, and have CONFIG_CPU_BPREDICT_DISABLE
> >> enabled anyway.
> >
> > Thanks, that reasoning sounds fine to me.
> >
> > I plan to re-queue "ARM: shmobile: timer: Fix preset_lpj leading to too
> > short delays" in fixes-for-v4.6 and I plan to push that in a revised
> > renesas-next tag later today. I would appreciate you double checking that
> > all is in order.
> 
> Thanks, that commit looks fine!

Great, thanks for checking.
