From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 24 Jan 2013 15:38:54 +0800
Subject: [PATCH 2/2] i2c: sirf: add support for new SiRFmarco SMP SoC
In-Reply-To: <20130124072736.GJ8364@nekote.pengutronix.de>
References: <1356489017-17737-1-git-send-email-Barry.Song@csr.com>
 <1356489017-17737-2-git-send-email-Barry.Song@csr.com>
 <20130124072736.GJ8364@nekote.pengutronix.de>
Message-ID: <CAGsJ_4wXn8PT4+Ct_qnEXiFEYVAZ8H_AYG=Ojo7Oog9QhZivMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/1/24 Wolfram Sang <w.sang@pengutronix.de>:
> On Wed, Dec 26, 2012 at 10:30:17AM +0800, Barry Song wrote:
>> From: Barry Song <Baohua.Song@csr.com>
>>
>> the driver is also compatible with SiRFmarco except SiRFprimaII,
>> so simply add "sirf,marco-i2c" to OF match table.
>>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>
> Why can't you use the existing compatible entry as a fallback like in:
>
>         compatible = "sirf,marco-i2c", "sirf,prima2-i2c";
> ?

ok. let's hold on this one.
i was hoping registers layout/work mode would have some changes in the
final marco design as marco chip was still a fpga.
i have been sure spi will have a new high speed mode, for i2c, no
message for the moment.

>
>> ---
>>  drivers/i2c/busses/i2c-sirf.c |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-sirf.c b/drivers/i2c/busses/i2c-sirf.c
>> index 181d7c2..ed38b16 100644
>> --- a/drivers/i2c/busses/i2c-sirf.c
>> +++ b/drivers/i2c/busses/i2c-sirf.c
>> @@ -439,6 +439,7 @@ static const struct dev_pm_ops i2c_sirfsoc_pm_ops = {
>>
>>  static const struct of_device_id sirfsoc_i2c_of_match[] __devinitconst = {
>>       { .compatible = "sirf,prima2-i2c", },
>> +     { .compatible = "sirf,marco-i2c", },
>>       {},
>>  };
>>  MODULE_DEVICE_TABLE(of, sirfsoc_i2c_of_match);
>> --

-barry
