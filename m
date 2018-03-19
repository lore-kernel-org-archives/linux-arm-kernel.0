From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Mon, 19 Mar 2018 14:17:01 +0100
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v8_00=2F42=5D_ARM=3A_davinci=3A_convert_to_common?=
 =?UTF-8?Q?_clock_framework=E2=80=8B?=
In-Reply-To: <1521168778-27236-1-git-send-email-david@lechnology.com>
References: <1521168778-27236-1-git-send-email-david@lechnology.com>
Message-ID: <CAMpxmJX-AxhpPpCnWoaSGYmNh3o8iRjdKacnmozsPWmhpcGdTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-03-16 3:52 GMT+01:00 David Lechner <david@lechnology.com>:
> This series converts mach-davinci to use the common clock framework.
>
> The series works like this, the first 19 patches create new clock drivers
> using the common clock framework. There are basically 3 groups of clocks -
> PLL, PSC and CFGCHIP (syscon). There are six different SoCs that each have
> unique init data, which is the reason for so many patches.
>
> Then, starting with "ARM: davinci: pass clock as parameter to
> davinci_timer_init()", we get the mach code ready for the switch by adding the
> code needed for the new clock drivers and adding #ifndef CONFIG_COMMON_CLK
> around the legacy clocks so that we can switch easily between the old and the
> new.
>
> "ARM: davinci: switch to common clock framework" actually flips the switch
> to start using the new clock drivers. Then the next 8 patches remove all
> of the old clock code.
>
> The final three patches add device tree clock support to the one SoC that
> supports it.
>
> This series has been tested on LEGO MINDSTORMS EV3 (device tree) and TI
> OMAP-L138 LCDK (both device tree and legacy board file).
>

Hi David,

thanks, with the u-boot fix everything seems to work fine. I tested
da850-lcdk and da850-evm boards in DT and board file modes.

I'll be working with this series in the following days and will do
some thorough testing and rebase my aemif series on top of it. I'll
also use the recently merged reset support for board files to get rid
of the exported reset functions.

Thanks for your work!

Best regards,
Bartosz Golaszewski
