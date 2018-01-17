From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 17 Jan 2018 10:39:06 +0100
Subject: [PATCH v3 4/4] ARM: dts: bcm2837-rpi-3-b: add GPIO expander
In-Reply-To: <6c07ab6a-a2c6-284e-6205-58d2512d0256@i2se.com>
References: <cover.1516105893.git.baruch@tkos.co.il>
 <8ba2147dc08bb50a65b49ca2142f7710e1635d20.1516105893.git.baruch@tkos.co.il>
 <6c07ab6a-a2c6-284e-6205-58d2512d0256@i2se.com>
Message-ID: <CACRpkdZTrRUB+AVt6Ccpd_F1SQAX5fnk5c6xB9sisfO18DUZ_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 17, 2018 at 9:30 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:

> Hi Linus,
> hi Eric,
>
>
> Am 16.01.2018 um 13:45 schrieb Baruch Siach:
>>
>> Add a description of the RPi3 GPIO expander that the VC4 firmware
>> controls.
>>
>> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
>> ---
>> v3:
>>    * List GPIO names one per line.
>>
>> v2:
>>    * Move GPIO expander node out of the soc container
>>    * Rename compatible string
>>    * Add gpio-line-names property
>> ---
>>   arch/arm/boot/dts/bcm2837-rpi-3-b.dts | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
>> b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
>> index b44b3b5af00d..8cd93425ffe3 100644
>> --- a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
>> +++ b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
>> @@ -23,6 +23,22 @@
>>                         gpios = <&gpio 47 0>;
>>                 };
>>         };
>
>
> i noticed that this patch conflicts with my patch ("ARM: dts: bcm283x: Use
> GPIO polarity defines consistently") in linux-next.
>
> How should we proceed?

All DTS patches shall be merged through ARM SoC so the conflict should
be resolved by whoever sends the pull requests to ARM SoC before
sending the pull request.

I think these patches will be for the next kernel anyways, unless Torvalds
think we should have an -rc9 this time (because of all the meltdowns and
spectres etc you know).

Yours,
Linus Walleij
