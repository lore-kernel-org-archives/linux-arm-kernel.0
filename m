From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 30 Nov 2015 11:35:38 -0800
Subject: [PATCH] clk: ti: omap5+: dpll: implement errata i810
In-Reply-To: <1448894605-30097-1-git-send-email-t-kristo@ti.com>
References: <1448894605-30097-1-git-send-email-t-kristo@ti.com>
Message-ID: <20151130193538.GJ11298@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/30, Tero Kristo wrote:
> Errata i810 states that DPLL controller can get stuck while transitioning
> to a power saving state, while its M/N ratio is being re-programmed.
> 
> As a workaround, before re-programming the M/N ratio, SW has to ensure
> the DPLL cannot start an idle state transition. SW can disable DPLL
> idling by setting the DPLL AUTO_DPLL_MODE=0 or keeping a clock request
> active by setting a dependent clock domain in SW_WKUP.
> 
> This errata impacts OMAP5 and DRA7 chips, so enable the errata for these.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
