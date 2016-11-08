From: pankaj.dubey@samsung.com (pankaj.dubey)
Date: Tue, 08 Nov 2016 10:00:13 +0530
Subject: [PATCH v2 0/2] Remove static mapping of SCU from mach-exynos
In-Reply-To: <1478574864-24683-1-git-send-email-pankaj.dubey@samsung.com>
References: <CGME20161108031123epcas1p2d5f60a1903a6005a5cf7eb7f6b392119@epcas1p2.samsung.com>
 <1478574864-24683-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <582154D5.7020501@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tuesday 08 November 2016 08:44 AM, Pankaj Dubey wrote:
> This patch series is part of patch series [1], which adds support of SCU
> device node for Cortex-A9 based Exynos4 SoC. First two patches of the same
> has been accepted and hence not included them in v2.
> 
> This patch series does some cleanup for Exynos4 SoC based boards.
> We are currently statically mapping SCU SFRs in mach-exynos/exynos.c
> which can be avoided if map this from device node of SCU. 
> 
> This patch introduces exynos_scu_enable in firmware.c file,
> which will be called from exynos_resume, which in turn called by pm.c and
> suspend.c as firmware_ops.
> 

Please ignore this patchset as just noticed that firmware_ops needs not
be present for all boards, in that case exynos_resume ops won't be
defined in some of Exynos4 based boards and scu_enable won't be called.
I will think about some other approach and submit again.

Sorry for noise.

Thanks,
Pankaj Dubey
