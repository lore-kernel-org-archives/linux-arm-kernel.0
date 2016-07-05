From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 5 Jul 2016 10:44:54 -0600
Subject: [PATCH 2/2] hwtracing: coresight: of_coresight: add missing
 of_node_put after calling of_parse_phandle
In-Reply-To: <1467684664-21155-2-git-send-email-peter.chen@nxp.com>
References: <1467684664-21155-1-git-send-email-peter.chen@nxp.com>
 <1467684664-21155-2-git-send-email-peter.chen@nxp.com>
Message-ID: <CANLsYkygHUFvGknfpjAS5bk_=pOSoskjEgrJU3ngTj-ivHLs0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 July 2016 at 20:11, Peter Chen <peter.chen@nxp.com> wrote:
> of_node_put needs to be called when the device node which is got
> from of_parse_phandle has finished using.
>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Peter Chen <peter.chen@nxp.com>
> ---
>  drivers/hwtracing/coresight/of_coresight.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
> index b68da18..b693a4b 100644
> --- a/drivers/hwtracing/coresight/of_coresight.c
> +++ b/drivers/hwtracing/coresight/of_coresight.c
> @@ -184,6 +184,7 @@ struct coresight_platform_data *of_get_coresight_platform_data(
>                         break;
>                 }
>         }
> +       of_node_put(dn);
>
>         return pdata;
>  }
> --
> 1.9.1
>

Applied - thanks.
Mathieu
