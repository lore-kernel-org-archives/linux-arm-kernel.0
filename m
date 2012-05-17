From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 17 May 2012 09:18:28 -0700
Subject: [GIT PULL] Samsung usb stuff for v3.5
In-Reply-To: <0b1401cd33f8$b5aca930$2105fb90$%kim@samsung.com>
References: <0b1401cd33f8$b5aca930$2105fb90$%kim@samsung.com>
Message-ID: <20120517161828.GA6759@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2012 at 03:45:55PM +0900, Kukjin Kim wrote:
> Hi Greg and Felipe,
> 
> Please pull Samsung 's3c-hsotg' UDC support for EXYNOS4210 and S5PV210 from:
>   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> v3.5-for-usb
> 
> Since it has a dependency on 'usb: hsotg: samsung ...' patches which have
> been already in usb tree now, so would be better if you could pull this
> series in your tree. Or this can be sent to upstream in the end of upcoming
> merge window after pulling usb tree. But I think usb tree is better in this
> case.
> 
> If any problems, please kindly let me know.
> 
> Thanks.
> 
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
> 
> The following changes since commit 36be50515fe2aef61533b516fa2576a2c7fe7664:
> 
>   Linux 3.4-rc7 (2012-05-12 18:37:47 -0700)
> 
> are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> v3.5-for-usb
> 
> Joonyoung Shim (1):
>       ARM: EXYNOS: Add s3c-hsotg device support for NURI board
> 
> Lukasz Majewski (3):
>       ARM: EXYNOS: Add usb otg phy control for EXYNOS4210
>       ARM: EXYNOS: Add s3c-hsotg device support for GONI board
>       ARM: EXYNOS: Add s3c-hsotg device support for Universal C210 board
> 
>  arch/arm/mach-exynos/Kconfig                 |    3 +
>  arch/arm/mach-exynos/include/mach/irqs.h     |    1 +
>  arch/arm/mach-exynos/include/mach/map.h      |    4 +
>  arch/arm/mach-exynos/include/mach/regs-pmu.h |    3 +
>  arch/arm/mach-exynos/mach-nuri.c             |    9 ++-
>  arch/arm/mach-exynos/mach-universal_c210.c   |   10 +++
>  arch/arm/mach-exynos/setup-usb-phy.c         |  100
> ++++++++++++++++++-------
>  arch/arm/mach-s5pv210/Kconfig                |    1 +
>  arch/arm/mach-s5pv210/mach-goni.c            |    5 ++
>  9 files changed, 107 insertions(+), 29 deletions(-)

Hm, this branch is against 3.4-rc7, while my tree is currently at
3.4-rc6, so it pulls in Linus's recent merges.

Which might be ok, let me see how it goes...

greg k-h
