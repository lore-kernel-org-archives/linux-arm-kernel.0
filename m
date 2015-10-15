From: robh@kernel.org (Rob Herring)
Date: Thu, 15 Oct 2015 08:47:20 -0500
Subject: [PATCH] of/irq: export of_irq_count
In-Reply-To: <1444905402-10510-1-git-send-email-zhangfei.gao@linaro.org>
References: <1444905402-10510-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <CAL_JsqJmdLQq9a4P3ZLurjcDBhnbS8LcuLdy0MyPR49DV+3dgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2015 at 5:36 AM, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
> Export of_irq_count, otherwise module build fail if of_irq_count is used

Which module?

>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/of/irq.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index 0c7f4cbe3434..0d149cc48cfe 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -448,6 +448,7 @@ int of_irq_count(struct device_node *dev)
>
>         return nr;
>  }
> +EXPORT_SYMBOL_GPL(of_irq_count);
>
>  /**
>   * of_irq_to_resource_table - Fill in resource table with node's IRQ info
> --
> 1.9.1
>
