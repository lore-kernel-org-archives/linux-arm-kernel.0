From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 6 Jun 2018 13:10:29 -0600
Subject: [PATCH] coresight: Fix check in
 coresight_tmc_etr_buf_insert_barrier_packet
In-Reply-To: <1527851302-5843-1-git-send-email-suzuki.poulose@arm.com>
References: <1527851302-5843-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <CANLsYkyhJFrNtc7PDY0XNQoiHW8sHW+kJiaUPoWqPwCZM-R_Tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 June 2018 at 05:08, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> We request for "CORESIGHT_BARRIER_PKT_SIZE" length and we should
> be happy when we get that size.
>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>
> Mathieu,
>
> Please could you pull this patch, if you are happy with it ?
> This fixes a problem in the ETR buf series, which I just
> noticed while testing the part2 of the series.

I will pick up the change - you will see it being queued when the
first rc comes out.

>
> Suzuki
> ---
>  drivers/hwtracing/coresight/coresight-tmc-etr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index e2bcef3..c736250 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -862,7 +862,7 @@ tmc_etr_buf_insert_barrier_packet(struct etr_buf *etr_buf, u64 offset)
>
>         len = tmc_etr_buf_get_data(etr_buf, offset,
>                                    CORESIGHT_BARRIER_PKT_SIZE, &bufp);
> -       if (WARN_ON(len <= CORESIGHT_BARRIER_PKT_SIZE))
> +       if (WARN_ON(len < CORESIGHT_BARRIER_PKT_SIZE))
>                 return -EINVAL;
>         coresight_insert_barrier_packet(bufp);
>         return offset + CORESIGHT_BARRIER_PKT_SIZE;
> --
> 2.7.4
>
