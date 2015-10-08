From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Thu, 8 Oct 2015 09:47:57 +0200
Subject: [PATCH 4/8] regulator: Hi655x: Add support for Hi655x regulator
In-Reply-To: <1443611111-3196-5-git-send-email-w.f@huawei.com>
References: <1443611111-3196-1-git-send-email-w.f@huawei.com>
 <1443611111-3196-5-git-send-email-w.f@huawei.com>
Message-ID: <CABxcv=kRJPxJiOvqsX_cSJzbew0-_-4Y_q_bQioOdknLbKkZ1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Fei Wang,

On Wed, Sep 30, 2015 at 1:05 PM, Fei Wang <w.f@huawei.com> wrote:
> Add Hi655x regulator driver.
>
> Signed-off-by: Fei Wang <w.f@huawei.com>
> ---

[snip]

>
> +config REGULATOR_HI655X
> +        tristate "Hisilicon HI655X PMIC regulators support"

The Kconfig symbol is tree state which means it can be built as a module...

> +
> +static const struct of_device_id of_hi655x_regulator_match_tbl[] = {
> +       {
> +               .compatible = "hisilicon,hi655x-regulator-pmic",
> +               .data = &hi655x_regulator_pmic,
> +       },
> +       { /* end */ }
> +};

...but the OF module alias information is not built into the module so
module autoloading won't work.

Please add a MODULE_DEVICE_TABLE(of, of_hi655x_regulator_match_tbl) here.

Best regards,
Javier
