From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Thu, 1 Mar 2018 20:32:21 +0200
Subject: [PATCH v4 2/2] i2c: add support for Socionext SynQuacer I2C
 controller
In-Reply-To: <20180301163815.30595-3-ard.biesheuvel@linaro.org>
References: <20180301163815.30595-1-ard.biesheuvel@linaro.org>
 <20180301163815.30595-3-ard.biesheuvel@linaro.org>
Message-ID: <CAHp75VcJ4+4-yCm6sKf+Q80FwRMjkjSGMZd5X3hecHQZ9nV7Rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 1, 2018 at 6:38 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> This is a cleaned up version of the I2C controller driver for
> the Fujitsu F_I2C IP, which was never supported upstream, and
> has now been incorporated into the Socionext SynQuacer SoC.

> +static int synquacer_i2c_remove(struct platform_device *pdev)
> +{
> +       struct synquacer_i2c *i2c = platform_get_drvdata(pdev);
> +

> +       platform_set_drvdata(pdev, NULL);

Just noticed, this is redundant for many years since driver core does
it for every device on removal.

It can be fixed by followup though.

> +       i2c_del_adapter(&i2c->adapter);
> +       if (!IS_ERR(i2c->pclk))
> +               clk_disable_unprepare(i2c->pclk);
> +
> +       return 0;
> +};

-- 
With Best Regards,
Andy Shevchenko
