From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Fri, 8 Nov 2013 15:51:26 +0530
Subject: [PATCH 1/3] clk: exynos5250: save/restore EPLL0 configuration
In-Reply-To: <1383905648-23733-1-git-send-email-sachin.kamat@linaro.org>
References: <1383905648-23733-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <CAK9yfHwU6NLdB1QYn0FJKSaAw5u9yXc6KkdXSom8ZOL2RZAsPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 November 2013 15:44, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> From: Andrew Bresticker <abrestic@chromium.org>
>
> The EPLL configuration register needs to be saved across
> suspend/resume.
>
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/clk/samsung/clk-exynos5250.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
> index ee866e377c80..6767635dc895 100644
> --- a/drivers/clk/samsung/clk-exynos5250.c
> +++ b/drivers/clk/samsung/clk-exynos5250.c
> @@ -143,6 +143,7 @@ static unsigned long exynos5250_clk_regs[] __initdata = {
>         SRC_CPU,
>         DIV_CPU0,
>         SRC_CORE1,
> +       EPLL_CON0,
>         SRC_TOP0,
>         SRC_TOP2,
>         SRC_TOP3,
> --
> 1.7.9.5
>

Forgot to mention that this series is based on top of Tomasz Figa's
Exynos5250 cleanup series.
http://www.spinics.net/lists/arm-kernel/msg280039.html

-- 
With warm regards,
Sachin
