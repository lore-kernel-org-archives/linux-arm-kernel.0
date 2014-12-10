From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Dec 2014 11:02:18 +0100
Subject: [GIT PULL 6/9] ARM: SoC DT updates for 3.19
In-Reply-To: <CA+55aFwkkP9wFdJUHMsnrd=eDYNsGKm7ujyktEWh+GMzQinzxw@mail.gmail.com>
References: <4491193.a6KEQb1tZH@wuerfel> <14657639.RrnLVWDtO6@wuerfel>
 <CA+55aFwkkP9wFdJUHMsnrd=eDYNsGKm7ujyktEWh+GMzQinzxw@mail.gmail.com>
Message-ID: <7707467.Hfg5h2sSMM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 December 2014 15:45:58 Linus Torvalds wrote:
> On Tue, Dec 9, 2014 at 1:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > ARM: SoC DT updates for 3.19
> >
> >  267 files changed, 18516 insertions(+), 2823 deletions(-)
> 
> Hmm. This is not what I get. I get
> 
> + 297 files changed, 20490 insertions(+), 3332 deletions(-)
> 
> largely due to
> 
> + arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi          |  41 +-
> + arch/arm/boot/dts/omap-zoom-common.dtsi            |  62 +-
> + arch/arm/boot/dts/omap2420-n8x0-common.dtsi        |   4 +-
> + arch/arm/boot/dts/omap2420.dtsi                    |   1 +
> + arch/arm/boot/dts/omap2430-sdp.dts                 |  28 +-
> + arch/arm/boot/dts/omap2430.dtsi                    |   1 +
> + arch/arm/boot/dts/omap3-cm-t3517.dts               |  11 +
> + arch/arm/boot/dts/omap3-cm-t3530.dts               |  11 +
> + arch/arm/boot/dts/omap3-cm-t3730.dts               |  24 +
> + arch/arm/boot/dts/omap3-cm-t3x.dtsi                | 151 ++++
> + arch/arm/boot/dts/omap3-devkit8000.dts             |   4 +-
> + arch/arm/boot/dts/omap3-evm-37xx.dts               |   5 +-
> + arch/arm/boot/dts/omap3-gta04.dtsi                 |  86 +-
> + arch/arm/boot/dts/omap3-igep.dtsi                  | 103 ++-
> + arch/arm/boot/dts/omap3-igep0020-common.dtsi       | 246 ++++++
> + arch/arm/boot/dts/omap3-igep0020-rev-f.dts         |  45 +
> + arch/arm/boot/dts/omap3-igep0020.dts               | 285 +------
> + arch/arm/boot/dts/omap3-igep0030-common.dtsi       |  60 ++
> + arch/arm/boot/dts/omap3-igep0030-rev-g.dts         |  67 ++
> + arch/arm/boot/dts/omap3-igep0030.dts               | 123 +--
> + arch/arm/boot/dts/omap3-ldp.dts                    |   3 +-
> + arch/arm/boot/dts/omap3-lilly-a83x.dtsi            |   2 +-
> + arch/arm/boot/dts/omap3-n900.dts                   |  51 +-
> + arch/arm/boot/dts/omap3-n950-n9.dtsi               |   4 +-
> + arch/arm/boot/dts/omap3-sb-t35.dtsi                | 126 ++-
> + arch/arm/boot/dts/omap3-sbc-t3517.dts              |  15 +
> + arch/arm/boot/dts/omap3-sbc-t3530.dts              |  15 +
> + arch/arm/boot/dts/omap3-sbc-t3730.dts              |  15 +
> + arch/arm/boot/dts/omap3-tao3530.dtsi               |   2 +-
> + arch/arm/boot/dts/omap3.dtsi                       |   1 +
> + arch/arm/boot/dts/omap3430-sdp.dts                 |   8 +-
> + arch/arm/boot/dts/omap4.dtsi                       |   1 +
> + arch/arm/boot/dts/omap5.dtsi                       |   1 +
> 
> much of which seems to have come in through that
> 
>       Merge tag 'omap-for-v3.19/dt-part1' of
> git://git.kernel.org/.../tmlind/linux-omap into next/dt
> 
> but the diffstat isn't there, nor are the actual commits are mentioned
> in the shortlog.
> 
> Hmm?
> 
> I've applied 1-5, but I'm going to stop here waiting for confirmation
> of what's going on..
> 

Ah, sorry about that. I noticed the difference because these happened to
be in both the drivers and the dt branch, and I changed the order of
the branches to have dt come first so you'd see these as part of dt,
not drivers.

I fixed up the drivers pull request to regenerate the diffstat the
way it was supposed to look like, but I couldn't easily redo the
dt diffstat without merging all branches one more time into a test
branch. I should probably do that next time.

	Arnd
