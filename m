From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 2 Nov 2017 01:06:24 -0700
Subject: [PATCH] clk: mediatek: mark mtk_infrasys_init_early __init
In-Reply-To: <20170915192848.649455-1-arnd@arndb.de>
References: <20170915192848.649455-1-arnd@arndb.de>
Message-ID: <20171102080624.GD11011@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/15, Arnd Bergmann wrote:
> On gcc-4.6, we get a harmless link-time warning:
> 
> WARNING: vmlinux.o(.text.unlikely+0x196a0): Section mismatch in reference from the function mtk_infrasys_init_early() to the function .init.text:mtk_clk_register_cpumuxes()
> The function mtk_infrasys_init_early() references
> the function __init mtk_clk_register_cpumuxes().
> This is often because mtk_infrasys_init_early lacks a __init
> annotation or the annotation of mtk_clk_register_cpumuxes is wrong.
> 
> Newer compilers inline this function so they don't warn, but
> marking it __init is the right solution for all versions.
> 
> Fixes: e9862118272a ("clk: mediatek: Add MT2701 clock support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
