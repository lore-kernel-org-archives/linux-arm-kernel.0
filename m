From: mgr@pengutronix.de (Michael Grzeschik)
Date: Thu, 15 Nov 2012 11:25:25 +0100
Subject: [PATCH 6/6] usb: chipidea: usbmisc: add post handling and
 errata fix for mx25
In-Reply-To: <CALBypN6U=np93ZwnEZqbh=j0Vb_-x630GaktEiv+4K26eYp4Pg@mail.gmail.com>
References: <1352894137-2050-1-git-send-email-m.grzeschik@pengutronix.de>
 <1352894137-2050-7-git-send-email-m.grzeschik@pengutronix.de>
 <CALBypN6U=np93ZwnEZqbh=j0Vb_-x630GaktEiv+4K26eYp4Pg@mail.gmail.com>
Message-ID: <20121115102525.GA16118@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2012 at 11:08:15AM +0100, Martin Fuzzey wrote:
> On Wed, Nov 14, 2012 at 12:55 PM, Michael Grzeschik
> <m.grzeschik@pengutronix.de> wrote:
> > @@ -213,6 +216,15 @@ static int __devinit ci13xxx_imx_probe(struct platform_device *pdev)
> >                 goto put_np;
> >         }
> >
> > +       if (usbmisc_ops && usbmisc_ops->post) {
> > +               ret = usbmisc_ops->post(&pdev->dev);
> > +               if (ret) {
> > +                       dev_err(&pdev->dev,
> > +                               "usbmisc post failed, ret=%d\n", ret);
> > +                       goto err;
> > +               }
> > +       }
> > +
> >         data->ci_pdev = plat_ci;
> >         platform_set_drvdata(pdev, data);
> >
> This hunk fails to apply for me on 3.7-rc5:
> error: while searching for:
> 		goto put_np;
> 	}

This is because that series is based on Peter Chen's work. I should have
mentioned this in the cover-letter mail. You can merge his master branch
before adding my series:
https://github.com/hzpeterchen/linux-usb.git

Apart from the latter patches, his work already got queued up by Greg:
http://comments.gmane.org/gmane.linux.usb.general/74537

Thanks,
Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
