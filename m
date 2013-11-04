From: jsarha@ti.com (Sarha, Jyri)
Date: Mon, 4 Nov 2013 08:17:15 +0000
Subject: [PATCH RFC] clk: add gpio controlled clock
In-Reply-To: <20131104084227.3323f98e@ipc1.ka-ro>
References: <cover.1383312867.git.jsarha@ti.com>
 <c52a7910c6ce33ceed0f38b89953527eee06b0b5.1383312867.git.jsarha@ti.com>
 <20131104084227.3323f98e@ipc1.ka-ro>
Message-ID: <0EB243F40EB34A418EAED8001C4B3AD019EA5EF2@DNCE05.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

-----Original Message-----
>From: Lothar Wa?mann [mailto:LW at KARO-electronics.de]
>Sent: Monday, November 04, 2013 9:42 AM
>
>Hi,
>
>Jyri Sarha wrote:
>> The added clk-gpio is a basic clock that can be enabled and disabled
...
>> +    err = gpio_request_one(gpio, gpio_flags, name);
>> +    if (err) {
>> +            pr_err("%s: Error requesting clock control gpio %u\n",
>> +                   __func__, gpio);
>> +            return ERR_PTR(-EINVAL);
>>
>You already have an error code from the gpio_request_one() call.
>Why return a different one?

I was just thinking the gpio number is more useful for debugging that the error code. Could print the both of cource.

>> +
>> +    clk_gpio = kzalloc(sizeof(struct clk_gpio), GFP_KERNEL);
>
>devm_kzalloc()?

Good point. I'll change that.

Thanks,
Jyri
