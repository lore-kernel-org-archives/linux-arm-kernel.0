From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 8 Oct 2018 14:51:18 +0200
Subject: [GIT PULL v2] for-next updates for soc/fsl drivers for v4.20 take
 2
In-Reply-To: <20181005193040.28598-1-leoyang.li@nxp.com>
References: <20181005193040.28598-1-leoyang.li@nxp.com>
Message-ID: <CAK8P3a2gtZUif_hPkd7ob=mWYTeh8Vgf-Y9nMwpi2YtHoBF2Bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 5, 2018 at 9:30 PM Li Yang <leoyang.li@nxp.com> wrote:
>
> ----------------------------------------------------------------
> NXP/FSL SoC drivers updates for v4.20 take 2
>
> - Update qbman driver to better work with CPU hotplug
> - Add Kconfig dependency of 64-bit DMA addressing for qbman driver
> - Use last reponse to determine valid bit for qbman driver
> - Defer bman_portals probe if bman is not probed
> - Add interrupt coalescing APIs to qbman driver

Pulled into next/drivers.

I was a little surprised to see these commits in your branch:

      ARM: dts: BCM63xx: Fix incorrect interrupt specifiers
      MAINTAINERS: update the Annapurna Labs maintainer email
      ARM: dts: sun8i: drop A64 HDMI PHY fallback compatible from R40 DT
      ARM: dts: at91: sama5d2_ptc_ek: fix nand pinctrl

These are from our earlier 'fixes' branch and they were also part
of your fixes branch that I already pulled, which you had based on
top of the other fixes.

In the future, please don't do this again. Instead, base each branch
on top of a plain -rc unless you have a specific reason to require
something else (like in this case, where you require the fixes to
build on top of).

This time we were lucky because the 'fixes' branch you built on
was also done on top of -rc1, so at least it did not contain any
commits from upstream that were not already part of our
next/drivers.

       Arnd
