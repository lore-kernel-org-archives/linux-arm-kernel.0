From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 26 Feb 2015 16:32:51 +0100
Subject: [PATCH v5 1/6] mfd: fsl imx25 Touchscreen ADC driver
In-Reply-To: <20150218120844.GC22296@x1>
References: <1422108103-15052-1-git-send-email-mpa@pengutronix.de>
 <1422108103-15052-2-git-send-email-mpa@pengutronix.de>
 <20150216133829.GG14545@x1>
 <CAOMZO5AwbNeEhVgUuLUi-_QT0DesPBBCTvvebuA91y-P2_CNzg@mail.gmail.com>
 <20150218080156.GA5781@x1>
 <CAOMZO5BjVrcb3t1=kQQYf=-PztzDpGk8S5ApsTThGekT1yTTnA@mail.gmail.com>
 <20150218120844.GC22296@x1>
Message-ID: <20150226153251.GD10070@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 18, 2015 at 12:08:44PM +0000, Lee Jones wrote:
> On Wed, 18 Feb 2015, Fabio Estevam wrote:
> 
> > On Wed, Feb 18, 2015 at 6:01 AM, Lee Jones <lee.jones@linaro.org> wrote:
> > > On Tue, 17 Feb 2015, Fabio Estevam wrote:
> > >
> > >> On Mon, Feb 16, 2015 at 11:38 AM, Lee Jones <lee.jones@linaro.org> wrote:
> > >>
> > >> >> +static int mx25_tsadc_setup_irq(struct platform_device *pdev,
> > >> >> +                             struct mx25_tsadc *tsadc)
> > >> >> +{
> > >> >> +     struct device *dev = &pdev->dev;
> > >> >> +     struct device_node *np = dev->of_node;
> > >> >> +     int irq;
> > >> >> +
> > >> >> +     irq = platform_get_irq(pdev, 0);
> > >> >> +     if (irq < 0) {
> > >> >
> > >> > What if 0 is returned?
> > >>
> > >> Then  imx25.dtsi would be passing irq=0 for the ADC, which would be
> > >> totally wrong.
> > >
> > > Exactly, so it should be <=.
> > 
> > imx25.dtsi passes interrupts = <46>; for the touch screen controller,
> > so the irq number will never be zero.
> 
> It doesn't matter what happens to be passed at the moment.  The
> correct thing to do is enforce correct/full error checking.  Yes <0 is
> an error, but so is =0, so encompass it in the checks.

I now changed all irq < 0 checks to irq <= 0 under the assumption that
irq 0 is always an error.

Thanks,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150226/1944dc3f/attachment.sig>
