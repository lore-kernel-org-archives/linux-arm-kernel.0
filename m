From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 9 May 2016 15:00:50 -0700
Subject: [PATCH v2 00/22] ARM: dts: exynos: Add initial support for
 Odroid XU
In-Reply-To: <1462734367-5619-1-git-send-email-krzk@kernel.org>
References: <1462734367-5619-1-git-send-email-krzk@kernel.org>
Message-ID: <20160509220050.GR3492@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/08, Krzysztof Kozlowski wrote:
> 
> Hi,
> 
> Patchset adds necessary clocks, reorganizes existing stuff and finally
> adds Odroid XU support.
> 
> Merging strategy
> ================
> Complicated! The clock dt-bindings and driver changes can go to clock
> tree. However there are three DTS patches in the middle.
> a. This has to go in before adding "fin_pll_new" to clock driver:
>    - [PATCH v2 03/22] ARM: dts: exynos: Add fin_pll node for clock driver
> 
> b. This should go in before renaming "fin_pll_new" back to original name:
>    - [PATCH v2 05/22] ARM: dts: exynos: Switch MCT node to a new fin_pll clock
>    - [PATCH v2 06/22] ARM: dts: exynos: Remove old fixed-clock provider on SMDK5410
> 
> The order of patches in the patchset is really how it should go in
> to reduce any bisectability glitches.

If you want to just merge them through arm-soc then feel free to
add my Acked-by to the clk driver and clock dt-binding ones.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
