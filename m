From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Tue, 29 Aug 2017 10:44:09 +0200
Subject: [RESEND PATCH v5 00/16] eeprom: at24: Add OF device ID table
In-Reply-To: <20170828160121.gu4wf7jqu4ditksc@ninjato>
References: <20170615185418.13980-1-javier@dowhile0.org>
 <20170731153009.xkjknygpmckv2pfp@ninjato>
 <CABxcv=mdbE0QGjoi3aLzxRqM3-MbkQ_Ai6fShcGVUGSNNqqrqw@mail.gmail.com>
 <20170828160121.gu4wf7jqu4ditksc@ninjato>
Message-ID: <CABxcv=kSiqDN1=9fSfLkyW=uuXQZAoW4dhw=fco9RyOdDuPAdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Wolfram,

On Mon, Aug 28, 2017 at 6:01 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> > But there is a dependency, no? If I apply the driver patch,
>> > non-converted device trees will not find their eeproms anymore. So, I
>>
>> I don't think that's correct. If you apply this patch before the DTS
>> changes, the driver will still match using the I2C device ID table
>> like it has been doing it until today.
>
> My tests do not confirm this. If I add a node with a "renesas,24c01"
> compatible to my board, it works before your patch, but not after. If I
> change it to "atmel,24c01" it works even after your patch. I haven't
> looked into it, though, maybe i2c_of_match_device_sysfs() is stepping on
> our foots here?
>
> Did you test and did it work for you?
>

I would swear that I tested both combinations (driver patch without DT
changes and DTS changes without driver patch), but it was months ago
when I first posted the patches so I may misremembering.

I don't have a DT based system at hand now, but I'll test it again and
let you know probably tomorrow.

Best regards,
Javier
