From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 7 Oct 2016 18:48:40 +0300
Subject: [PATCH 1/3] mtd: s3c2410: make ecc mode configurable via
 platform data
In-Reply-To: <1475711217-974-2-git-send-email-sergio.prado@e-labworks.com>
References: <1475711217-974-1-git-send-email-sergio.prado@e-labworks.com>
 <1475711217-974-2-git-send-email-sergio.prado@e-labworks.com>
Message-ID: <20161007154840.GA4222@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 05, 2016 at 08:46:55PM -0300, Sergio Prado wrote:
> Removing CONFIG_MTD_NAND_S3C2410_HWECC option and adding a ecc_mode
> field in the drivers's platform data structure so it can be selectable
> via platform data.
> 
> Also setting this field to NAND_ECC_SOFT in all boards using this
> driver since none of them had CONFIG_MTD_NAND_S3C2410_HWECC enabled.
> 
> Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
> ---
>  arch/arm/mach-s3c24xx/common-smdk.c            |   1 +
>  arch/arm/mach-s3c24xx/mach-anubis.c            |   1 +
>  arch/arm/mach-s3c24xx/mach-at2440evb.c         |   1 +
>  arch/arm/mach-s3c24xx/mach-bast.c              |   1 +
>  arch/arm/mach-s3c24xx/mach-gta02.c             |   1 +
>  arch/arm/mach-s3c24xx/mach-jive.c              |   1 +
>  arch/arm/mach-s3c24xx/mach-mini2440.c          |   1 +
>  arch/arm/mach-s3c24xx/mach-osiris.c            |   1 +
>  arch/arm/mach-s3c24xx/mach-qt2410.c            |   1 +
>  arch/arm/mach-s3c24xx/mach-rx1950.c            |   1 +
>  arch/arm/mach-s3c24xx/mach-rx3715.c            |   1 +
>  arch/arm/mach-s3c24xx/mach-vstms.c             |   1 +
>  arch/arm/mach-s3c64xx/mach-hmt.c               |   1 +
>  arch/arm/mach-s3c64xx/mach-mini6410.c          |   1 +
>  arch/arm/mach-s3c64xx/mach-real6410.c          |   1 +
>  drivers/mtd/nand/Kconfig                       |   9 --
>  drivers/mtd/nand/s3c2410.c                     | 119 +++++++++++++------------
>  include/linux/platform_data/mtd-nand-s3c2410.h |   6 +-
>  18 files changed, 79 insertions(+), 70 deletions(-)
>


Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
