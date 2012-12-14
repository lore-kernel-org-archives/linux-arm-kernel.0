From: marex@denx.de (Marek Vasut)
Date: Fri, 14 Dec 2012 03:04:43 +0100
Subject: [PATCH 2/3 V2] iio: mxs: Implement support for touchscreen
In-Reply-To: <CAOMZO5DDcPpePEiJe0hg0Er60OBuJM+Rik1CSc9zcphycpEr4g@mail.gmail.com>
References: <1355449598-15980-1-git-send-email-marex@denx.de>
 <1355449598-15980-2-git-send-email-marex@denx.de>
 <CAOMZO5DDcPpePEiJe0hg0Er60OBuJM+Rik1CSc9zcphycpEr4g@mail.gmail.com>
Message-ID: <201212140304.43291.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Fabio Estevam,

> Hi Marek,
> 
> On Thu, Dec 13, 2012 at 11:46 PM, Marek Vasut <marex@denx.de> wrote:
> > +static int mxs_lradc_ts_register(struct mxs_lradc *lradc)
> > +{
> > +       struct input_dev *input;
> > +       struct device *dev = lradc->dev;
> > +       int ret;
> > +
> > +       if (!lradc->use_touchscreen)
> > +               return 0;
> 
> Shouldn't we return an error code here?

No, why ? No touchscreen present, we register nothing.

> > +
> > +       input = input_allocate_device();
> > +       if (!input) {
> > +               dev_warn(dev, "Failed to allocate TS device,
> > disabling.\n"); +               lradc->use_touchscreen =
> > MXS_LRADC_TOUCHSCREEN_NONE; +               return 0;
> > +       }
> 
> Shouldn't we return an error code here?

Yes.

> Regards,
> 
> Fabio Estevam

Best regards,
Marek Vasut
