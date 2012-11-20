From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 20 Nov 2012 18:18:44 +0900
Subject: [PATCH] ARM: dts: exynos4: Use drive strength 3 for SD pins
In-Reply-To: <21831256.UCkQ5RyKd5@amdc1227>
References: <21831256.UCkQ5RyKd5@amdc1227>
Message-ID: <0c2f01cdc700$09c204d0$1d460e70$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:
> 
> This patch modifies pin control groups of SD pins on Exynos4210 and
> Exynos4x12 to use drive strength 3, which corresponds to
> S5P_GPIO_DRVSTR_LV4 in legacy non-DT code.
> 
Well, the value of drive strength depends on board not SoC. So if required,
it should be moved to board DT stuff.

BTW, we can use the value as a default...I need to think about that again
for exynos4210 and 4x12.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.


> This is needed at least on Origen board for sdhci2 to work.
> 
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4210-pinctrl.dtsi | 56 +++++++++++++++-----------
> -----
>  arch/arm/boot/dts/exynos4x12-pinctrl.dtsi | 56 +++++++++++++++-----------
> -----
>  2 files changed, 56 insertions(+), 56 deletions(-)
