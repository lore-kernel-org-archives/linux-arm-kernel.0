From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 16 Oct 2015 14:24:30 +0900
Subject: [PATCH 2/3] ARM: dts: uniphier: add ProXstream2 Vodka board
 support
In-Reply-To: <63719761.5kc6F97FjG@wuerfel>
References: <1444899934-4754-1-git-send-email-yamada.masahiro@socionext.com>
 <1444899934-4754-3-git-send-email-yamada.masahiro@socionext.com>
 <63719761.5kc6F97FjG@wuerfel>
Message-ID: <CAK7LNATzgOZp542rd-92YXDxux2DrAOH_mkzk8NjimQ3afrCCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

2015-10-16 0:17 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Thursday 15 October 2015 18:05:33 Masahiro Yamada wrote:
>> +       aliases {
>> +               serial0 = &serial0;
>> +               serial1 = &serial1;
>> +               serial2 = &serial2;
>> +               i2c0 = &i2c0;
>> +               i2c4 = &i2c4;
>> +               i2c5 = &i2c5;
>> +               i2c6 = &i2c6;
>>
>
> This looks like a typo, you probably mean
>
>                i2c0 = &i2c0;
>                i2c1 = &i2c4;
>                i2c2 = &i2c5;
>                i2c3 = &i2c6;
>
> Can you re-send this?
>


No, it is not a typo, but intentional.


i2c0 - i2c3 are connected to the pads of the SoC package.
On the other hand, i2c-4 - i2c-6 are connected to
internal devices inside the SoC package.

i2c-4 - i2c-6 are always connected to the same hardware
devices and always used for the same purpose.


My expected scenario is:

[1] i2c0 - i2c3 are connected to the on-board devices
    depending on board variants.
    On some boards, their status is "okay" and
    on some boards, their status is "disabled".

[2] i2c4 - i2c6 are always used to communicate
    with in-package devices.  The status is always "okay".

[3] Some user-land applications may want to have access
     through the same character devices,
      /dev/i2c4, /dev/i2c5, /dev/i2c6


If your way is adopted,
the real hardware "i2c4" might be aligned to /dev/i2c1 on some boards,
and /dev/i2c2 on others, etc.



-- 
Best Regards
Masahiro Yamada
