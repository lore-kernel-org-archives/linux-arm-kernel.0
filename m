From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Wed, 8 Aug 2018 20:50:58 +0300
Subject: [PATCH 14/28] net: split eth_platform_get_mac_address() into
 subroutines
In-Reply-To: <20180808153150.23444-15-brgl@bgdev.pl>
References: <20180808153150.23444-1-brgl@bgdev.pl>
 <20180808153150.23444-15-brgl@bgdev.pl>
Message-ID: <CAHp75VfxVOPzAtBgTe4RSax1Ki+323WDBTSmh=j7LV_c+vsXDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 8, 2018 at 6:31 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> We want do add more sources from which to read the MAC address. In
> order to avoid bloating this function too much, start by splitting it
> into subroutines, each of which takes care of reading the MAC from
> one source.

> +static int mac_address_from_of(struct device *dev, u8 *mac_addr)
>  {
>         const unsigned char *addr;
> +       struct device_node *np;
>

> +       np = dev_is_pci(dev) ? pci_device_to_OF_node(to_pci_dev(dev))
> +                            : dev->of_node;

I didn't get these manipulations.

What the scenario when pci_dev->dev.of_node != dev->of_node?

-- 
With Best Regards,
Andy Shevchenko
