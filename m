From: drinkcat@chromium.org (Nicolas Boichat)
Date: Thu, 5 Nov 2015 18:33:04 +0800
Subject: [PATCH] spi: mediatek: single device does not require cs_gpios
In-Reply-To: <CAHp75VfAHyTOpWcTh6w2EhEy73xfUYX5T3tpXbUbBiU-tjaZnQ@mail.gmail.com>
References: <1446702633-14019-1-git-send-email-drinkcat@chromium.org>
 <CAHp75VfAHyTOpWcTh6w2EhEy73xfUYX5T3tpXbUbBiU-tjaZnQ@mail.gmail.com>
Message-ID: <CANMq1KCXPjQuJUp3zOSVQQA29n9TT56Z0NPpD4o3O5s3o3nqSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 5, 2015 at 5:16 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Nov 5, 2015 at 7:50 AM, Nicolas Boichat <drinkcat@chromium.org> wrote:
[...]
>> diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
>> index 563954a..f694031 100644
>> --- a/drivers/spi/spi-mt65xx.c
>> +++ b/drivers/spi/spi-mt65xx.c
>> @@ -410,7 +410,7 @@ static int mtk_spi_setup(struct spi_device *spi)
>>         if (!spi->controller_data)
>>                 spi->controller_data = (void *)&mtk_default_chip_info;
>>
>> -       if (mdata->dev_comp->need_pad_sel)
>> +       if (mdata->dev_comp->need_pad_sel && spi->cs_gpio >= 0)
>
> gpio_is_valid() ?

Yes, thanks! Will fix in next round. (there is a few other ones in
driver/spi/* that should probably be fixed too...)

Best,
