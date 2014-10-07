From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Tue, 7 Oct 2014 14:29:40 +0200
Subject: [PATCH v9 1/2] ARM: EXYNOS: Add platform driver support for
 Exynos PMU
In-Reply-To: <1412587602-7763-2-git-send-email-pankaj.dubey@samsung.com>
References: <1412587602-7763-1-git-send-email-pankaj.dubey@samsung.com>
 <1412587602-7763-2-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <CABxcv=n3M0Td5GoqugSgk5P5juZsCFnuV7dD92WQjaQPpfesmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Pankaj,

On Mon, Oct 6, 2014 at 11:26 AM, Pankaj Dubey <pankaj.dubey@samsung.com> wrote:
> This patch modifies Exynos Power Management Unit (PMU) initialization
> implementation in following way:
>
> - Added platform driver support for Exynos PMU IP.
> - Added platform struct exynos_pmu_data to hold platform specific data.
> - For each SoC's PMU support now we can add platform data and statically
>   bind PMU configuration and SoC specific initialization function.
> - Separate each SoC's PMU initialization function and make it as part of
>   platform data.
> - It also removes uses of soc_is_exynosXYZ().
>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> ---
>  arch/arm/mach-exynos/Kconfig |    1 +
>  arch/arm/mach-exynos/pmu.c   |  171 +++++++++++++++++++++++++++++++-----------
>  2 files changed, 130 insertions(+), 42 deletions(-)
>

Suspend-to-RAM is working on my Exynos5420 Peach Pit Chromebook, so:

Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
