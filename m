From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 11 Apr 2014 14:44:31 +0800
Subject: [PATCH RESEND 2/5] pinctrl: berlin: add a pinctrl driver for
 Marvell Berlin SoCs
In-Reply-To: <1397135274-10764-3-git-send-email-antoine.tenart@free-electrons.com>
References: <1397135274-10764-1-git-send-email-antoine.tenart@free-electrons.com>
 <1397135274-10764-3-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20140411144431.04fb148d@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine,

On Thu, 10 Apr 2014 06:07:51 -0700
Antoine T?nart <antoine.tenart@free-electrons.com> wrote:

...
> +static int berlin_pinmux_enable(struct pinctrl_dev *pctrl_dev,
> +                               unsigned function,
> +                               unsigned group)
> +{
> +       struct berlin_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctrl_dev);
> +       struct berlin_pinctrl_group *group_desc = pctrl->groups + group;
> +       struct berlin_pinctrl_function *function_desc =
> +               pctrl->functions + function;
> +       unsigned long flags;
> +       u32 regval;
> +
> +       spin_lock_irqsave(&pctrl->lock, flags);
> +
> +       regval = readl(group_desc->reg);
> +       regval &= group_desc->mask;
> +       regval |= function_desc->muxval << group_desc->lsb;
> +       writel(regval, group_desc->reg);

Could we use relaxed version instead?

Thanks,
Jisheng
