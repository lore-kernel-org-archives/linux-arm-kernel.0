From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Wed, 16 May 2018 12:16:28 +0300
Subject: [PATCH 1/4] amba: Export amba_bustype
In-Reply-To: <20180508140628.f30774c70c4c481bff3f8000@arm.com>
References: <20180508140628.f30774c70c4c481bff3f8000@arm.com>
Message-ID: <CAHp75VfGpS_QkLj4XM8uHW0BAJV0EBWZ_yLP0R2D+ok4Mt=SQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 8, 2018 at 10:06 PM, Kim Phillips <kim.phillips@arm.com> wrote:
> This patch is provided in the context of allowing the Coresight driver
> subsystem to be loaded as modules.  Coresight uses amba_bus in its call
> to bus_find_device() in of_coresight_get_endpoint_device() when
> searching for a configurable endpoint device.  This patch allows
> Coresight to reference amba_bustype when built as a module.

> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -197,6 +197,7 @@ struct bus_type amba_bustype = {
>         .pm             = &amba_pm,
>         .force_dma      = true,
>  };
> +EXPORT_SYMBOL_GPL(amba_bustype);

Oh,

What wrong with the approach let's say similar to PCI bus?

Whenever you have a struct device you may use two helpers:

dev_is_pci() -> is the device of PCI bus type?
to_pci_dev() -> get's container of struct device for PCI bus case

-- 
With Best Regards,
Andy Shevchenko
