From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Nov 2012 11:59:51 +0100
Subject: Build failure: OMAP4430 failed due to exynos4 pinctrl
In-Reply-To: <01a601cdc15d$5a4c46c0$0ee4d440$%kim@samsung.com>
References: <007b01cdc0bf$50c9ee70$f25dcb50$%kim@samsung.com>
 <201211121440.13980.arnd@arndb.de>
 <01a601cdc15d$5a4c46c0$0ee4d440$%kim@samsung.com>
Message-ID: <CACRpkdaUN0r9tbjRXyXYqRtzgd1jS8RFsomtH64ja6GfNoeomw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 13, 2012 at 6:11 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:

>> From: Arnd Bergmann <arnd@arndb.de>
>> Date: Wed, 10 Oct 2012 13:31:45 +0000
>> Subject: [PATCH] pinctrl: samsung: don't allow enabling pinctrl-samsung
>>  standalone
>>
>> The main samsung pinctrl module references the specific exynos4210
>> pinctrl driver, which selects the main driver in Kconfig.
>>
>> Making the main driver a silent "bool" option avoid this potential
>> build error if CONFIG_PINCTRL_SAMSUNG=y && CONFIG_PINCTRL_EXYNOS4=n:
>>
>> drivers/built-in.o:(.rodata+0x4e4): undefined reference to
>> `exynos4210_pin_ctrl'
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Cc: Tomasz Figa <t.figa@samsung.com>
>> Cc: Kyungmin Park <kyungmin.park@samsung.com>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
>
> Linus, can you pick this up in your pinctrl/fixes ree?

OK done.

Yours,
Linus Walleij
