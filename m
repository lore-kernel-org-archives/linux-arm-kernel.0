From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 30 Oct 2015 11:01:21 +0900
Subject: [PATCH 1/2] pinctrl: uniphier: enable UniPhier SoCs pinctrl
 drivers by default
In-Reply-To: <CACRpkdY4hs_7dE2KicDeUj7hvbKmHu3pcwQO3eshTtSmzH2PGA@mail.gmail.com>
References: <1445912911-1292-1-git-send-email-yamada.masahiro@socionext.com>
 <CACRpkdY4hs_7dE2KicDeUj7hvbKmHu3pcwQO3eshTtSmzH2PGA@mail.gmail.com>
Message-ID: <CAK7LNARMSHWEYkZO+ArCFDVr6S_mtF47kAEr8wDuCaa059+4KA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,


2015-10-29 22:33 GMT+09:00 Linus Walleij <linus.walleij@linaro.org>:
> On Tue, Oct 27, 2015 at 3:28 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>
>> Add "default y" to the Kconfig rather than adding entries into
>> arch/arm/configs/multi_v7_defconfig.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> (...)
>> config PINCTRL_UNIPHIER_PH1_LD4
>>         tristate "UniPhier PH1-LD4 SoC pinctrl driver"
>> +       default y
>>         select PINCTRL_UNIPHIER_CORE
>
> Why is it not default y if <PH1_LD4_SOC_THING>?
>
> So it is only turned on if the corresponding SoC is selected?
>
> Or don't you have symbols like that?

No, I don't have such per-SoC symbols.

I only have ARCH_UNIPHIER, for the whole UniPhier SoC family.

We no longer #ifdef <SOC_THING> in C sources.

The only difference among SoCs is, which drivers should be enabled.

All SoCs in UniPhier family share the multi-platform kernel image,
so I think, this way is reasonable enough.



-- 
Best Regards
Masahiro Yamada
