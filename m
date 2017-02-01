From: robh@kernel.org (Rob Herring)
Date: Wed, 1 Feb 2017 07:24:04 -0600
Subject: [PATCH v2 5/8] mfd: exynos-lpass: Remove pad retention control
In-Reply-To: <1485419634-28331-6-git-send-email-m.szyprowski@samsung.com>
References: <1485419634-28331-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170126083403eucas1p2328ed884334b453ffb1faac3c745cec3@eucas1p2.samsung.com>
 <1485419634-28331-6-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20170201132404.wxwcai7qbvcumaic@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 09:33:51AM +0100, Marek Szyprowski wrote:
> Pad retention should be controlled from pin control driver, so remove it
> from Exynos LPASS driver. After this change, no more access to PMU regmap
> is needed, so remove also the code for handling PMU regmap.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../bindings/mfd/samsung,exynos5433-lpass.txt           |  2 --

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/mfd/exynos-lpass.c                              | 17 -----------------
>  include/linux/mfd/syscon/exynos5-pmu.h                  |  3 ---
>  3 files changed, 22 deletions(-)
