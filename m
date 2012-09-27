From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 27 Sep 2012 10:04:53 +0900
Subject: [GIT PULL 4/4] Samsung DT for v3.7
In-Reply-To: <505C22CD.9030401@samsung.com>
References: <505C089C.4050801@samsung.com> <505C22CD.9030401@samsung.com>
Message-ID: <146201cd9c4c$1a219b30$4e64d190$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim wrote:
> 
> On 09/21/12 15:26, Kukjin Kim wrote:
> > Hi Arnd, Olof
> >
> > This is for updating Samsung DT for v3.7.
> >
> > But now this makes many conflicts with pinctrl dt because of moving file
> > so I'm sorting them out to avoid useless conflicts.
> >
> > I'll re-send this soon again.
> > This is jut for your information.
> >
> I created following branch which is merged on top of Samsung pinctrl and
> board branches already are pulled into arm-soc.
> 
> This includes moving common exynos4 dt for supporting other exynos4xxxx
> SoCs easily and adding exynos43210-trats board support and some updates.
> 
> Please pull from:
> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> next/dt-samsung-new
> 
> If any problems, please kindly let me know.
> 
Hi Arnd and Olof,

Maybe, you missed this one?

Note, this will make conflicts with Rob's change, move all dtb targets.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> >
> > The following changes since commit
> > 5698bd757d55b1bb87edd1a9744ab09c142abfc2:
> >
> > Linux 3.6-rc6 (2012-09-16 14:58:51 -0700)
> >
> > are available in the git repository at:
> > git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> > next/dt-samsung
> >
> > Kukjin Kim (1):
> > ARM: dts: use uart2 for console on smdkv310 and smdk5250
> >
> > Tomasz Figa (6):
> > ARM: dts: Move parts common to EXYNOS4 from exynos4210.dtsi to
> exynos4.dtsi
> > ARM: EXYNOS: Use exynos4 prefix instead of exynos4210 on exynos4-dt
> > ARM: dts: Assume status of all optional nodes as disabled for exynos4
> > ARM: dts: Specify address and size cells for i2c controllers for EXYNOS4
> > ARM: EXYNOS: Add OF compatibility lookups for EXYNOS4 i2c adapters
> > ARM: dts: Add basic dts file for Samsung Trats board
> >
> > Tushar Behera (1):
> > ARM: dts: Enable on-board keys as wakeup source for exynos4210-origen
> >
> > arch/arm/boot/dts/exynos4.dtsi | 248 +++++++++++++++++++++++++++++
> > arch/arm/boot/dts/exynos4210-origen.dts | 63 +-------
> > arch/arm/boot/dts/exynos4210-smdkv310.dts | 54 +------
> > arch/arm/boot/dts/exynos4210-trats.dts | 237 +++++++++++++++++++++++++++
> > arch/arm/boot/dts/exynos4210.dtsi | 181 +---------------------
> > arch/arm/boot/dts/exynos5250-smdk5250.dts | 2 +-
> > arch/arm/mach-exynos/Makefile.boot | 2 +-
> > arch/arm/mach-exynos/mach-exynos4-dt.c | 32 +++-
> > 8 files changed, 523 insertions(+), 296 deletions(-)
> > create mode 100644 arch/arm/boot/dts/exynos4.dtsi
> > create mode 100644 arch/arm/boot/dts/exynos4210-trats.dts
