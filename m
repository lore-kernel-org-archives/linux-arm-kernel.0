From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 7 Jun 2013 13:21:56 +0200
Subject: [PATCH] pinctrl: exynos5440: fix issues reported by prevent tool
In-Reply-To: <09d101ce6254$40813eb0$c183bc10$%kim@samsung.com>
References: <09d101ce6254$40813eb0$c183bc10$%kim@samsung.com>
Message-ID: <CACRpkdY=6YQK9BY=T_OoA3H6awyNUaqEMd0kx6paSJ-dr6WKzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 6, 2013 at 3:22 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:

> From: Thomas Abraham <thomas.ab@samsung.com>
>
> This patch fixes issues reported by prevent tool.
>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>

Patch applied except for this hunk:

> -       priv = devm_kzalloc(dev, sizeof(priv), GFP_KERNEL);
> +       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);

That was already fixed by the patch
"pinctrl: exynos5440: fix invalid use of sizeof in exynos5440_pinctrl_probe()"
by Wei Yongjun.

Yours,
Linus Walleij
