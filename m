From: viresh.linux@gmail.com (viresh kumar)
Date: Mon, 29 Nov 2010 12:02:08 +0530
Subject: [PATCH] arm: plat-spear: time: use IS_ERR() instead of NULL check
In-Reply-To: <1290791168-21255-1-git-send-email-segoon@openwall.com>
References: <1290791168-21255-1-git-send-email-segoon@openwall.com>
Message-ID: <AANLkTi==K=pYU-x5ZQQ9ACLD-MN8o9N61JbVqpBZnQWT@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 26, 2010 at 10:36 PM, Vasiliy Kulikov <segoon@openwall.com> wrote:
> clk_get() returns ERR_PTR() on error, not NULL.
>
> Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>
> ---
> ?Cannot compile this driver, so it is not tested at all.
>
> ?arch/arm/plat-spear/time.c | ? ?4 ++--
> ?1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/plat-spear/time.c b/arch/arm/plat-spear/time.c
> index ab21165..678df18 100644
> --- a/arch/arm/plat-spear/time.c
> +++ b/arch/arm/plat-spear/time.c
> @@ -229,13 +229,13 @@ void __init spear_setup_timer(void)
> ? ? ? ?}
>
> ? ? ? ?gpt_clk = clk_get_sys("gpt0", NULL);
> - ? ? ? if (!gpt_clk) {
> + ? ? ? if (IS_ERR(gpt_clk)) {
> ? ? ? ? ? ? ? ?pr_err("%s:couldn't get clk for gpt\n", __func__);
> ? ? ? ? ? ? ? ?goto err_iomap;
> ? ? ? ?}
>
> ? ? ? ?pll3_clk = clk_get(NULL, "pll3_48m_clk");
> - ? ? ? if (!pll3_clk) {
> + ? ? ? if (IS_ERR(pll3_clk)) {
> ? ? ? ? ? ? ? ?pr_err("%s:couldn't get PLL3 as parent for gpt\n", __func__);
> ? ? ? ? ? ? ? ?goto err_iomap;
> ? ? ? ?}

Compiled & tested.

Acked-by: Viresh Kumar <viresh.kumar@st.com>
