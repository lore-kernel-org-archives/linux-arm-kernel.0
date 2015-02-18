From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 18 Feb 2015 09:57:59 -0200
Subject: [PATCH v5 1/6] mfd: fsl imx25 Touchscreen ADC driver
In-Reply-To: <20150218080156.GA5781@x1>
References: <1422108103-15052-1-git-send-email-mpa@pengutronix.de>
 <1422108103-15052-2-git-send-email-mpa@pengutronix.de>
 <20150216133829.GG14545@x1>
 <CAOMZO5AwbNeEhVgUuLUi-_QT0DesPBBCTvvebuA91y-P2_CNzg@mail.gmail.com>
 <20150218080156.GA5781@x1>
Message-ID: <CAOMZO5BjVrcb3t1=kQQYf=-PztzDpGk8S5ApsTThGekT1yTTnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 18, 2015 at 6:01 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Tue, 17 Feb 2015, Fabio Estevam wrote:
>
>> On Mon, Feb 16, 2015 at 11:38 AM, Lee Jones <lee.jones@linaro.org> wrote:
>>
>> >> +static int mx25_tsadc_setup_irq(struct platform_device *pdev,
>> >> +                             struct mx25_tsadc *tsadc)
>> >> +{
>> >> +     struct device *dev = &pdev->dev;
>> >> +     struct device_node *np = dev->of_node;
>> >> +     int irq;
>> >> +
>> >> +     irq = platform_get_irq(pdev, 0);
>> >> +     if (irq < 0) {
>> >
>> > What if 0 is returned?
>>
>> Then  imx25.dtsi would be passing irq=0 for the ADC, which would be
>> totally wrong.
>
> Exactly, so it should be <=.

imx25.dtsi passes interrupts = <46>; for the touch screen controller,
so the irq number will never be zero.
