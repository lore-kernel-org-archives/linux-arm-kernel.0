From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 15 Feb 2017 17:52:56 +0100
Subject: [PATCH 10/14] phy: meson8b-usb2: simplify optional reset handling
In-Reply-To: <1487177007.30202.1.camel@baylibre.com>
References: <20170130114116.22089-1-p.zabel@pengutronix.de>
 <20170130114116.22089-10-p.zabel@pengutronix.de>
 <CAFBinCAASGS19naW76vfynRj4Fg4KjpHcwGr5h+pWZae47rwRg@mail.gmail.com>
 <1487177007.30202.1.camel@baylibre.com>
Message-ID: <1487177576.2433.45.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jerome,

On Wed, 2017-02-15 at 17:43 +0100, Jerome Brunet wrote:
[...]
> > > @@ -241,7 +239,7 @@ static int phy_meson8b_usb2_probe(struct
> > > platform_device *pdev)
> > >                 return PTR_ERR(priv->clk_usb);
> > > 
> > >         priv->reset = devm_reset_control_get_optional_shared(&pdev-
> > > >dev, NULL);
> > > -       if (PTR_ERR(priv->reset) == -EPROBE_DEFER)
> > > +       if (PTR_ERR(priv->reset))
> 
> This is wrong and will always exit on error. It should be "IS_ERR".
> Clearly the bug was there before your patch, but since you are changing
> the faulty line, would you mind using IS_ERR instead ?
> 
> With this changed:
> Tested-by: Jerome Brunet <jbrunet@baylibre.com>

Thanks for catching this, I should have changed this to IS_ERR when
removing the error value comparison.

regards
Philipp
