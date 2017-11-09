From: robh+dt@kernel.org (Rob Herring)
Date: Thu, 9 Nov 2017 17:06:25 -0600
Subject: [PATCH 1/2] MIPS: dts: remove bogus bcm96358nb4ser.dtb from dtb-y
 entry
In-Reply-To: <CAK7LNARzRUA6ZGQUiebZ+nmLBSAVdYONsozHBf0VQb83KqSx1g@mail.gmail.com>
References: <1509859853-27473-1-git-send-email-yamada.masahiro@socionext.com>
 <1509859853-27473-2-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNAQfK_BWQcVW-ScrpAwNAHav3MrrzV-tjn_YUjsuvd7U5A@mail.gmail.com>
 <20171106095139.GG15260@jhogan-linux>
 <CAK7LNAQ_bugEP8hHKmCif5QCz2=Pw_GpXzYz4zJeXO0HXaT_ag@mail.gmail.com>
 <CAL_JsqJ8taCKnr_79UumiH2GFYq-fMzzkYm2iYevTOgUUWuzvg@mail.gmail.com>
 <CAK7LNATZ9O4cCpxLrG3MJoKYF+RnURkY4-tY2MdiZb90eGPtQg@mail.gmail.com>
 <CAK7LNARzRUA6ZGQUiebZ+nmLBSAVdYONsozHBf0VQb83KqSx1g@mail.gmail.com>
Message-ID: <CAL_JsqJF=AV_m7DJyc4GGX0xrbvn+yJ05Oy8EWoM+FO8qr=k2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 8, 2017 at 6:38 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2017-11-09 9:11 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>> 2017-11-09 1:51 GMT+09:00 Rob Herring <robh+dt@kernel.org>:
>>> On Mon, Nov 6, 2017 at 5:00 AM, Masahiro Yamada
>>> <yamada.masahiro@socionext.com> wrote:
>>>> 2017-11-06 19:41 GMT+09:00 James Hogan <jhogan@kernel.org>:
>>>>> Hi,
>>>>>
>>>>> On Sun, Nov 05, 2017 at 11:11:38PM +0900, Masahiro Yamada wrote:
>>>>>> +CC Ralf Baechle <ralf@linux-mips.org>
>>>>>> +CC linux-mips at linux-mips.org
>>>>>> +CC Kevin Cernekee <cernekee@gmail.com>
>>>>>> +CC Florian Fainelli <f.fainelli@gmail.com>
>>>>>>
>>>>>>
>>>>>> I missed to CC MIPS maintainers.
>>>>>
>>>>> Yes, please resend the patch so it lands in patchwork.linux-mips.org.
>>>>
>>>>
>>>> This is a part of clean-up series of DT building.
>>>>
>>>> I want Acked-by from MIPS maintainers
>>>> so that the whole series can go to a different tree.
>>>> (DT or Kbuild).
>>>>
>>>>
>>>> Sam addressed more clean-up candidates in MIPS Makefiles
>>>> https://patchwork.kernel.org/patch/10041879/
>>>>
>>>> So, I will probably end up with touching those Makefiles more.
>>>>
>>>> All patches must go to the same tree.
>>>>
>>>>
>>>>>> 2017-11-05 14:30 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>>>>>> > arch/mips/boot/dts/brcm/bcm96358nb4ser.dts does not exist, so
>>>>>> > we cannot build bcm96358nb4ser.dtb .
>>>>>
>>>>> This appears to be due to the file being renamed in commit 695835511f96
>>>>> ("MIPS: BMIPS: rename bcm96358nb4ser to bcm6358-neufbox4-sercom").
>>>>> Please can you update the commit message when you resend to mention the
>>>>> cause of the problem.
>>>>>
>>>>> You could also add the following if you like while you're at it:
>>>>>
>>>>> Fixes: 695835511f96 ("MIPS: BMIPS: rename bcm96358nb4ser to bcm6358-neufbox4-sercom")
>>>>> Cc: <stable@vger.kernel.org> # 4.9+
>>>
>>> I think this one can be applied independently and we'd want it to if
>>> we tag for stable. So I think it can go thru the MIPS tree.
>>>
>>
>>
>> As I said to MIPS folks, this patch must go before 2/2.
>>
>> You picked up only 2/2, so your dt/kbuild branch is broken.
>>
>>
>> make ARCH=mips allyesconfig
>> && make ARCH=mips CROSS_COMPILE=mips-linux- dtbs
>>
>>
>> will produce the following error.
>>
>>
>> make[2]: *** No rule to make target
>> 'arch/mips/boot/dts/brcm/bcm96358nb4ser.dtb', needed by '__build'.
>> Stop.
>> scripts/Makefile.build:570: recipe for target 'arch/mips/boot/dts/brcm' failed
>> make[1]: *** [arch/mips/boot/dts/brcm] Error 2
>> arch/mips/Makefile:413: recipe for target 'dtbs' failed
>> make: *** [dtbs] Error 2
>>
>
>
> Looking into it, probably
> bmips_dtb_defconfig was already broken regardless my patches.
>
> But, I am not comfortable with breaking all{yes,mod}config
> because they are often used for build test.
>
>
> I hope you can apply this in the order as I sent,
> with the following tag.
>
> Fixes: 695835511f96 ("MIPS: BMIPS: rename bcm96358nb4ser to
> bcm6358-neufbox4-sercom")
> Cc: <stable@vger.kernel.org> # 4.9+

Okay, now applied.

Rob
