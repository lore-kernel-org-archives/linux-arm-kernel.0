From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Wed, 8 Aug 2018 20:42:42 +0300
Subject: [PATCH 04/28] nvmem: provide nvmem_device_name()
In-Reply-To: <20180808153150.23444-5-brgl@bgdev.pl>
References: <20180808153150.23444-1-brgl@bgdev.pl>
 <20180808153150.23444-5-brgl@bgdev.pl>
Message-ID: <CAHp75Ve6ugVGJ9JqCYri0_k93DgkPMua7g8dC5CMhT4uFHMgoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 8, 2018 at 6:31 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Kernel users don't have any means of checking the names of nvmem
> devices. Add a routine that returns the name of the nvmem provider.
>
> This will be useful for nvmem notifier subscribers - otherwise they
> can't check what device is being added/removed.

> +const char *nvmem_device_name(struct nvmem_device *nvmem)
> +{
> +       return dev_name(&nvmem->dev);
> +}
> +EXPORT_SYMBOL_GPL(nvmem_device_name);

Just wondering if *_dev_name() is more common pattern in the kernel
(at least pci_dev_name() comes immediately to mind).


-- 
With Best Regards,
Andy Shevchenko
