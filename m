From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Sat, 19 May 2018 00:21:14 +0300
Subject: [PATCH 5/6] mtd: rawnand: ams-delta: use GPIO lookup table
In-Reply-To: <20180518210954.29044-5-jmkrzyszt@gmail.com>
References: <20180518210954.29044-1-jmkrzyszt@gmail.com>
 <20180518210954.29044-5-jmkrzyszt@gmail.com>
Message-ID: <CAHp75VdNUW6KoM6oupyQ80A1WVRk7vewwDt6WEZOyjrAUifqRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 19, 2018 at 12:09 AM, Janusz Krzysztofik
<jmkrzyszt@gmail.com> wrote:

> +       gpiod_rdy = devm_gpiod_get_optional(&pdev->dev, "rdy", GPIOD_IN);
> +       if (!IS_ERR_OR_NULL(gpiod_rdy)) {

So, is it optional or not at the end?
If it is, why do we check for NULL?

>                 this->dev_ready = ams_delta_nand_ready;
>         } else {
>                 this->dev_ready = NULL;
>                 pr_notice("Couldn't request gpio for Delta NAND ready.\n");

dev_notice() ?

>         }

> +err_gpiod:
> +       if (err == -ENODEV || err == -ENOENT)
> +               err = -EPROBE_DEFER;

Hmm...

-- 
With Best Regards,
Andy Shevchenko
