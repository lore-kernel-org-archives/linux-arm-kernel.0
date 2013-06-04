From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 4 Jun 2013 12:50:29 +0200
Subject: [PATCH] ARM: ux500: Remove SSP AUXDATA pertaining to DMA bindings
In-Reply-To: <1370267175-8117-1-git-send-email-lee.jones@linaro.org>
References: <1370267175-8117-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYE75qwqjaFGNgyJB+JuUFHf8rtRePW=sasi3jsX79jww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 3, 2013 at 3:46 PM, Lee Jones <lee.jones@linaro.org> wrote:

> These are now cared for from the Device Tree.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

These are not only used for the DMA bindings, so
the clock patches need to be finalized before this
patch I think...

git grep ssp0 drivers/clk/ux500/
drivers/clk/ux500/u8500_clk.c:  clk_register_clkdev(clk, "apb_pclk", "ssp0");
drivers/clk/ux500/u8500_clk.c:  clk =
clk_reg_prcc_kclk("p3_ssp0_kclk", "sspclk",
drivers/clk/ux500/u8500_clk.c:  clk_register_clkdev(clk, NULL, "ssp0");

Yours,
Linus Walleij
