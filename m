From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 9 Feb 2012 08:40:40 +0100
Subject: [GIT PULL] cs89x0 platform support
In-Reply-To: <CAOesGMiRTZZ9Gn9boEwyHbmG3H=jSqEHB7CDqf8Vr05LXTcx+w@mail.gmail.com>
References: <20120201134415.GU1990@pengutronix.de>
 <20120201150909.GB2203@S2101-09.ap.freescale.net>
 <20120201155404.GW1990@pengutronix.de>
 <CAOesGMiRTZZ9Gn9boEwyHbmG3H=jSqEHB7CDqf8Vr05LXTcx+w@mail.gmail.com>
Message-ID: <20120209074040.GS3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2012 at 04:57:39PM -0800, Olof Johansson wrote:
> On Wed, Feb 1, 2012 at 7:54 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > On Wed, Feb 01, 2012 at 11:09:13PM +0800, Shawn Guo wrote:
> >> On Wed, Feb 01, 2012 at 02:44:15PM +0100, Sascha Hauer wrote:
> >> > Hi Olof,
> >> >
> >> > Please pull the following for next. It contains cs89x0 platform
> >> > support. David has acked the base patch and is fine with this
> >> > patch going via the Arm tree.
> >> >
> >> > Sascha
> >> >
> >> > The following changes since commit dcd6c92267155e70a94b3927bce681ce74b80d1f:
> >> >
> >> > ? Linux 3.3-rc1 (2012-01-19 15:04:48 -0800)
> >> >
> >> > are available in the git repository at:
> >> > ? git://git.pengutronix.de/git/imx/linux-2.6.git features/cs89x0
> >> >
> >> > Jaccon Bastiaansen (4):
> >> > ? ? ? CS89x0 : add platform driver support
> >> > ? ? ? CS89x0 : add CS89x0 platform device to the iMX21ADS board
> >> > ? ? ? CS89x0 : remove QQ2440 board support from the CS89x0 driver
> >> > ? ? ? CS89x0 : add CS89x0 platform device to the iMX31ADS board
> >> >
> >> > ?arch/arm/configs/imx_v4_v5_defconfig ? ? ? ? ? | ? ?2 +
> >> > ?arch/arm/configs/mx3_defconfig ? ? ? ? ? ? ? ? | ? ?2 +
> >>
> >> The mx3_defconfig has been deleted from mainline. ?We may need to
> >> rebase the series to 3.3-rc2. ?Otherwise, we will eventually have
> >> conflict?
> >
> > Oops, yes. Just did that.
> >
> > Sascha
> >
> > The following changes since commit 62aa2b537c6f5957afd98e29f96897419ed5ebab:
> >
> > ?Linux 3.3-rc2 (2012-01-31 13:31:54 -0800)
> >
> > are available in the git repository at:
> > ?git://git.pengutronix.de/git/imx/linux-2.6.git features/cs89x0
> 
> Hi,
> 
> Arnd had some outstanding comments on the ethernet driver, so I will
> hold off pulling until that is resolved.

I think what Arnd made is some suggestions to further clean up the
driver, I don't think that the current patches should depend on doing
more work. This series is a nice cleanup and a solution for a five year
old problem. For the first time we can enable the cs89x0 driver in the
defconfig and thus make ethernet work on some boards.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
