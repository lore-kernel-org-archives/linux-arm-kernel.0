From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 10 Apr 2012 11:19:11 +0200
Subject: [PATCH 3/7] drivers/gpio: gpio-nomadik: Apply Device Tree bindings
In-Reply-To: <CACRpkdZSbnaLg-5cYv8Yqspw7dV1Enx6jJW-ko6HGa0SuHM1Zg@mail.gmail.com>
References: <1333619748-16126-1-git-send-email-lee.jones@linaro.org>
 <1333619748-16126-4-git-send-email-lee.jones@linaro.org>
 <CACRpkdZSbnaLg-5cYv8Yqspw7dV1Enx6jJW-ko6HGa0SuHM1Zg@mail.gmail.com>
Message-ID: <CACRpkda5k+59QV949k2nT4Zh5aX9FjbofCUbJfb+MshNJ0m_kQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2012 at 11:14 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Thu, Apr 5, 2012 at 11:55 AM, Lee Jones <lee.jones@linaro.org> wrote:
>
>> + ? ? ? /* Requires clock name bindings. */
>> + ? ? ? OF_DEV_AUXDATA("stmicroelectronics,nomadik-gpio", 0x8012e000, "gpio.0", NULL),
>> + ? ? ? OF_DEV_AUXDATA("stmicroelectronics,nomadik-gpio", 0x8012e080, "gpio.1", NULL),
>> + ? ? ? OF_DEV_AUXDATA("stmicroelectronics,nomadik-gpio", 0x8000e000, "gpio.2", NULL),
>> + ? ? ? OF_DEV_AUXDATA("stmicroelectronics,nomadik-gpio", 0x8000e080, "gpio.3", NULL),
>> + ? ? ? OF_DEV_AUXDATA("stmicroelectronics,nomadik-gpio", 0x8000e100, "gpio.4", NULL),
>> + ? ? ? OF_DEV_AUXDATA("stmicroelectronics,nomadik-gpio", 0x8000e180, "gpio.5", NULL),
>> + ? ? ? OF_DEV_AUXDATA("stmicroelectronics,nomadik-gpio", 0x8011e000, "gpio.6", NULL),
>> + ? ? ? OF_DEV_AUXDATA("stmicroelectronics,nomadik-gpio", 0x8011e080, "gpio.7", NULL),
>> + ? ? ? OF_DEV_AUXDATA("stmicroelectronics,nomadik-gpio", 0xa03fe000, "gpio.8", NULL),
>
> Needs updating to use the st,foo prefix I guess.
>
> Please use the defined block offset addresses from <mach/db8500-regs.h>
> U8500_GPIO0_BASE etc. instead of hardcoded values.

On second thought ignore that last thing. We already have the explicit
address in
other auxdata and the goal is to get rid of the register file anyway.

Yours,
Linus Walleij
