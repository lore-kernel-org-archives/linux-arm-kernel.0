From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 11 Sep 2012 19:52:38 +0200
Subject: [PATCH] watchdog: ks8695: sink registers into driver
In-Reply-To: <20120911104959.GF27604@spo001.leaseweb.com>
References: <1347342495-6990-1-git-send-email-linus.walleij@linaro.org>
 <20120911104959.GF27604@spo001.leaseweb.com>
Message-ID: <CACRpkdafmJ+CbaK=PtVwd6pGyBH8U8w-OV+QLWop=_NgyTCisw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2012 at 12:49 PM, Wim Van Sebroeck <wim@iguana.be> wrote:

> Hi Linus,
>> Commit 70adc3f32adc2fb90b0107c020678588e4cf9f51
>> "ARM: ks8695: merge the timer header into the timer driver"
>> accidentally broke the ks8695 watchdog since it was using
>> the timer registers in watchdog mode.
>>
>> Perform the same operation here: push the registers down
>> into the driver, so it is self-contained, and we can keep
>> depopulating the <mach/*> namespace.
>>
>> Reported-by: Olof Johansson <olof@lixom.net>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> Requesting an ACK from the watchdog maintainer so we can
>> merge this through the ARM SoC tree where the regression
>> was introduced.
>>
>> And yes, the drive needs to take resources and ioremap(),
>> but that is another patch.
>
> Acked-by: Wim Van Sebroeck <wim@iguana.be>

Thanks, Olof/Arnd: can you pick this single patch to the
ks8695/timer branch?

Yours,
Linus Walleij
