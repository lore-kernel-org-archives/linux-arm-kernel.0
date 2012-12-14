From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 13 Dec 2012 23:58:59 -0200
Subject: [PATCH 2/3 V2] iio: mxs: Implement support for touchscreen
In-Reply-To: <1355449598-15980-2-git-send-email-marex@denx.de>
References: <1355449598-15980-1-git-send-email-marex@denx.de>
 <1355449598-15980-2-git-send-email-marex@denx.de>
Message-ID: <CAOMZO5DDcPpePEiJe0hg0Er60OBuJM+Rik1CSc9zcphycpEr4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Thu, Dec 13, 2012 at 11:46 PM, Marek Vasut <marex@denx.de> wrote:

> +static int mxs_lradc_ts_register(struct mxs_lradc *lradc)
> +{
> +       struct input_dev *input;
> +       struct device *dev = lradc->dev;
> +       int ret;
> +
> +       if (!lradc->use_touchscreen)
> +               return 0;

Shouldn't we return an error code here?

> +
> +       input = input_allocate_device();
> +       if (!input) {
> +               dev_warn(dev, "Failed to allocate TS device, disabling.\n");
> +               lradc->use_touchscreen = MXS_LRADC_TOUCHSCREEN_NONE;
> +               return 0;
> +       }

Shouldn't we return an error code here?

Regards,

Fabio Estevam
