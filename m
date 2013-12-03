From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 03 Dec 2013 13:05:41 -0700
Subject: [PATCH 1/2] ARM: dts: tegra: Header file for pinctrl constants
In-Reply-To: <1385992502-12771-1-git-send-email-ldewangan@nvidia.com>
References: <1385992502-12771-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <529E3995.8090606@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/2013 06:55 AM, Laxman Dewangan wrote:
> Defines pincontrol constants to use from Tegra's DTS file
> for tegra pincontrol properties option.

> diff --git a/include/dt-bindings/pinctrl/pinctrl-tegra.h b/include/dt-bindings/pinctrl/pinctrl-tegra.h

> +/* Tristate/normal */
> +#define TEGRA_PIN_NORMAL				0
> +#define TEGRA_PIN_TRISTATE				1

"NORMAL" is a bit generic. "DRIVEN" might work better.

> +/* High speed mode */
> +#define TEGRA_PIN_DRIVE_HIGH_SPEED_MODE_DISABLE		0
> +#define TEGRA_PIN_DRIVE_HIGH_SPEED_MODE_ENABLE		1
> +
> +/* Schmitt enable/disable */
> +#define TEGRA_PIN_DRIVE_SCHMITT_DISABLE			0
> +#define TEGRA_PIN_DRIVE_SCHMITT_ENABLE			1

I expect you can remove "DRIVE_" from all those names to make things
shorter.
