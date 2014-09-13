From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 13 Sep 2014 13:20:12 +0200
Subject: [PATCH v4 2/8] clk: samsung: Factor out the common code to clk.c
In-Reply-To: <1410535592-5782-4-git-send-email-ch.naveen@samsung.com>
References: <1410535592-5782-1-git-send-email-ch.naveen@samsung.com>
 <1410535592-5782-4-git-send-email-ch.naveen@samsung.com>
Message-ID: <5414286C.40103@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Naveen,

Please see my comments inline.

On 12.09.2014 17:26, Naveen Krishna Chatradhi wrote:
> While adding clock support for Exynos5260, the infrastructure to
> register multiple clock controllers was introduced. Factor out the
> support for registering multiple clock controller from Exynos5260
> clock code to common samsung clock code so that it can be used by
> other Exynos SoC which have multiple clock controllers.

[snip]

> @@ -268,7 +135,7 @@ struct samsung_gate_clock aud_gate_clks[] __initdata = {
>  
>  static void __init exynos5260_clk_aud_init(struct device_node *np)
>  {
> -	struct exynos5260_cmu_info cmu = {0};
> +	struct exynos_cmu_info cmu = {0};
>  
>  	cmu.mux_clks = aud_mux_clks;
>  	cmu.nr_mux_clks = ARRAY_SIZE(aud_mux_clks);
> @@ -280,7 +147,7 @@ static void __init exynos5260_clk_aud_init(struct device_node *np)
>  	cmu.clk_regs = aud_clk_regs;
>  	cmu.nr_clk_regs = ARRAY_SIZE(aud_clk_regs);
>  
> -	exynos5260_cmu_register_one(np, &cmu);
> +	exynos_cmu_register_one(np, &cmu);

I'd suggest changing the namespace prefix from exynos to just samsung to
be consistent with other helpers. Otherwise looks good.

Best regards,
Tomasz
