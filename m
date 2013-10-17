From: abrestic@chromium.org (Andrew Bresticker)
Date: Thu, 17 Oct 2013 15:33:13 -0700
Subject: [PATCH v4 05/15] clk: tegra: move some PLLC and PLLXC init to
 clk-pll.c
In-Reply-To: <1382013526-12800-6-git-send-email-pdeschrijver@nvidia.com>
References: <1382013526-12800-1-git-send-email-pdeschrijver@nvidia.com>
 <1382013526-12800-6-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <CAL1qeaHsun=6NP4fk4tLCDr5XkLn71-y273Qz5hcfMagek3ZPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

> +       val = readl_relaxed(clk_base + pll_params->base_reg);
> +       val_iddq = readl_relaxed(clk_base + pll_params->iddq_reg);
> +
> +       if (val & BIT(30))

BIT(30) -> PLL_BASE_ENABLE?

> +               WARN_ON(val_iddq & BIT(pll_params->iddq_bit_idx));
> +       else {
> +               val_iddq |= BIT(pll_params->iddq_bit_idx);
> +               writel_relaxed(val_iddq, clk_base + pll_params->iddq_reg);
> +       }

Thanks,
Andrew
