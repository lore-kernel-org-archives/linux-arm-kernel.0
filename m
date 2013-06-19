From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 19 Jun 2013 21:10:40 +0200
Subject: [PATCH v2 2/4] gpio: davinci: DT changes for driver
In-Reply-To: <1371205241-17205-3-git-send-email-avinashphilipk@gmail.com>
References: <1371203020-15092-1-git-send-email-avinashphilip@ti.com>
 <1371205241-17205-3-git-send-email-avinashphilipk@gmail.com>
Message-ID: <CACRpkdbJJVKC539CAPNxxEbofVfw3Pr0gyCSZyY9YbkXneE-qQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 12:20 PM, Philip Avinash
<avinashphilipk@gmail.com> wrote:

> From: KV Sujith <sujithkv@ti.com>
>
> - Add of_device_id for Davinci GPIO driver.
> - Add function to populate data from DT.
> - Modify the probe to read from DT if DT match is found.
> - Add DT binding documentation for Davinci GPIO properties in a new file
>   gpio-davinci.txt located at Documentation/devicetree/bindings/gpio/.
>
> Signed-off-by: KV Sujith <sujithkv@ti.com>
> Signed-off-by: Philip Avinash <avinashphilip@ti.com>
> ---
> Changes since v1:
>         - description for interrupts changed to reflecti
>            interrupt array usage.
(...)

> +static struct davinci_gpio_platform_data *davinci_gpio_set_pdata_of(
> +                                               struct platform_device *pdev)
> +{
> +       struct device_node *dn = pdev->dev.of_node;
> +       struct davinci_gpio_platform_data *pdata;
> +       u32 val, ret;
> +
> +       pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> +       if (pdata) {

Instead of this arrow pattern:

if (!pdata) {
  dev_err( ... "out of memory allocating platform data");
  return NULL;
}

And de-indent the rest.

With that change:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

I guess this may go through the DaVinci tree with the rest of the DaVinci
patches?

Yours,
Linus Walleij
