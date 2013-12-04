From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 04 Dec 2013 10:03:32 -0700
Subject: [PATCH V2 1/2] ARM: tegra: Add header file for pinctrl constants
In-Reply-To: <1386076567-14283-1-git-send-email-ldewangan@nvidia.com>
References: <1386076567-14283-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <529F6064.3010300@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/2013 06:16 AM, Laxman Dewangan wrote:
> This new header file defines pincontrol constants for Tegra to
> use from Tegra's DTS file for pincontrol properties option.

> diff --git a/include/dt-bindings/pinctrl/pinctrl-tegra.h b/include/dt-bindings/pinctrl/pinctrl-tegra.h

> +#define TEGRA_PIN_DISABLE				0
> +#define TEGRA_PIN_ENABLE				1

That needs a comment re: which properties the defines can be used with,
since the properties are no longer related to the defines by name.

> +/* Pull up/down/normal */
> +#define TEGRA_PIN_PULL_NONE				0
> +#define TEGRA_PIN_PULL_DOWN				1
> +#define TEGRA_PIN_PULL_UP				2

Whereas that comment seems unnecessary, since it's obvious from the
define names.

> +/* Low power mode */
> +#define TEGRA_PIN_LP_DRIVE_DIV_8			0
> +#define TEGRA_PIN_LP_DRIVE_DIV_4			1
> +#define TEGRA_PIN_LP_DRIVE_DIV_2			2
> +#define TEGRA_PIN_LP_DRIVE_DIV_1			3
