From: tony.kn@samsung.com (Tony K Nadackal)
Date: Mon, 05 Jan 2015 10:45:11 +0530
Subject: [PATCH v2 0/2] Adding support for Exynos7 Jpeg variant
In-Reply-To: <1418974680-5837-1-git-send-email-tony.kn@samsung.com>
References: <1418974680-5837-1-git-send-email-tony.kn@samsung.com>
Message-ID: <000301d028a6$9c290300$d47b0900$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gentle Reminder.

Thanks,
Tony

> -----Original Message-----
> From: Tony K Nadackal [mailto:tony.kn at samsung.com]
> Sent: Friday, December 19, 2014 1:08 PM
> To: linux-media at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> samsung-soc at vger.kernel.org; devicetree at vger.kernel.org
> Cc: mchehab at osg.samsung.com; j.anaszewski at samsung.com;
> kgene at kernel.org; k.debski at samsung.com; s.nawrocki at samsung.com;
> robh+dt at kernel.org; mark.rutland at arm.com; bhushan.r at samsung.com; Tony K
> Nadackal
> Subject: [PATCH v2 0/2] Adding support for Exynos7 Jpeg variant
> 
> This patch series adds support for Exynos7 JPEG variant, which is mostly same
as
> Exynos4 JPEG variants with few register configuration differences.
> At the same time it modifies #define based JPEG variant macros into enum.
> Patch 1/2 fixes possible bug in setting INT EN register, where
> EXYNOS4_INT_EN_REG was getting modified without reading before.
> 
> Patch set v1 and related discussion can be found here [1].
> 
> [1]: http://www.spinics.net/lists/linux-samsung-soc/msg40308.html
> 
> Changes since v1:
>  - Added new patch 1/2 which fixes issues in writing EXYNOS4_INT_EN_REG.
>  - Converted JPEG variant macros into enum as suggested by Jacek Anaszewski.
> 
> 
> Tony K Nadackal (2):
>   [media] s5p-jpeg: Fix modification sequence of interrupt enable
>     register
>   [media] s5p-jpeg: Adding Exynos7 Jpeg variant
> 
>  .../bindings/media/exynos-jpeg-codec.txt           |  2 +-
>  drivers/media/platform/s5p-jpeg/jpeg-core.c        | 61 ++++++++++++++++++---
> -
>  drivers/media/platform/s5p-jpeg/jpeg-core.h        | 10 ++--
>  drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.c  | 33 +++++++-----
> drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.h  |  8 +--
>  drivers/media/platform/s5p-jpeg/jpeg-regs.h        | 17 ++++--
>  6 files changed, 95 insertions(+), 36 deletions(-)
> 
> --
> 2.2.0
