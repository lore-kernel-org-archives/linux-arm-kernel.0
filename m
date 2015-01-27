From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 27 Jan 2015 21:47:42 +0200
Subject: [PATCH 00/14 v2] ARM: shmobile: Remove sh7372/Mackerel and ZBOOT
 MMC/SDHI support V2
In-Reply-To: <20150127011707.GD29710@verge.net.au>
References: <20150126061747.6848.9708.sendpatchset@little-apple>
 <20150127011707.GD29710@verge.net.au>
Message-ID: <1521770.CESgZ9DKGZ@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Tuesday 27 January 2015 10:17:09 Simon Horman wrote:
> On Mon, Jan 26, 2015 at 03:17:47PM +0900, Magnus Damm wrote:
> > ARM: shmobile: Remove sh7372/Mackerel and ZBOOT MMC/SDHI support V2
> > 
> > [PATCH 01/14 v2] ARM: shmobile: mackerel: Remove ZBOOT code
> > [PATCH 02/14 v2] ARM: shmobile: mackerel: Remove Legacy C board code
> > [PATCH 03/14 v2] ARM: shmobile: mackerel dts: Remove Legacy DTS file
> > [PATCH 04/14 v2] ARM: shmobile: mackerel: Remove DT binding documentation
> > [PATCH 05/14 v2] ARM: shmobile: mackerel: Remove mach-type entry
> > [PATCH 06/14 v2] ARM: shmobile: mackerel: Remove defconfig
> > [PATCH 07/14 v2] ARM: shmobile: mackerel: Remove from MAINTAINERS
> > [PATCH 08/14 v2] ARM: shmobile: sh7372: Remove ZBOOT MMC/SDHI support
> > [PATCH 09/14 v2] ARM: shmobile: sh7372: Remove Legacy C SoC code
> > [PATCH 10/14 v2] ARM: shmobile: sh7372: Remove DT binding documentation
> > [PATCH 11/14 v2] ARM: shmobile: sh7372 dtsi: Remove Legacy DTSI file
> > [PATCH 12/14 v2] Documentation: Remove ZBOOT MMC/SDHI utility and docs
> > [PATCH 13/14 v2] pinctrl: sh-pfc: sh7372: Remove PFC support
> > [PATCH 14/14 v2] pinctrl: sh-pfc: sh7372: Remove DT binding documentation
> > 
> > Here is my latest attempt (V2) of legacy board and SoC support removal
> > for Mackerel and sh7372. Both the ARM mach-shmobile code base and the
> > PINCTRL subsystem is affected.
> > 
> > Also get rid of the remaining ZBOOT MMC/SDHI code, documentation and
> > utility that has no user once sh7372 is gone.
> > 
> > The Cortex-A8 based sh7372 SoC is rather old and never went into mass
> > production anyway, so these patches that remove SoC and board support
> > will only affect a few selected developers.
> > 
> > I wish we had some way to make use of the ZBOOT MMC/SDHI code, but
> > without any board or SoC code it makes little sense to keep it.
> > 
> > Thanks to Laurent and Geert for review!
> 
> Sad to see all our hard work being deleted. But at the same
> time its nice to be able to reduce our footprint by 8681 lines!
> 
> I have queued up the first 12 patches of this series, that is the
> non-pfc patches. They are queued up in a new sh7372-soc-removal-for-v3.21
> branch which I intend to push as part of renesas-devel-20150127-v3.19-rc6 a
> little later today.
> 
> With regards to the PFC patches, the last two patches in the series, I have
> spoken with Laurent about this and my understanding is that his feeling
> is that they could be merged independently by the pinctl maintainer, Linus
> Walleij.
> 
> Laurent, if that is correct could see about working with Linus towards
> that goal? If not, please let me know and we can work out another plan.

The following changes since commit 4d1216ba80e8e6269e56dc043364b661ee0a7c23:

  Merge branch 'devel' into for-next (2015-01-27 09:57:36 +0100)

are available in the git repository at:

  git://linuxtv.org/pinchartl/fbdev.git pinmux/next/pfc

for you to fetch changes up to 1f35f33e117303ca450ce4be67a7fb6ec9cb90f8:

  pinctrl: sh-pfc: sh7372: Remove DT binding documentation (2015-01-27 
21:41:59 +0200)

----------------------------------------------------------------
Magnus Damm (2):
      pinctrl: sh-pfc: sh7372: Remove PFC support
      pinctrl: sh-pfc: sh7372: Remove DT binding documentation

 .../devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt |    8 +-
 drivers/pinctrl/sh-pfc/Kconfig                          |    5 -
 drivers/pinctrl/sh-pfc/Makefile                         |    1 -
 drivers/pinctrl/sh-pfc/core.c                           |    9 -
 drivers/pinctrl/sh-pfc/core.h                           |    1 -
 drivers/pinctrl/sh-pfc/pfc-sh7372.c                     | 2645 --------------
 6 files changed, 3 insertions(+), 2666 deletions(-)
 delete mode 100644 drivers/pinctrl/sh-pfc/pfc-sh7372.c

-- 
Regards,

Laurent Pinchart
