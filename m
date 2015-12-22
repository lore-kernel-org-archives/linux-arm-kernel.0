From: eric@anholt.net (Eric Anholt)
Date: Mon, 21 Dec 2015 20:02:21 -0800
Subject: [PATCH v4 2/4] ARM: bcm2835: add rpi power domain driver
In-Reply-To: <CAPDyKFp5JfHmNw+ryoAnu-0XANcxW_pyNL_GUFUw7sBQmU+WDA@mail.gmail.com>
References: <1450312009-1791-1-git-send-email-eric@anholt.net>
 <1450312009-1791-3-git-send-email-eric@anholt.net>
 <CAPDyKFp5JfHmNw+ryoAnu-0XANcxW_pyNL_GUFUw7sBQmU+WDA@mail.gmail.com>
Message-ID: <877fk7167m.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On 17 December 2015 at 01:26, Eric Anholt <eric@anholt.net> wrote:
>> From: Alexander Aring <alex.aring@gmail.com>
>>
>> This patch adds support for several power domains on Raspberry Pi,
>> including USB (so it can be enabled even if the bootloader didn't do
>> it), and graphics.
>>
>> This patch is the combined work of Eric Anholt (who wrote USB support
>> inside of the Raspberry Pi firmware driver, and wrote the non-USB
>> domain support) and Alexander Aring (who separated the original USB
>> work out from the firmware driver).
>>
>> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> ---
>>
>> v2: Add support for power domains other than USB, using the new
>>     firmware interface, reword commit message (changes by Eric)
>>
>> v3: Restructure as a builtin driver, and drop
>>     of_genpd_add_provider_onecell error handling to avoid
>>     pm_genpd_exit() dependency until that API can be settled.  Clean
>>     up copyright header, add missing ISP initialization, and fix typo
>>     in transposer's name.
>>
>> v4: Move to drivers/soc/bcm/, move include to dt-bindings/soc/, set up
>>     Makefile for the drivers/soc/bcm following clk/'s model.
>>
>>  drivers/soc/Kconfig                         |   1 +
>>  drivers/soc/Makefile                        |   1 +
>>  drivers/soc/bcm/Kconfig                     |   9 +
>>  drivers/soc/bcm/Makefile                    |   1 +
>>  drivers/soc/bcm/raspberrypi-power.c         | 247 ++++++++++++++++++++++++++++
>>  include/dt-bindings/soc/raspberrypi-power.h |  41 +++++
>
> There is currently a directory which I think may be better.
> include/dt-bindings/power/*
>
> Besides this nitpick, I think this looks good. You may add my:
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks!  I'll be sending my pull requests with the two r-bs added and
these nitpicks fixed.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151221/50b4b2ea/attachment.sig>
