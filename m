From: girishks2000@gmail.com (Girish KS)
Date: Mon, 25 Mar 2013 08:57:56 +0530
Subject: [PATCH V3 0/5] Add polling support for 64xx spi controller
In-Reply-To: <1363157014-9615-1-git-send-email-ks.giri@samsung.com>
References: <1363157014-9615-1-git-send-email-ks.giri@samsung.com>
Message-ID: <CAKrE-Kfgw+ofmkN+aMVNeeLm=+4owJ0U=qAmj2o0oARm6BSCQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello grant,

any comments on this patch series?


On Wed, Mar 13, 2013 at 12:13 PM, Girish K S <girishks2000@gmail.com> wrote:
> [PATCH 1/5]: fixes the error handling in the interrupt handler
> [PATCH 2/5]: The existing driver support partial polling mode.
>              This patch modifies the current driver to support
>              only polling mode.
> [PATCH 3/5]: provision to support SoC's with dedicated i/o pins
> [PATCH 4/5]: provision to support dedicated cs pin
> [PATCH 5/5]: support exynos5440 SoC in polling mode
>
> Tested this patch on exynos5250 in dma mode, and exynos5440 in
> polling mode.
>
> changes in v3:
>             Rebase it to the linus's master branch. After rebase
> there was a logical code change due to the merge of generic dma
> patch. resolved the merge conflicts and tested for the functionality
>
> Girish K S (5):
>   spi: s3c64xx: modified error interrupt handling and init
>   spi: s3c64xx: added support for polling mode
>   spi: s3c64xx: Added provision for non-gpio i/o's
>   spi: s3c64xx: Added provision for dedicated cs pin
>   spi: s3c64xx: Added support for exynos5440 spi
>
>  drivers/spi/spi-s3c64xx.c                 | 204 +++++++++++++++++++++---------
>  include/linux/platform_data/spi-s3c64xx.h |   3 +
>  2 files changed, 148 insertions(+), 59 deletions(-)
>
> --
> 1.8.0
>
