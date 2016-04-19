From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 19 Apr 2016 09:08:32 -0600
Subject: [PATCH] coresight: etm4x: Add DT implementation.
In-Reply-To: <1460968919-136371-1-git-send-email-lipengcheng8@huawei.com>
References: <1460968919-136371-1-git-send-email-lipengcheng8@huawei.com>
Message-ID: <CANLsYkzNM5wkmZ6+M_QUmj=ijdksrXiLrDBY0WPcH6v2s8vOVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 April 2016 at 02:41, lipengcheng <lipengcheng8@huawei.com> wrote:
> Add DT implementation for A72 and Atermis board.
>
> Signed-off-by: Li Pengcheng <lipengcheng8@huawei.com>
> Signed-off-by: Li Zhong <lizhong11@hisilicon.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index 6396b28..76bfad1 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -825,6 +825,16 @@ static struct amba_id etm4_ids[] = {
>                 .mask   = 0x000fffff,
>                 .data   = "ETM 4.0",
>         },
> +       {       /* ETM 4.0 - A72 board */
> +               .id = 0x000bb95a,
> +               .mask = 0x000fffff,
> +               .data = "ETM 4.0",
> +       },
> +       {       /* ETM 4.0 - Atermis board */
> +               .id = 0x000bb959,
> +               .mask = 0x000fffff,
> +               .data = "ETM 4.0",
> +       },
>         { 0, 0},
>  };

I'm good with this patch and have the intention of taking it.

On the flip side I would like a better description of the processor
the .id can be found on.  I think the current upstream code ("ETM 4.0
- Qualcomm" and "ETM 4.0 - Juno board") provides an insufficient
description and won't scale well.

>From here on the convention should be "ETM [rev] - [processor],
[processor name], [manufacturer]"

As such the above would become:

/* ETM 4.0 - A72, HSXYZ, HiSillicon */

Get back to me if you have questions.

Thanks,
Mathieu.



>
> --
> 1.8.3.2
>
