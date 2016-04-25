From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 25 Apr 2016 17:07:48 -0600
Subject: [PATCH] coresight: etm4x: Add DT implementation.
In-Reply-To: <1461401148-188382-1-git-send-email-lipengcheng8@huawei.com>
References: <1461401148-188382-1-git-send-email-lipengcheng8@huawei.com>
Message-ID: <CANLsYkwL-7bWEN6Suehgg8hBT5tLCRxHieGUwDe+vdgko0yt5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 April 2016 at 02:45, lipengcheng <lipengcheng8@huawei.com> wrote:
> Add DT implementation for A72 board.

This patch has nothing to do with the device tree...  You are adding
the a cell ID for the CS ETMv4 found on the Maia processor.

>
> Signed-off-by: Li Pengcheng <lipengcheng8@huawei.com>
> Signed-off-by: Li Zhong <lizhong11@hisilicon.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index 6396b28..462f0dc 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -825,6 +825,11 @@ static struct amba_id etm4_ids[] = {
>                 .mask   = 0x000fffff,
>                 .data   = "ETM 4.0",
>         },
> +       {       /* ETM 4.0 - A72, Maia, HiSilicon */
> +               .id = 0x000bb95a,
> +               .mask = 0x000fffff,
> +               .data = "ETM 4.0",
> +       },
>         { 0, 0},
>  };

Applied, with a modified subject and commit log description.

Thanks,
Mathieu
>
> --
> 1.8.3.2
>
