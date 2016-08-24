From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 24 Aug 2016 15:32:07 +0200
Subject: [PATCH 2/2] reset: uniphier: use of_device_get_match_data() to
 get matched data
In-Reply-To: <CAK7LNASCtZNMdSO33z5K1jPac_DPTnt3aUaC+CCNrrUdm_hq9w@mail.gmail.com>
References: <1472020830-16059-1-git-send-email-yamada.masahiro@socionext.com>
 <1472020830-16059-3-git-send-email-yamada.masahiro@socionext.com>
 <1472041622.5335.32.camel@pengutronix.de>
 <CAK7LNASCtZNMdSO33z5K1jPac_DPTnt3aUaC+CCNrrUdm_hq9w@mail.gmail.com>
Message-ID: <1472045527.5335.46.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 24.08.2016, 21:29 +0900 schrieb Masahiro Yamada:
[...]
> >> @@ -285,6 +286,45 @@ static const struct reset_control_ops uniphier_reset_ops = {
> >>       .status = uniphier_reset_status,
> >>  };
> >>
> >> +static int uniphier_reset_probe(struct platform_device *pdev)
> >> +{
> >> +     struct device *dev = &pdev->dev;
> >> +     struct uniphier_reset_priv *priv;
> >> +     const struct uniphier_reset_data *p, *data;
> >> +     struct regmap *regmap;
> >> +     struct device_node *parent;
> >> +     unsigned int nr_resets = 0;
> >> +
> >> +     data = of_device_get_match_data(dev);
> >> +     WARN_ON(!data);
> >
> > I know right now this can't happen anyway, but you did return -EINVAL
> > here before. Maybe use:
> >
> >         if (WARN_ON(!data))
> >                 return -EINVAL;
> >
> > instead? I can fix it up if you agree.
> 
> I agree.
> 
> Please fix it up.  Thanks!

Ok, done.

regards
Philipp
