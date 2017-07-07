From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 7 Jul 2017 09:28:58 -0600
Subject: [PATCH] hwtracing: coresight: constify attribute_group structures.
In-Reply-To: <97ff1c3f7145b0e4326fbbb246579cd5382880b3.1499233557.git.arvind.yadav.cs@gmail.com>
References: <97ff1c3f7145b0e4326fbbb246579cd5382880b3.1499233557.git.arvind.yadav.cs@gmail.com>
Message-ID: <CANLsYkxrT+d-HLpPAOM_pZVWfDgTU92Q-njo_0e=K-auYL=BYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 July 2017 at 23:49, Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
> attribute_groups are not supposed to change at runtime. All functions
> working with attribute_groups provided by <linux/sysfs.h> work with const
> attribute_group. So mark the non-const structs as const.
>
> File size before:
>   text     data     bss     dec     hex filename
>    2573     288     296    3157     c55 coresight-etm-perf.o
>
> File size After adding 'const':
>    text    data     bss     dec     hex filename
>    2613     224     296    3133     c3d coresight-etm-perf.o

Hi Arvind,

Did you find this using an automated tool or simply stumbled on it
while reviewing the code?  In case of the former it is usually a good
idea to specify which tool was used in the change log.

Thanks,
Mathieu

>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm-perf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index 288a423..e97775d 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -60,7 +60,7 @@ struct etm_event_data {
>         NULL,
>  };
>
> -static struct attribute_group etm_pmu_format_group = {
> +static const struct attribute_group etm_pmu_format_group = {
>         .name   = "format",
>         .attrs  = etm_config_formats_attr,
>  };
> --
> 1.9.1
>
