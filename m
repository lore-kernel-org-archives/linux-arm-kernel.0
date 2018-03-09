From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 9 Mar 2018 09:29:36 +0800
Subject: [PATCH v4 3/3] driver: clocksource: add gpt timer for imx6sll
In-Reply-To: <1520501697-22202-3-git-send-email-ping.bai@nxp.com>
References: <1520501697-22202-1-git-send-email-ping.bai@nxp.com>
 <1520501697-22202-3-git-send-email-ping.bai@nxp.com>
Message-ID: <20180309012934.GC3217@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 08, 2018 at 05:34:57PM +0800, Bai Ping wrote:
> Add gpt timer support for i.MX6SLL.
> 
> Signed-off-by: Bai Ping <ping.bai@nxp.com>

The patch should be sent to clocksource maintainer.

> ---
> change v1->v2:
>  - no
> change v2->v3:
>  - no
> change v3->v4:
>  - no
> ---
>  drivers/clocksource/timer-imx-gpt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clocksource/timer-imx-gpt.c b/drivers/clocksource/timer-imx-gpt.c
> index 6ec6d79..57b7eab 100644
> --- a/drivers/clocksource/timer-imx-gpt.c
> +++ b/drivers/clocksource/timer-imx-gpt.c
> @@ -557,3 +557,4 @@ static int __init imx6dl_timer_init_dt(struct device_node *np)
>  TIMER_OF_DECLARE(imx6dl_timer, "fsl,imx6dl-gpt", imx6dl_timer_init_dt);
>  TIMER_OF_DECLARE(imx6sl_timer, "fsl,imx6sl-gpt", imx6dl_timer_init_dt);
>  TIMER_OF_DECLARE(imx6sx_timer, "fsl,imx6sx-gpt", imx6dl_timer_init_dt);
> +TIMER_OF_DECLARE(imx6sll_timer, "fsl,imx6sll-gpt", imx6dl_timer_init_dt);

I'm wondering if we can save this change by letting the compatible of
imx6sll-gpt fall on "fsl,imx6dl-gpt" in DT.

Shawn
