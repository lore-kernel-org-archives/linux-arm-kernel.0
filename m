From: hs@denx.de (Heiko Schocher)
Date: Mon, 30 Jul 2012 11:31:05 +0200
Subject: [PATCH v7] ARM: davinci: i2c: add OF support
In-Reply-To: <CAM=Q2csb6pvU5WA6BeFMmBSXg9h_jacft5U8239ZtE=2dbyODw@mail.gmail.com>
References: <1343632872-25896-1-git-send-email-hs@denx.de>
 <CAM=Q2csb6pvU5WA6BeFMmBSXg9h_jacft5U8239ZtE=2dbyODw@mail.gmail.com>
Message-ID: <50165459.4000507@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shubhrajyoti,

On 30.07.2012 10:42, Shubhrajyoti Datta wrote:
> On Mon, Jul 30, 2012 at 12:51 PM, Heiko Schocher<hs@denx.de>  wrote:
>> add of support for the davinci i2c driver.
[...]
>> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
>> index 79b4bcb..b6185dc 100644
>> --- a/drivers/i2c/busses/i2c-davinci.c
>> +++ b/drivers/i2c/busses/i2c-davinci.c
[...]
>> @@ -635,6 +633,12 @@ static struct i2c_algorithm i2c_davinci_algo = {
>>          .functionality  = i2c_davinci_func,
>>   };
>>
>> +static const struct of_device_id davinci_i2c_of_match[] = {
>> +       {.compatible = "ti,davinci-i2c", },
>> +       {},
>> +};
>> +MODULE_DEVICE_TABLE(of, davinci_i2c_of_match);
>> +
>
> Should this be protected under OF flag?

No, as I know, this is not needed.

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
