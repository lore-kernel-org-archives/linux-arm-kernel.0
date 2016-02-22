From: tony@atomide.com (Tony Lindgren)
Date: Mon, 22 Feb 2016 08:59:59 -0800
Subject: [PATCHv2] clk: ti: dpll: convert DPLL support code to use clk_hw
 instead of clk ptrs
In-Reply-To: <1455967466-3812-1-git-send-email-t-kristo@ti.com>
References: <1455967466-3812-1-git-send-email-t-kristo@ti.com>
Message-ID: <20160222165959.GG13417@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [160220 03:24]:
> Convert DPLL support code to use clk_hw pointers for reference and bypass
> clocks. This allows us to use clk_hw_* APIs for accessing any required
> parameters for these clocks, avoiding some locking problems at least with
> DPLL enable code; this used clk_get_rate which uses mutex but isn't
> good under clk_enable / clk_disable.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
> v2: rebased the patch on top of v2 of 'clk: ti: omap3+: dpll: use non-locking
>     version of clk_get_rate', as that one is required already for -rc. This
>     patch can follow in 4.6 merge window.

Yeah seems this one can wait for v4.6 merge window no problem:

Acked-by: Tony Lindgren <tony@atomide.com>

Regards,

Tony
