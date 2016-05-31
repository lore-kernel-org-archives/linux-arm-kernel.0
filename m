From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 31 May 2016 12:01:23 -0600
Subject: [PATCH 5/5] coresight: Cleanup TMC status check
In-Reply-To: <1464695858-29284-6-git-send-email-suzuki.poulose@arm.com>
References: <1464695858-29284-1-git-send-email-suzuki.poulose@arm.com>
 <1464695858-29284-6-git-send-email-suzuki.poulose@arm.com>
Message-ID: <CANLsYkzcHxQ7k_iwwW0XDE5MutkpaCz63T1bkrcp7Kp9t0QSLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 May 2016 at 05:57, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> Use the defined symbol rather than hardcoding the value to
> check whether the TMC buffer is full.
>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-tmc-etr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 847d1b5..b0dce93 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -65,7 +65,7 @@ static void tmc_etr_dump_hw(struct tmc_drvdata *drvdata)
>         val = readl_relaxed(drvdata->base + TMC_STS);
>
>         /* How much memory do we still have */
> -       if (val & BIT(0))
> +       if (val & TMC_STS_FULL)
>                 drvdata->buf = drvdata->vaddr + rwp - drvdata->paddr;
>         else
>                 drvdata->buf = drvdata->vaddr;
> --
> 1.9.1
>

Applied - thanks.
Mathieu
