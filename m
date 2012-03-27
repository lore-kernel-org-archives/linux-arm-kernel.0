From: mturquette@ti.com (Turquette, Mike)
Date: Tue, 27 Mar 2012 16:31:17 -0700
Subject: [PATCH 01/10] clk: use kzalloc in clk_register_mux
In-Reply-To: <1332833009-4121-2-git-send-email-shawn.guo@linaro.org>
References: <1332833009-4121-1-git-send-email-shawn.guo@linaro.org>
 <1332833009-4121-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <CAJOA=zOGdjZ_-U8AuDJG2k8SRCfcf=8aUg__+A-fWSz4FOSStA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2012 at 12:23 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> Change clk_register_mux to use kzalloc, just like what all other basic
> clk registration functions do.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Thanks for the patch.  Will take into my fixes branch.

Regards,
Mike

> ---
> ?drivers/clk/clk-mux.c | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
> index c71ad1f..50e0595 100644
> --- a/drivers/clk/clk-mux.c
> +++ b/drivers/clk/clk-mux.c
> @@ -97,7 +97,7 @@ struct clk *clk_register_mux(struct device *dev, const char *name,
> ?{
> ? ? ? ?struct clk_mux *mux;
>
> - ? ? ? mux = kmalloc(sizeof(struct clk_mux), GFP_KERNEL);
> + ? ? ? mux = kzalloc(sizeof(struct clk_mux), GFP_KERNEL);
>
> ? ? ? ?if (!mux) {
> ? ? ? ? ? ? ? ?pr_err("%s: could not allocate mux clk\n", __func__);
> --
> 1.7.5.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
