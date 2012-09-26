From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 26 Sep 2012 13:10:49 +0200
Subject: [PATCH v1 01/12] clk: davinci - add Main PLL clock driver
In-Reply-To: <1348525213-18987-2-git-send-email-m-karicheri2@ti.com>
References: <1348525213-18987-1-git-send-email-m-karicheri2@ti.com>
 <1348525213-18987-2-git-send-email-m-karicheri2@ti.com>
Message-ID: <CACRpkdbpZ+dxoCq7Ky=EMDR2uDX10vyn3-P+V6iN8mwWCof+HQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2012 at 12:20 AM, Murali Karicheri <m-karicheri2@ti.com> wrote:

> +struct clk_davinci_pll_data {
> +       /* physical addresses set by platform code */
> +       u32 phy_pllm;
> +       /* if PLL has a prediv register this should be non zero */
> +       u32 phy_prediv;
> +       /* if PLL has a postdiv register this should be non zero */
> +       u32 phy_postdiv;
> +       /* mapped addresses. should be initialized by  */
> +       void __iomem *pllm;
> +       void __iomem *prediv;
> +       void __iomem *postdiv;
> +       u32 pllm_mask;
> +       u32 prediv_mask;
> +       u32 postdiv_mask;
> +       u32 num;
> +       /* framework flags */
> +       u32 flags;
> +       /* pll flags */
> +       u32 pll_flags;
> +       u32 fixed_prediv;       /* use this value for prediv */
> +       u32 pllm_multiplier;    /* multiply PLLM by this factor. By default
> +                                * most SOC set this to zero that translates
> +                                * to a multiplier of 1 and incrementer of 1.
> +                                * To override default, set this factor */
> +};

OMG this commenting style hurt my eyes ;-)

Please use good old kerneldoc above the struct instead.

Yours,
Linus Walleij
