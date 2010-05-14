From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 14 May 2010 07:22:03 +0200
Subject: [PATCH v3] ARM: S5PC100: Pre-requisite clock patch for
	plat-s5pc1xx to plat-s5p move.
In-Reply-To: <1273797327-5342-1-git-send-email-kgene.kim@samsung.com>
References: <1273797327-5342-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <008501caf325$65716430$30542c90$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Friday, May 14, 2010 2:35 AM Kukjin Kim wrote:

> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> This is a pre-requisite clock patch for the plat-s5pc1xx to plat-s5p
> movement. The patches that perform the movement of the code from
> plat-s5pc1xx to plat-s5p (and mach-s5pc100) should also enable the
> build for the mach-s5pc100/clock.c code.
> 
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/mach-s5pc100/clock.c                   | 1362
> +++++++++++++++++++++++
>  arch/arm/mach-s5pc100/include/mach/regs-clock.h |   71 ++
>  arch/arm/plat-s5p/clock.c                       |    2 +-
>  arch/arm/plat-s5p/include/plat/pll.h            |   22 +
>  arch/arm/plat-s5p/include/plat/s5p-clock.h      |    2 +
>  5 files changed, 1459 insertions(+), 1 deletions(-)
>  create mode 100755 arch/arm/mach-s5pc100/clock.c
>  create mode 100644 arch/arm/mach-s5pc100/include/mach/regs-clock.h
> 
> diff --git a/arch/arm/mach-s5pc100/clock.c b/arch/arm/mach-s5pc100/clock.c
> new file mode 100755

Please use 0644 mode for new files, no need to set the 'execute' bit.

> ...

I also got the following compilation warnings:

arch/arm/mach-s5pc100/clock.c:47: warning: 'clk_mout_href' defined but not used
arch/arm/mach-s5pc100/clock.c:400: warning: 's5pc100_d2_0_ctrl' defined but not
used

Besides the above this patch works fine. I will post my redesigned s5pc100 patch
series in a few minutes.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
