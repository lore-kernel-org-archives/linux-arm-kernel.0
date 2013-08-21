From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 21 Aug 2013 10:23:11 +0200
Subject: [PATCH 19/33] clk: ux500: Add Device Tree support for the PRCMU
 clock
In-Reply-To: <1370521041-32318-20-git-send-email-lee.jones@linaro.org>
References: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
 <1370521041-32318-20-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdar9oOWQ9xuQnKvvAOw-eQS1-FkDSDD8BwQT3WDE8YzBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 6, 2013 at 2:17 PM, Lee Jones <lee.jones@linaro.org> wrote:

> This patch enables clocks to be specified from Device Tree via phandles
> to the "prcmu-clock" node.
(..)
> @@ -52,14 +54,17 @@ void u8500_clk_init(u32 clkrst1_base, u32 clkrst2_base, u32 clkrst3_base,
>         clk = clk_reg_prcmu_gate("soc0_pll", NULL, PRCMU_PLLSOC0,
>                                 CLK_IS_ROOT|CLK_IGNORE_UNUSED);
>         clk_register_clkdev(clk, "soc0_pll", NULL);
> +       prcmu_clk[PRCMU_PLLSOC0] = clk;

Same comment on all these.

No clk_register_clkdev() on the DT boot path please.

Yours,
Linus Walleij
