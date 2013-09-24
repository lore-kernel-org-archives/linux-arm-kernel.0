From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 24 Sep 2013 10:50:00 -0300
Subject: [PATCH 1/9] Staging/iio/adc/touchscreen/MXS: add proper clock
 handling
In-Reply-To: <201309240950.54789.jbe@pengutronix.de>
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de>
 <1379946998-23041-2-git-send-email-jbe@pengutronix.de>
 <52405A7F.1050801@freescale.com>
 <201309240950.54789.jbe@pengutronix.de>
Message-ID: <CAOMZO5A9LY-oUpjJxWssUCo7w4oPqVxGwX0=VAUzoEu4RhJ37g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 24, 2013 at 4:50 AM, J?rgen Beisert <jbe@pengutronix.de> wrote:
> Hi Fabio,
>
> On Monday 23 September 2013 17:13:03 Fabio Estevam wrote:
>> On 09/23/2013 11:36 AM, Juergen Beisert wrote:
>> > +   lradc->clk = devm_clk_get(&pdev->dev, NULL);
>> > +   clk_prepare_enable(lradc->clk);
>>
>> clk_prepare_enable() may fail, so better check its return value.
>
> Thanks for the comment. Better this way?

Yes, looks better.

Thanks,

Fabio Estevam
