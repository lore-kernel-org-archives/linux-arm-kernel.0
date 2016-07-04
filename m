From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 4 Jul 2016 09:33:59 -0600
Subject: [PATCH 1/2] coresight-etm3x: Add ARM ETM-A5 peripheral ID
In-Reply-To: <1467383831-6985-1-git-send-email-olivier.schonken@gmail.com>
References: <1467383831-6985-1-git-send-email-olivier.schonken@gmail.com>
Message-ID: <CANLsYkzvEPMi=BYDNa6WjtSPzz+SVm3zOkPsB1FhufbWaF4g8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 July 2016 at 08:37, Olivier Schonken <olivier.schonken@gmail.com> wrote:
> Signed-off-by: Olivier Schonken <olivier.schonken@gmail.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm3x.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
> index d83ab82..2c6d4b4 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x.c
> @@ -885,6 +885,11 @@ static struct amba_id etm_ids[] = {
>                 .mask   = 0x0003ffff,
>                 .data   = "ETM 3.3",
>         },
> +       {       /* ETM-A5 */
> +               .id     = 0x0003b955,
> +               .mask   = 0x0003ffff,
> +               .data   = "ETM-A5",
> +       },

Hello,

>From what I see in the documentation A5 and A7 processors have the
same ETM engine.  As such the comment above should be "ETM 3.5 -
Cortex-A5" and the .data field "ETM 3.5".  Get back to me if this
really doesn't mach your architecture.

Thanks,
Mathieu

>         {       /* ETM 3.5 */
>                 .id     = 0x0003b956,
>                 .mask   = 0x0003ffff,
> --
> 1.9.1
>
