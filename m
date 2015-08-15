From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 15 Aug 2015 17:21:59 +0900
Subject: [PATCH 3/3] ARM: dts: UniPhier: add ProXstream2 and PH1-LD6b
 SoC/board support
In-Reply-To: <CAOesGMhhSKr6Nn7YEjoB9V_5-yhwzn_fKZ7FSU3U-2XYT5mJrQ@mail.gmail.com>
References: <1438687264-26538-1-git-send-email-yamada.masahiro@socionext.com>
 <1438687264-26538-4-git-send-email-yamada.masahiro@socionext.com>
 <20150811130739.GD30181@localhost>
 <CAK7LNAQ+6tQ9Ci6LKsAB7kLj0o60Hizo2gOokDH9qW=FnO0gEA@mail.gmail.com>
 <CAOesGMhhSKr6Nn7YEjoB9V_5-yhwzn_fKZ7FSU3U-2XYT5mJrQ@mail.gmail.com>
Message-ID: <CAK7LNATVhFLe_ObuLdWxNWiO=kapBrvEJEVHEfZC8Bu5AsRASA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,


2015-08-13 18:09 GMT+09:00 Olof Johansson <olof@lixom.net>:
> On Wed, Aug 12, 2015 at 3:14 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> Hi Olof,
>>
>>
>> 2015-08-11 22:07 GMT+09:00 Olof Johansson <olof@lixom.net>:
>>> Hi,
>>>
>>> On Tue, Aug 04, 2015 at 08:21:04PM +0900, Masahiro Yamada wrote:
>>>> Initial version of DTSI for ProXstream2 and PH1-LD6b and DTS for
>>>> PH1-LD6b reference board.
>>>>
>>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>>> ---
>>>>
>>>>  arch/arm/boot/dts/Makefile                  |   3 +-
>>>>  arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts | 105 +++++++++++
>>>>  arch/arm/boot/dts/uniphier-ph1-ld6b.dtsi    |  67 +++++++
>>>>  arch/arm/boot/dts/uniphier-proxstream2.dtsi | 273 ++++++++++++++++++++++++++++
>>>>  4 files changed, 447 insertions(+), 1 deletion(-)
>>>>  create mode 100644 arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts
>>>>  create mode 100644 arch/arm/boot/dts/uniphier-ph1-ld6b.dtsi
>>>>  create mode 100644 arch/arm/boot/dts/uniphier-proxstream2.dtsi
>>>>
>>>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>>>> index 246473a..6eb3f2f 100644
>>>> --- a/arch/arm/boot/dts/Makefile
>>>> +++ b/arch/arm/boot/dts/Makefile
>>>> @@ -645,7 +645,8 @@ dtb-$(CONFIG_ARCH_UNIPHIER) += \
>>>>       uniphier-ph1-sld3-ref.dtb \
>>>>       uniphier-ph1-ld4-ref.dtb \
>>>>       uniphier-ph1-pro4-ref.dtb \
>>>> -     uniphier-ph1-sld8-ref.dtb
>>>> +     uniphier-ph1-sld8-ref.dtb \
>>>> +     uniphier-ph1-ld6b-ref.dtb
>>>
>>> Please always add entries here sorted, don't just append. I've fixed it
>>> up for you this time.
>>>
>>>
>>
>> Please do not do that (without my ack).
>
> I'm not going to go get your ack for something as trivial as this. We
> do make sure subplatform maintainers are in the loop and get to review
> code that touches their platform, but in this case this was a shared
> makefile and there were no functional changes.
>
>> It was already sorted from old SoC to new SoC.
>>
>> Sorting chronologically (in other words, in the order of chip ID)
>> makes more sense than sorting alphabetically.
>
> No, it doesn't. All entries in these files should be sorted
> alphabetically. Sometimes we miss out on it, but it's the goal.


I did not know that, my apology.



> If you sort chronologically it's impossible for anyone but people
> intimately familiar with UniPhier's product history to add any new
> entries in the right location. Also, since it's likely that newer
> chips will be introduced over time, new entries are likely to just be
> appends instead of inserted at more varied locations in the files.
>
> Append-only additions are more likely to have add/add conflicts, which
> is why we're preferring alphabetical sort order in the first place.


This is true for various entries as well as arch/arm/boot/dts/Makefile.
I am wondering how far we should stick to alphabetical sorting.


For example, do you recommend OF compatible tables should be sorted
alphabetically?


arch/arm/mach-uniphier/uniphier.c:

static const char * const uniphier_dt_compat[] __initconst = {
        "socionext,ph1-sld3",
        "socionext,ph1-ld4",
        "socionext,ph1-pro4",
        "socionext,ph1-sld8",
        "socionext,ph1-pro5",
        "socionext,proxstream2",
        "socionext,ph1-ld6b",
        NULL,
};

This table (only containing SoC names) is currently sorted
chronologically, and the logic
is the same as arch/arm/boot/dts/Makefile.


This file belongs to my maintainer-ship, but I just wonder
which sorting rule, chronologically or alphabetically, is better in general.



-- 
Best Regards
Masahiro Yamada
