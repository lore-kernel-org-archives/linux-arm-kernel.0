From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 30 Jun 2014 10:47:12 +0100
Subject: [PATCH v7 3/6] input: misc: Add driver for AXP20x Power Enable Key
In-Reply-To: <1404066237-20234-4-git-send-email-carlo@caione.org>
References: <1404066237-20234-1-git-send-email-carlo@caione.org>
 <1404066237-20234-4-git-send-email-carlo@caione.org>
Message-ID: <20140630094712.GX7262@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 29, 2014 at 07:23:54PM +0100, Carlo Caione wrote:
> This patch add support for the Power Enable Key found on MFD AXP202 and
> AXP209. Besides the basic support for the button, the driver adds two
> entries in sysfs to configure the time delay for power on/off.
> 
> Signed-off-by: Carlo Caione <carlo@caione.org>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/misc/Kconfig      |  11 ++
>  drivers/input/misc/Makefile     |   1 +
>  drivers/input/misc/axp20x-pek.c | 281 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 293 insertions(+)
>  create mode 100644 drivers/input/misc/axp20x-pek.c

[...]

> +static int axp20x_pek_probe(struct platform_device *pdev)
> +{
> +       struct axp20x_pek *axp20x_pek;
> +       struct axp20x_dev *axp20x;
> +       struct input_dev *idev;
> +       int error;
> +
> +       axp20x_pek = devm_kzalloc(&pdev->dev, sizeof(struct axp20x_pek),
> +                                 GFP_KERNEL);

You can use sizeof(*axp20x_pek) here.

[...]

> +static struct platform_driver axp20x_pek_driver = {
> +       .probe          = axp20x_pek_probe,
> +       .remove         = axp20x_pek_remove,
> +       .driver         = {
> +               .name           = "axp20x-pek",
> +               .owner          = THIS_MODULE,
> +       },
> +};
> +module_platform_driver(axp20x_pek_driver);

So this requires platform data rather than a DTB? Or have I missed
something?

Thanks,
Mark.
