From: kmpark@infradead.org (Kyungmin Park)
Date: Fri, 16 Jul 2010 22:41:29 +0900
Subject: [PATCH 3/3] i2c/busses: Select I2C bus support for S5PV210 and
	S5P6440.
In-Reply-To: <1279285999-27555-4-git-send-email-kgene.kim@samsung.com>
References: <1279285999-27555-1-git-send-email-kgene.kim@samsung.com>
	<1279285999-27555-4-git-send-email-kgene.kim@samsung.com>
Message-ID: <AANLkTikqjZVKDgCIuZ0QCvzrzdrNmGUOq2YZyqb0TKZn@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 16, 2010 at 10:13 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> From: Naveen Krishna Ch <ch.naveen@samsung.com>
>
> This patch is to select support I2C channels 0, 1 and 2 for S5PV210 and S5P6440.
>
> Signed-off-by: Naveen Krishna Ch <ch.naveen@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
> ?drivers/i2c/busses/Kconfig | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index bceafbf..e553fe8 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -523,7 +523,7 @@ config I2C_PXA_SLAVE
>
> ?config I2C_S3C2410
> ? ? ? ?tristate "S3C2410 I2C Driver"
> - ? ? ? depends on ARCH_S3C2410 || ARCH_S3C64XX
> + ? ? ? depends on ARCH_S3C2410 || ARCH_S3C64XX || ARCH_S5PV210 || ARCH_S5P6440

Are there any SoCs don't have i2c? If no, how about to just depends on
PLAT_SAMSUNG.

Thank you,
Kyungmin Park
> ? ? ? ?help
> ? ? ? ? ?Say Y here to include support for I2C controller in the
> ? ? ? ? ?Samsung S3C2410 based System-on-Chip devices.
> --
> 1.6.2.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
