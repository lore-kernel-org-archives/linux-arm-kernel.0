From: coelho@ti.com (Luciano Coelho)
Date: Thu, 4 Jul 2013 23:45:27 +0300
Subject: [PATCH RESEND] clk: export __clk_get_flags for modular clock
 providers
In-Reply-To: <1366009186-32199-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1366009186-32199-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <51D5DEE7.2070400@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04/15/2013 09:59 AM, Sebastian Hesselbarth wrote:
> The common clock api provides some helpers for clk-providers but does
> not export these helpers. This hinders clk-providers to be built as modules.
> This patch adds __clk_get_flags() to the list of exported symbols.
>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>   drivers/clk/clk.c |    1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index ed87b24..3e478b8 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -450,6 +450,7 @@ unsigned long __clk_get_flags(struct clk *clk)
>   {
>   	return !clk ? 0 : clk->flags;
>   }
> +EXPORT_SYMBOL_GPL(__clk_get_flags);
>
>   bool __clk_is_enabled(struct clk *clk)
>   {
>

I think this got merged slightly wrong.  The EXPORT_SYMBOL_GPL macro 
came under clk_unprepare_unused_subtree() instead of under 
__clk_get_flags():


Of course this is not that important, but it's a bit confusing when you 
look at the code.

--
Cheers,
Luca.
