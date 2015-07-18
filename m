From: maitysanchayan@gmail.com (maitysanchayan at gmail.com)
Date: Sat, 18 Jul 2015 17:58:45 +0530
Subject: [PATCH v2 3/4] touchscreen: colibri-vf50-ts: Add touchscreen
 support for Colibri VF50
In-Reply-To: <CAH=tA9H56jP_GZBA7A3HER8w3WNtWbfkF5rWk3P0ERkQ9DpPpQ@mail.gmail.com>
References: <cover.1437058481.git.maitysanchayan@gmail.com>
 <26748bd9a7bde7c2304b6b971f1150bb575e4938.1437058481.git.maitysanchayan@gmail.com>
 <CAH=tA9H56jP_GZBA7A3HER8w3WNtWbfkF5rWk3P0ERkQ9DpPpQ@mail.gmail.com>
Message-ID: <20150718122845.GA1833@Sanchayan-Arch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15-07-18 14:03:25, Nicolae Rosia wrote:
> Hi,
> 
> On Thu, Jul 16, 2015 at 6:13 PM, Sanchayan Maity
> <maitysanchayan@gmail.com> wrote:
> > The Colibri Vybrid VF50 module supports 4-wire touchscreens using
> > FETs and ADC inputs. This driver uses the IIO consumer interface
> > and relies on the vf610_adc driver based on the IIO framework.
> >
> > Signed-off-by: Sanch
> > +static const struct of_device_id vf50_touch_of_match[] = {
> > +       { .compatible = "toradex,vf50-touchctrl", },
> > +       { }
> > +};
> > +MODULE_DEVICE_TABLE(of, vf50_touch_of_match);
> > +
> > +static struct platform_driver __refdata vf50_touch_driver = {
> > +       .driver = {
> > +               .name = "toradex,vf50_touchctrl",
> > +               .of_match_table = vf50_touch_of_match,
> > +       },
> > +       .probe = vf50_ts_probe,
> > +       .remove = vf50_ts_remove,
> > +       .prevent_deferred_probe = false,
> > +};
> Why Toradex ? Isn't this a Freescale IP ?

The 4 wire touchscreen support is provided by using on module circuitry
mainly comprising of FET's and leveraging the GPIOs and on chip ADC of
the Vybrid SoC.

This is specific to our Colibri Vybrid VF50 module and not the Freescale
IP. While I guess one could certainly use the driver for their own needs
if one were to replicate a similar circuitry and change the DT properties
concerning GPIO and ADC's as per their own board, as of now this is only
use on our Toradex VF50 modules and was done by us specifically to provide
touchscreen support for VF50.

Regards,
Sanchayan.
