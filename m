From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 29 Oct 2013 19:16:12 +0530
Subject: [PATCH] ARM: spear: fix return value check in
 spear_setup_of_timer()
In-Reply-To: <CAPgLHd8oLgehkC-4LdRgiASnZGfk0u3ueVQw8f4J6g+3zeT5tQ@mail.gmail.com>
References: <CAPgLHd8oLgehkC-4LdRgiASnZGfk0u3ueVQw8f4J6g+3zeT5tQ@mail.gmail.com>
Message-ID: <CAOh2x==aeT-DU+PoqzGRoe+RaL0K+sVFmSLKTqC_20BQ0QmtTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 7:34 AM, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> In case of error, the function clk_get_sys() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check
> should be replaced with IS_ERR().
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  arch/arm/mach-spear/time.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-spear/time.c b/arch/arm/mach-spear/time.c
> index d449673..3263a34 100644
> --- a/arch/arm/mach-spear/time.c
> +++ b/arch/arm/mach-spear/time.c
> @@ -222,7 +222,7 @@ void __init spear_setup_of_timer(void)
>         }
>
>         gpt_clk = clk_get_sys("gpt0", NULL);
> -       if (!gpt_clk) {
> +       if (IS_ERR(gpt_clk)) {
>                 pr_err("%s:couldn't get clk for gpt\n", __func__);
>                 goto err_iomap;
>         }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
