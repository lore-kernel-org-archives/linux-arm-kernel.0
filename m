From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 24 Jun 2013 12:50:24 -0600
Subject: [PATCH] clk: tegra: provide tegra_periph_reset_assert alternative
In-Reply-To: <201306212232.27026.arnd@arndb.de>
References: <201306212232.27026.arnd@arndb.de>
Message-ID: <51C894F0.2010301@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/21/2013 02:32 PM, Arnd Bergmann wrote:
> We have some tegra device drivers that are written to be platform
> independent but still use the tegra specific tegra_periph_reset_assert
> function. In order to build and link them without errors,
> this provides a static inline version of these functions that
> does nothing when Tegra support is disabled.

> diff --git a/include/linux/clk/tegra.h b/include/linux/clk/tegra.h

> +#ifdef ARCH_TEGRA

That should be CONFIG_ARCH_TEGRA, right? Sorry I didn't notice that
before. This causes the Tegra i2c driver to fail on some platforms in
next-20130624, resulting in a BUG() during boot.

Do you want to amend this patch, or should I send a fixup?
