From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 7 Mar 2018 14:38:26 -0700
Subject: [PATCH] coresight: use %px to print pcsr instead of %p
In-Reply-To: <1520050981-17129-1-git-send-email-leo.yan@linaro.org>
References: <1520050981-17129-1-git-send-email-leo.yan@linaro.org>
Message-ID: <CANLsYkxna9Myejt0x6o5A4xRz-12x5grAOUOu2PGyZgNehAJnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 March 2018 at 21:23, Leo Yan <leo.yan@linaro.org> wrote:
> Commit ad67b74d2469 ("printk: hash addresses printed with %p") lets
> printk specifier %p to hash all addresses before printing, this was
> resulting in the high 32 bits of pcsr can only output zeros.  So
> module cannot completely print pc value and it's pointless for debugging
> purpose.
>
> This patch fixes this by using %px to print pcsr instead.
>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-cpu-debug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> index 6ea62c6..9cdb3fb 100644
> --- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
> +++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> @@ -315,7 +315,7 @@ static void debug_dump_regs(struct debug_drvdata *drvdata)
>         }
>
>         pc = debug_adjust_pc(drvdata);
> -       dev_emerg(dev, " EDPCSR:  [<%p>] %pS\n", (void *)pc, (void *)pc);
> +       dev_emerg(dev, " EDPCSR:  [<%px>] %pS\n", (void *)pc, (void *)pc);
>
>         if (drvdata->edcidsr_present)
>                 dev_emerg(dev, " EDCIDSR: %08x\n", drvdata->edcidsr);

Applied - thanks
Mathieu

> --
> 2.7.4
>
