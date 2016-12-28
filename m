From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 28 Dec 2016 21:38:05 +0100
Subject: [PATCH v1] watchdog: imx2: fix hang-up on boot for i.MX21,
 i.MX27 and i.MX31 SoCs
In-Reply-To: <CAOMZO5CqpfH6nq_mqPitztfSX4-oR4-61z7PnYhvOYAVnYF0yA@mail.gmail.com>
References: <20161211010648.6591-1-vz@mleia.com>
 <CAOMZO5CqpfH6nq_mqPitztfSX4-oR4-61z7PnYhvOYAVnYF0yA@mail.gmail.com>
Message-ID: <20161228203805.26urb7hzpb5kgigr@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 24, 2016 at 11:00:59AM -0200, Fabio Estevam wrote:
> On Sat, Dec 10, 2016 at 11:06 PM, Vladimir Zapolskiy <vz@mleia.com> wrote:
> 
> >  static const struct of_device_id imx2_wdt_dt_ids[] = {
> > -       { .compatible = "fsl,imx21-wdt", },
> > +       { .compatible = "fsl,imx21-wdt", .data = IMX2_WDT_NO_WMCR },
> > +       { .compatible = "fsl,imx25-wdt",  },
> > +       { .compatible = "fsl,imx27-wdt", .data = IMX2_WDT_NO_WMCR },
> > +       { .compatible = "fsl,imx31-wdt", .data = IMX2_WDT_NO_WMCR },
> > +       { .compatible = "fsl,imx35-wdt",  },
> > +       { .compatible = "fsl,imx50-wdt",  },
> > +       { .compatible = "fsl,imx51-wdt",  },
> > +       { .compatible = "fsl,imx53-wdt",  },
> > +       { .compatible = "fsl,imx6q-wdt",  },
> > +       { .compatible = "fsl,imx6sl-wdt", },
> > +       { .compatible = "fsl,imx6sx-wdt", },
> > +       { .compatible = "fsl,imx6ul-wdt", },
> > +       { .compatible = "fsl,imx7d-wdt",  },
> > +       { .compatible = "fsl,vf610-wdt",  },
> >         { /* sentinel */ }
> 
> I understand this compatible list is not very nice, but in order to
> keep old dtb's working I don't see a better solution, so:
> 
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

You can at least drop fsl,imx27-wdt and fsl,imx31-wdt which then fall
back correctly to fsl,imx21-wdt.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
