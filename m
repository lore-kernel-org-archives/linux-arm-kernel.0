From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 24 Aug 2011 14:17:55 +0800
Subject: [PATCH 2/4 v4] pinmux: add a driver for the U300 pinmux
In-Reply-To: <1313747646-32294-1-git-send-email-linus.walleij@stericsson.com>
References: <1313747646-32294-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CAGsJ_4w+dkzHbYBehEzgK2+Js=BmAYe2gHKQ1PtYc=ymhovnDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,
This patch can't compile....
> +
> +/**
> + * @dev: a pointer back to containing device
> + * @virtbase: the offset to the controller in virtual memory
> + */
> +struct u300_pmx {
> + ? ? ? struct device *dev;
> + ? ? ? struct pinmux_dev *pmx;

no this structure in head file, now it is pinctrl_desc.

> + ? ? ? u32 phybase;
> + ? ? ? u32 physize;
> + ? ? ? void __iomem *virtbase;
> +};

> + ? ? ? /* Now register the pin controller and all pins it handles */
> + ? ? ? upmx->pctl = pinctrl_register(&u300_pmx_desc, &pdev->dev, upmx);

no this field in upmx structure.

> + ? ? ? if (IS_ERR(upmx->pctl)) {

Did you send the wrong version?

-barry
