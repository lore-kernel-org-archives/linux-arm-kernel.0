From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 30 Jul 2010 13:09:00 +0800
Subject: [PATCH 11/13] [ARM] pxa/balloon3: PCF857x GPIO expander and LEDs
In-Reply-To: <201007300644.04710.marek.vasut@gmail.com>
References: <1280373389-32475-1-git-send-email-marek.vasut@gmail.com>
	<1280373389-32475-11-git-send-email-marek.vasut@gmail.com>
	<20100729100040.GA4981@dream.aleph1.co.uk>
	<201007300644.04710.marek.vasut@gmail.com>
Message-ID: <AANLkTik4kH9a46pXN0BFcL=04PAU0Ut71nuPQR5H8Lqy@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 30, 2010 at 12:44 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Dne ?t 29. ?ervence 2010 12:00:41 Wookey napsal(a):
>> +++ Marek Vasut [2010-07-29 05:16 +0200]:
>> > Add supported for PCF8574A GPIO expander and LEDs attached to it.
>>
>> This IO board is an add-on used in some ballon configurations, not
>> part of the core board. There needs to be some way of selecting this
>> support when the loon is used in this configuration. We have the
>> balloon_has() macro which is used for dealing with the different
>> builds of the board itself. Perhaps it should be extended to deal with
>> add-on board functionality too?
>>
>> More obvious is using the CONFIG system to just enable this if
>> CUED_IO_BOARD is configured.
>
> You can just disable the PCF driver if you want to save space. In case you won't
> have the CUED board connected, the driver will just fail to probe so it's ok I
> believe.
>
> The macro could be extended, but do we want such a weird stuff in kernel?
> (especially if the driver can simply fail to probe).

Are we able to detect this expansion board at run-time and registers
i2c/led-gpio if present. The thing I'm worried more on space is the
gpio_leds will be registered there even without the expansion board,
but what if someone tries to read/write to those LED controls?

>>
>> Wookey
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
