From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 16 May 2016 15:22:29 +0200
Subject: [PATCH v5 0/2] Introducing Exynos ChipId driver
In-Reply-To: <1418285264-21763-1-git-send-email-pankaj.dubey@samsung.com>
References: <1418285264-21763-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <CAJKOXPdteY4DH_QpCztbnuY6Njhxb4nvKt14gOundwGdHyb+cQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 11, 2014 at 9:07 AM, Pankaj Dubey <pankaj.dubey@samsung.com> wrote:
> This patch series introduces Exynos Chipid platform driver.
> Each Exynos SoC has ChipID block which can give information about SoC's
> product Id and revision number.
> At the same time it reduces dependency of mach-exynos files from plat-samsung,
> by removing samsung_rev API, similar API is introduced in chipid driver itself
> to get revision number and product id.
>
> This patch series is based on Kukjin Kim's for-next having SHA_ID:
> 9db7d78aca2c7fbc19a26ce2ef01c805dc010c72
>
> It can also be cleanly applied on latest (next-20141209) linux-next.
>
> This has been tested against both tree on Exynos3250 and Exynos5250 (SMDK) board.
>
> Revision 4 and it's discussion can be found here
>  - https://lkml.org/lkml/2014/12/3/115
>
> Changes since v4:
>  - Removed custom sysfs entries as they were not providing any new information
>    as pointed out by Arnd.
>  - Removed functions exporting product_id and revision, instead we will export
>    exynos_chipid_info structure. It will be helpfull when we need to provide more
>    fields of chipid outside of chipid, as commented by Yadwinder
>  - Converted all funcions as __init.
>
> Change since v3:
>  - This patch set contains 5/6 and 6/6 patch from v3 series.
>  - Made EXYNOS_CHIPID config option non-user selectable,
>    as suggested by Tomasz Figa.
>  - Made uniform macro for EXYNOS4/5_SOC_MASK as EXYNOS_SOC_MASK as
>    suggested by Tomasz Figa.
>  - Made local variables static in chipid driver.
>  - Added existing SoC's product id's.
>  - Added platform driver support.
>
> Changes since v2:
>  - Reorganized patches as suggested by Tomasz Figa.
>  - Addressed review comments of Tomasz Figa in i2c-s3c2410.c file.
>
> Changes since v1:
>  - Added patch to move i2c interrupt re-configuration code from exynos.c
>    to i2c driver, as suggested by Arnd.
>  - After above patch only user of SYS_I2C_CFG register is pm.c so moving
>    save/restore of this register also into i2c driver.
>  - Spiltted up exynos4 and exynos5 machine descriptors to get rid from
>    soc_is_exynos4/exynos5 kind of macros, as suggested by Arnd.
>  - Changed location of chipid driver to "drivers/soc".
>  - Added drivers/base/soc.c provided infrastructure to make SoC specific
>    information avaible to user space via sysfs entry, as suggested by Arnd.
>
>
> Pankaj Dubey (2):
>   soc: samsung: add exynos chipid driver support
>   ARM: EXYNOS: refactoring of mach-exynos to enable chipid driver

Hi,

This is quite old patchset and apparently was not merged. I quickly
looked at previous discussions (for previous versions) and it seems
all review feedback was addressed.

Any other obstacles?

Pankaj, maybe you could respin this (after merge window)?

Best regards,
Krzysztof
