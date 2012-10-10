From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Oct 2012 09:18:51 +0200
Subject: [PATCH 02/16] pinctrl: exynos: Parse wakeup-eint parameters from
 DT
In-Reply-To: <1349685556-23718-3-git-send-email-t.figa@samsung.com>
References: <1349685556-23718-1-git-send-email-t.figa@samsung.com>
 <1349685556-23718-3-git-send-email-t.figa@samsung.com>
Message-ID: <CACRpkdZ97BRHo1Usen-D9CnojU4HLqkNb5CKNOmx7uP1A9ttgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 8, 2012 at 10:39 AM, Tomasz Figa <t.figa@samsung.com> wrote:

> This patch converts the pinctrl-exynos driver to parse wakeup interrupt
> count and register offsets from device tree. It reduces the amount of
> static platform-specific data and facilitates adding further SoC
> variants to pinctrl-samsung driver.

So these are:

> +       ret = of_property_read_u32(wkup_np, "samsung,weint-count", &val);
> +       ret = of_property_read_u32(wkup_np, "samsung,weint-con", &val);
> +       ret = of_property_read_u32(wkup_np, "samsung,weint-mask", &val);
> +       ret = of_property_read_u32(wkup_np, "samsung,weint-pend", &val);

Are these all four register offsets?

I don't think it's proper for the device tree to contain register offsets.

Base address, "regs" property, yes. Individual registers, no. That just
makes the code hard to read and compare to the datasheet.

Or what are you aiming at here?

Linus Walleij
