From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 26 Jan 2017 15:57:45 -0800
Subject: [PATCH] clk: meson8b: fix clk81 register address
In-Reply-To: <1485341586-2929-1-git-send-email-jbrunet@baylibre.com>
References: <1485341586-2929-1-git-send-email-jbrunet@baylibre.com>
Message-ID: <20170126235745.GI8801@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/25, Jerome Brunet wrote:
> During meson8b clock probe, clk81 register address is fixed twice.
> First using the meson8b_clk_gates array, then by directly changing
> meson8b_clk81 register.
> 
> As a result meson8b_clk81.reg = HHI_MPEG_CLK_CNTL + clk_base + clk_base.
> 
> Fixed by just removing the second fixup.
> 
> Fixes: e31a1900c1ff ("meson: clk: Add support for clock gates")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  Patch based on khilman/linux-amlogic.git master branch.

The problem isn't introduced there though?

> 
>  I don't have a meson8b HW so this patch so this patch has not been
>  tested on real HW.

Applied to clk-next.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
