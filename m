From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 Jan 2014 09:56:17 +0100
Subject: [PATCH v2] ARM: iop32x: fix power off handling for the EM7210
 board
In-Reply-To: <87lhxyfkax.fsf@lebrac.rtp-net.org>
References: <1391005215-8520-1-git-send-email-linus.walleij@linaro.org>
 <87lhxyfkax.fsf@lebrac.rtp-net.org>
Message-ID: <CACRpkdbYNvS3+XfLeUHbUBxfd=L+bk9E3pidFMTENcLVj-nBkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 30, 2014 at 12:19 AM, Arnaud Patard
<arnaud.patard@rtp-net.org> wrote:
> Linus Walleij <linus.walleij@linaro.org> writes:

>>  void em7210_power_off(void)
>>  {
>> -     *IOP3XX_GPOE &= 0xfe;
>> -     *IOP3XX_GPOD |= 0x01;
>> +     int ret;
>> +
>> +     ret = gpio_direction_output(EM7210_HARDWARE_POWER, 1);
>
> btw, any reason for not using gpio_direction_output() in
> em7210_request_gpios() and gpio_set_value() here ? (just wondering)

Mainly because the old code did not drive a default value on
the pin (which would be zero then) but relies on the power-on
default.

So by not doing this I'm not poking any hardware that wasn't poked
earlier.

> I can't test it on my ss4000e but at least this patch looks fine.

Would be nice!

Yours,
Linus Walleij
