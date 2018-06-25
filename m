From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Mon, 25 Jun 2018 18:01:14 +0200
Subject: [PATCH 1/9] clk: davinci: psc-dm365: use two lookup entries for
 the aemif clock
In-Reply-To: <241fed6e-b414-feac-8e6c-39713c5e665e@lechnology.com>
References: <20180625152920.11549-1-brgl@bgdev.pl>
 <20180625152920.11549-2-brgl@bgdev.pl>
 <241fed6e-b414-feac-8e6c-39713c5e665e@lechnology.com>
Message-ID: <CAMRc=MdTdoL9qsrMAxhCTaQM7HGrAPpTVjDuHQ81Q5O-QMNcYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-06-25 17:53 GMT+02:00 David Lechner <david@lechnology.com>:
> On 06/25/2018 10:29 AM, Bartosz Golaszewski wrote:
>>
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> We want to be able to get the clock both from the board file by its
>> con_id and from the aemif driver by dev_id.
>
>
> What about the other SoCs? Don't they need this change as well?
>

So I double checked and turns out I missed one other board that's
affected by this series and calls clk_get() from machine code:
dm644x-evm.

I'll fix it in v2.

Thanks,
Bart

>
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>   drivers/clk/davinci/psc-dm365.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/davinci/psc-dm365.c
>> b/drivers/clk/davinci/psc-dm365.c
>> index 8c73086cc676..c75424f4ea3b 100644
>> --- a/drivers/clk/davinci/psc-dm365.c
>> +++ b/drivers/clk/davinci/psc-dm365.c
>> @@ -21,7 +21,8 @@ LPSC_CLKDEV1(mmcsd1_clkdev,           NULL,
>> "da830-mmc.1");
>>   LPSC_CLKDEV1(asp0_clkdev,             NULL,           "davinci-mcbsp");
>>   LPSC_CLKDEV1(usb_clkdev,              "usb",          NULL);
>>   LPSC_CLKDEV1(spi2_clkdev,             NULL,           "spi_davinci.2");
>> -LPSC_CLKDEV1(aemif_clkdev,             "aemif",        NULL);
>> +LPSC_CLKDEV2(aemif_clkdev,             "aemif",        NULL,
>> +                                       NULL,           "ti-aemif");
>>   LPSC_CLKDEV1(mmcsd0_clkdev,           NULL,           "da830-mmc.0");
>>   LPSC_CLKDEV1(i2c_clkdev,              NULL,           "i2c_davinci.1");
>>   LPSC_CLKDEV1(uart0_clkdev,            NULL,           "serial8250.0");
>>
>
