From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 20 Nov 2012 10:35:30 +0100
Subject: [PATCH] ARM: dts: exynos4: Use drive strength 3 for SD pins
In-Reply-To: <0c2f01cdc700$09c204d0$1d460e70$%kim@samsung.com>
References: <21831256.UCkQ5RyKd5@amdc1227>
 <0c2f01cdc700$09c204d0$1d460e70$%kim@samsung.com>
Message-ID: <1961860.xzxk1Exu2U@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kgene,

On Tuesday 20 of November 2012 18:18:44 Kukjin Kim wrote:
> Tomasz Figa wrote:
> > This patch modifies pin control groups of SD pins on Exynos4210 and
> > Exynos4x12 to use drive strength 3, which corresponds to
> > S5P_GPIO_DRVSTR_LV4 in legacy non-DT code.
> 
> Well, the value of drive strength depends on board not SoC. So if
> required, it should be moved to board DT stuff.

Yes, I fully agree.

I've been thinking whether to change the defaults or just override them 
for Origen, but I came to a conclusion that 3 (LV4) was the default in 
non-DT code, so it probably should be also the default in DT variant.

> BTW, we can use the value as a default...I need to think about that
> again for exynos4210 and 4x12.

I wonder which default value is more appropriate, 0 or 3?

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
SW Solution Development, Linux Platform
