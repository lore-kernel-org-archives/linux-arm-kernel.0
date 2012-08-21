From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 21 Aug 2012 14:04:23 +0200
Subject: [PATCH v2 4/4] ARM: EXYNOS: skip wakeup interrupt setup if
 pinctrl driver is used
In-Reply-To: <1345060656-32201-5-git-send-email-thomas.abraham@linaro.org>
References: <1345060656-32201-1-git-send-email-thomas.abraham@linaro.org>
 <1345060656-32201-5-git-send-email-thomas.abraham@linaro.org>
Message-ID: <CACRpkdaxSZZQwefN3FNvv3ctXFHqaLZoAZ5f8CVu7Tx9n6-v1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 15, 2012 at 9:57 PM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:

> Pinctrl driver includes support for configuring the external wakeup
> interrupts. On exynos platforms that use pinctrl driver, the setup
> of wakeup interrupts in the exynos platform code can be skipped.
>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>

> +#ifdef CONFIG_OF

Don't you actually want to use:

#fidef CONFIG_PINCTRL_SAMSUNG

here? CONFIG_OF is a bit vague.

Yours,
Linus Walleij
