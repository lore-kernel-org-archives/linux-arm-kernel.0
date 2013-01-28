From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 28 Jan 2013 13:57:41 -0700
Subject: [PATCH v4 4/7] ARM: Exynos: allow dt based discovery of mct
 controller using clocksource_of_init
In-Reply-To: <1358762542-19008-5-git-send-email-thomas.abraham@linaro.org>
References: <1358762542-19008-1-git-send-email-thomas.abraham@linaro.org>
 <1358762542-19008-5-git-send-email-thomas.abraham@linaro.org>
Message-ID: <5106E645.70807@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/21/2013 03:02 AM, Thomas Abraham wrote:
> Add entries to __clksrc_of_table so that Exynos MCT controller is discoverable
> using call to clocksource_of_init. With this change, it would be appropriate to
> rename the function 'exynos4_timer_init' as 'mct_init' since it aptly describes
> this function. Additionally, the 'init_time' callback of all machine descriptors
> for exynos platforms that were previously set to 'exynos4_timer_init' are now
> set to either 'mct_init' or 'clocksource_of_init'.

> diff --git a/arch/arm/mach-exynos/mct.c b/arch/arm/mach-exynos/mct.c

> +#ifdef CONFIG_CLKSRC_OF
> +CLOCKSOURCE_OF_DECLARE(exynos4210, "samsung,exynos4210-mct", mct_init)
> +CLOCKSOURCE_OF_DECLARE(exynos4412, "samsung,exynos4412-mct", mct_init)
> +#endif

I suggested in another review (IIRC for a different SoC) that
CLOCKSOURCE_OF_DECLARE() should always be declared so you don't need
that ifdef. Would you care to send a patch to add to arm-soc's
timer/cleanup branch to do that? If not, let me know and I can.
