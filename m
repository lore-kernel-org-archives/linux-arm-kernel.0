From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Thu, 22 Nov 2012 03:47:31 +0100
Subject: [PATCH v5 4/5] iommu/omap: adapt to runtime pm
In-Reply-To: <1353373552-16039-5-git-send-email-omar.luna@linaro.org>
References: <1353373552-16039-1-git-send-email-omar.luna@linaro.org>
 <1353373552-16039-5-git-send-email-omar.luna@linaro.org>
Message-ID: <CAMP44s0h+6XTaJv8q-MJe4vmDiBzNG2cjTugSn7nFyAsZPk+Ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 2:05 AM, Omar Ramirez Luna <omar.luna@linaro.org> wrote:

> @@ -1022,7 +1019,8 @@ static int __devexit omap_iommu_remove(struct platform_device *pdev)
>         release_mem_region(res->start, resource_size(res));
>         iounmap(obj->regbase);
>
> -       clk_put(obj->clk);
> +       pm_runtime_disable(obj->dev);
> +
>         dev_info(&pdev->dev, "%s removed\n", obj->name);
>         kfree(obj);
>         return 0;

I still believe this is not needed. The device framework does that
when removing the device, and does it more properly, with
__pm_runtime_disable(dev, false).

Cheers.

-- 
Felipe Contreras
