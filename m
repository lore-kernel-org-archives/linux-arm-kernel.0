From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 20 Jan 2017 07:11:04 -0300
Subject: [PATCH 1/2] ARM: dts: exynos: Add CLK_ACLK432_SCALER clock to
 gsc_pd for Exynos5800
In-Reply-To: <1484864995-10679-1-git-send-email-javier@osg.samsung.com>
References: <1484864995-10679-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1a244e36-a965-3efb-4413-b40e8c549cf9@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 01/19/2017 07:29 PM, Javier Martinez Canillas wrote:
> On Exynos5800 SoC the SCALER block uses 2 input clocks: CLK_ACLK_300_GSCL
> and CLK_ACLK432_SCALER, so both needs to be ungated in order to access it.
> 
> The SoC manual say the CLK_ACLK432_SCALER is needed to access the internal
> buses, so add this clock as another asynchronous bridges (ASB) clock.
> 
> The Exynos5420 only has the CLK_ACLK_300_GSCL clock defined. So just using
> this definition from exynos5420.dtsi in Exynos5800 leads to the following:
> 

Please ignore this patch as suggested by Marek. Instead I'll post a patch
to mark the clock as CLK_IS_CRITICAL, as a temporary workaround until a
proper runtime PM based solution gets merged.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
