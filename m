From: olof@lixom.net (Olof Johansson)
Date: Mon, 7 Mar 2011 00:37:26 -0800
Subject: [PATCH 1/2] Add initial support for the Toshiba AC100/Dynabook AZ
	netbook
In-Reply-To: <1299421906-7366-2-git-send-email-marvin24@gmx.de>
References: <1299421906-7366-1-git-send-email-marvin24@gmx.de>
	<1299421906-7366-2-git-send-email-marvin24@gmx.de>
Message-ID: <AANLkTinncQdKy-POUN2QQJYhc20Kg6z-grUBqehu7k8x@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Mar 6, 2011 at 6:31 AM, Marc Dietrich <marvin24@gmx.de> wrote:
> Signed-off-by: Marc Dietrich <marvin24@gmx.de>

As Colin said, a short patch description would be appreciated.

> diff --git a/arch/arm/mach-tegra/board-paz00-pinmux.c b/arch/arm/mach-tegra/board-paz00-pinmux.c
> new file mode 100644
> index 0000000..347a919
> --- /dev/null
> +++ b/arch/arm/mach-tegra/board-paz00-pinmux.c
[...]
> +static struct tegra_gpio_table gpio_table[] = {
> + ? ? ? { .gpio = TEGRA_GPIO_PV5, ? ? ? .enable = true ?}, /* mmc2 cd ? */
> + ? ? ? { .gpio = TEGRA_GPIO_PH1, ? ? ? .enable = true ?}, /* mmc2 wp ? */
> + ? ? ? { .gpio = TEGRA_GPIO_PT3, ? ? ? .enable = true ?}, /* mmc2 pwr ?*/
> + ? ? ? { .gpio = TEGRA_GPIO_PH2, ? ? ? .enable = true ?}, /* mmc4 cd ? */
> + ? ? ? { .gpio = TEGRA_GPIO_PH3, ? ? ? .enable = true ?}, /* mmc4 wp ? */
> + ? ? ? { .gpio = TEGRA_GPIO_PI6, ? ? ? .enable = true ?}, /* mmc4 pwr ?*/
> +};

Stephen Warren cleaned up Harmony and Seaboard and moved the GPIO
definitions to board-<board>.h and gave them symbolic names. Would you
mind doing that for these as well, please?

> diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
> new file mode 100644
> index 0000000..a33ce98
> --- /dev/null
> +++ b/arch/arm/mach-tegra/board-paz00.c
[...]
> +static struct tegra_sdhci_platform_data sdhci_pdata1 = {
> + ? ? ? .cd_gpio ? ? ? ?= -1,
> + ? ? ? .wp_gpio ? ? ? ?= -1,
> + ? ? ? .power_gpio ? ? = -1,
> +};
> +
> +static struct tegra_sdhci_platform_data sdhci_pdata2 = {
> + ? ? ? .cd_gpio ? ? ? ?= TEGRA_GPIO_PV5,
> + ? ? ? .wp_gpio ? ? ? ?= TEGRA_GPIO_PH1,
> + ? ? ? .power_gpio ? ? = TEGRA_GPIO_PT3,
> +};
> +
> +static struct tegra_sdhci_platform_data sdhci_pdata4 = {
> + ? ? ? .cd_gpio ? ? ? ?= TEGRA_GPIO_PH2,
> + ? ? ? .wp_gpio ? ? ? ?= TEGRA_GPIO_PH3,
> + ? ? ? .power_gpio ? ? = TEGRA_GPIO_PI6,
> + ? ? ? .is_8bit ? ? ? ?= 1,
> +};

Weird, the internal eMMC has CD and WP gpios?!


-Olof
