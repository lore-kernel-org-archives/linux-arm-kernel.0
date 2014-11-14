From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri, 14 Nov 2014 16:47:00 +0400
Subject: [PATCH 01/15] mfd: add new driver for Sharp LoCoMo
In-Reply-To: <20141105202405.GJ8509@sirena.org.uk>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
 <1414454528-24240-2-git-send-email-dbaryshkov@gmail.com>
 <CACRpkdbW3NA00zMZr216ZeZpgVkXwKUo30biTVd5kcHKGGtkHg@mail.gmail.com>
 <CALT56yNX8v4mZn=o1ZoVLHPmg6wq0dgFNowpqNuFtU=eCc+d8w@mail.gmail.com>
 <CACRpkdaKUZjbSEH75M9xudTF9HefwOCVEe5otv9-9f2UG8=hVg@mail.gmail.com>
 <CALT56yM8B3ffYb0=EZVbRRGDZSxMci2sRp9XVtjQuLa5abN+cg@mail.gmail.com>
 <20141105202405.GJ8509@sirena.org.uk>
Message-ID: <CALT56yOtjNbYOWM4ba5yP8pz7bNLY5BWpkkpfmv5QZU-7Y5u_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

2014-11-05 23:24 GMT+03:00 Mark Brown <broonie@kernel.org>:
> On Thu, Nov 06, 2014 at 12:02:49AM +0400, Dmitry Eremin-Solenikov wrote:
>> 2014-11-03 16:41 GMT+03:00 Linus Walleij <linus.walleij@linaro.org>:
>
>> > The point is still the same: no unrelated code in drivers/mfd,
>> > then either use IIO DAC as a middle layer or sink the DAC handling
>> > into respective subdriver, i.e. push it into the backlight or
>> > volume directly then.
>
>> The problem is that the DAC is equally used by backlight and by sound
>> device (WIP).
>> What about true i2c device driver sitting in drivers/misc and exporting a regmap
>> of 2 8-bit registers?
>
> If it can just export registers that sounds like a MFD.  If it needs to
> export functionality then like Linus says the IIO subsystem abstracts
> DACs.

I took a look at IIO subsystem. Thanks for the pointer. Indeed max517 driver
can drive m62332 DAC with minimal modifications. However write support
of the consumer interface is non-existing yet (which would be required
to support DACs in unified manner).

I'm actually looking at the regulator interface. Since this DAC serves mostly
like a (semi-)constant voltage interface, would it be rather logical to use
regulator subsystem to drive it?

-- 
With best wishes
Dmitry
