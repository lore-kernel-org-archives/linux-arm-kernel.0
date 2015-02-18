From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Feb 2015 08:01:56 +0000
Subject: [PATCH v5 1/6] mfd: fsl imx25 Touchscreen ADC driver
In-Reply-To: <CAOMZO5AwbNeEhVgUuLUi-_QT0DesPBBCTvvebuA91y-P2_CNzg@mail.gmail.com>
References: <1422108103-15052-1-git-send-email-mpa@pengutronix.de>
 <1422108103-15052-2-git-send-email-mpa@pengutronix.de>
 <20150216133829.GG14545@x1>
 <CAOMZO5AwbNeEhVgUuLUi-_QT0DesPBBCTvvebuA91y-P2_CNzg@mail.gmail.com>
Message-ID: <20150218080156.GA5781@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Feb 2015, Fabio Estevam wrote:

> On Mon, Feb 16, 2015 at 11:38 AM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> >> +static int mx25_tsadc_setup_irq(struct platform_device *pdev,
> >> +                             struct mx25_tsadc *tsadc)
> >> +{
> >> +     struct device *dev = &pdev->dev;
> >> +     struct device_node *np = dev->of_node;
> >> +     int irq;
> >> +
> >> +     irq = platform_get_irq(pdev, 0);
> >> +     if (irq < 0) {
> >
> > What if 0 is returned?
> 
> Then  imx25.dtsi would be passing irq=0 for the ADC, which would be
> totally wrong.

Exactly, so it should be <=.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
