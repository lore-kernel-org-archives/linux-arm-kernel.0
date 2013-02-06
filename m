From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 6 Feb 2013 10:59:31 +0530
Subject: [RESEND][PATCH] ARM: EXYNOS: Add clocks for EXYNOS I2S and PCM I/F
In-Reply-To: <003201ce0429$c15e8350$441b89f0$@samsung.com>
References: <003201ce0429$c15e8350$441b89f0$@samsung.com>
Message-ID: <CAK9yfHwZ6JOxtSEd1960v_Zb2QkpTQz7RG6NcSrJMCLzVWjJEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 February 2013 10:51, Sangsu Park <sangsu4u.park@samsung.com> wrote:
> Audio Subsystem has own clocks for I2S0 and PCM0 in all EXYNOS series.
> This patch add clocks for I2S0 and PCM0 I/F.
>
> Signed-off-by: Sangsu Park <sangsu4u.park@samsung.com>
> ---
>  arch/arm/mach-exynos/Makefile      |    1 +
>  arch/arm/mach-exynos/clock-audss.c |   64 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 65 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-exynos/clock-audss.c
>
[snip]
> diff --git a/arch/arm/mach-exynos/clock-audss.c
> b/arch/arm/mach-exynos/clock-audss.c
> new file mode 100644
> index 0000000..8260185
> --- /dev/null
> +++ b/arch/arm/mach-exynos/clock-audss.c
> @@ -0,0 +1,64 @@
[snip]
> +static void __iomem *clk_audss_base = 0;
> +
> +static int exynos_clk_audss_ctrl(struct clk *clk, int enable)
> +{
> +       if (!clk_audss_base)
> +               return ENOMEM;

Return value should be negative (-ENOMEM).



-- 
With warm regards,
Sachin
