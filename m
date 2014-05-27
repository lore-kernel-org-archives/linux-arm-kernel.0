From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 27 May 2014 13:07:56 +0200
Subject: [PATCH v5 5/5] arm: exynos: Add MCPM call-back functions
In-Reply-To: <1399307221-8659-6-git-send-email-a.kesavan@samsung.com>
References: <1399307221-8659-1-git-send-email-a.kesavan@samsung.com>
 <1399307221-8659-6-git-send-email-a.kesavan@samsung.com>
Message-ID: <201405271307.56729.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 May 2014, Abhilash Kesavan wrote:
> +static const struct mcpm_platform_ops exynos_power_ops = {
> +       .power_up               = exynos_power_up,
> +       .power_down             = exynos_power_down,
> +       .power_down_finish      = exynos_power_down_finish,
> +};


I'm getting a build error in linux-next because there is no .power_down_finish
member in mcpm_platform_ops here.

	Arnd
