From: leoyang.li@nxp.com (Leo Li)
Date: Mon, 8 Oct 2018 16:49:24 +0000
Subject: [GIT PULL v2] for-next updates for soc/fsl drivers for v4.20 take
 2
In-Reply-To: <CAK8P3a2gtZUif_hPkd7ob=mWYTeh8Vgf-Y9nMwpi2YtHoBF2Bg@mail.gmail.com>
References: <20181005193040.28598-1-leoyang.li@nxp.com>
 <CAK8P3a2gtZUif_hPkd7ob=mWYTeh8Vgf-Y9nMwpi2YtHoBF2Bg@mail.gmail.com>
Message-ID: <AMSPR04MB50382DC37553EDBF2C0F2C58FE60@AMSPR04MB503.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Arnd Bergmann <arnd@arndb.de>
> Sent: Monday, October 8, 2018 7:51 AM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: arm-soc <arm@kernel.org>; Linux ARM <linux-arm-
> kernel at lists.infradead.org>; Linux Kernel Mailing List <linux-
> kernel at vger.kernel.org>; Shawn Guo <shawnguo@kernel.org>
> Subject: Re: [GIT PULL v2] for-next updates for soc/fsl drivers for v4.20 take
> 2
> 
> On Fri, Oct 5, 2018 at 9:30 PM Li Yang <leoyang.li@nxp.com> wrote:
> >
> > ----------------------------------------------------------------
> > NXP/FSL SoC drivers updates for v4.20 take 2
> >
> > - Update qbman driver to better work with CPU hotplug
> > - Add Kconfig dependency of 64-bit DMA addressing for qbman driver
> > - Use last reponse to determine valid bit for qbman driver
> > - Defer bman_portals probe if bman is not probed
> > - Add interrupt coalescing APIs to qbman driver
> 
> Pulled into next/drivers.
> 
> I was a little surprised to see these commits in your branch:
> 
>       ARM: dts: BCM63xx: Fix incorrect interrupt specifiers
>       MAINTAINERS: update the Annapurna Labs maintainer email
>       ARM: dts: sun8i: drop A64 HDMI PHY fallback compatible from R40 DT
>       ARM: dts: at91: sama5d2_ptc_ek: fix nand pinctrl
> 
> These are from our earlier 'fixes' branch and they were also part of your
> fixes branch that I already pulled, which you had based on top of the other
> fixes.
> 
> In the future, please don't do this again. Instead, base each branch on top
> of a plain -rc unless you have a specific reason to require something else
> (like in this case, where you require the fixes to build on top of).

I rebased my second fix pull request to the arm-soc fix branch because some patches from my first fix pull request were cherry picked to the fix branch.  I did the rebase to avoid conflicts in merge.   But probably your for-next branch doesn't have all the fix patches yet, so these patches showed up.

> 
> This time we were lucky because the 'fixes' branch you built on was also
> done on top of -rc1, so at least it did not contain any commits from
> upstream that were not already part of our next/drivers.
> 
>        Arnd
