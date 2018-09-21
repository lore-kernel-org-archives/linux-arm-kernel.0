From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 21 Sep 2018 12:55:54 +0200
Subject: [PATCHv3 0/7] Add support for UHS-I on Exynos5422 odroid boards
In-Reply-To: <20180920175826.1284-1-linux.amoon@gmail.com>
References: <20180920175826.1284-1-linux.amoon@gmail.com>
Message-ID: <CAJKOXPdsAK1_9JRzq7_pVfDwBK6WGkFbYUsbcsujCh31Fzsz6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 20 Sep 2018 at 19:58, Anand Moon <linux.amoon@gmail.com> wrote:
>
> This is series v3 since my previous patches we incomplete with driver
> changes missing.
>
> These changes add UHS-I tuning for dw_mmc-exynos driver.
> Some new patches are added to enhance the performace.

Patches look like based on some older version of kernel tree (or
current mainline) and probably they will not apply on my tree. The
easiest is to base on top of linux-next or, for DTS patches, on my
next/dt branch.

Best regards,
Krzysztof

>
> Anand Moon (7):
>   ARM: dts: exynos5422: Added UHS-I bus speed support
>   ARM: dts: exynos5422: fix regulator min values of LDO13 for Odroid
>     XU3/XU4
>   ARM: dts: exynos5422: update maximum frequency for sdcard to 200MHz
>   ARM: dts: exynos5422: use cd-gpio method to detect sd-card
>   ARM: dts: exynos5422: use wp-gpio method to detect sd-card
>   ARM: dts: exynos5422: update maximum frequency for emmc to 200MHz
>   mmc: dw_mmc-exynos: Add tuning for sdr and ddr timing for USH-I mode
>
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi      |  8 +++++++-
>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  1 +
>  drivers/mmc/host/dw_mmc-exynos.c                   | 11 +++++++++++
>  3 files changed, 19 insertions(+), 1 deletion(-)
>
> --
> 2.17.1
>
