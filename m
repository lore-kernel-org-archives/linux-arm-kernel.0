From: stigge@antcom.de (Roland Stigge)
Date: Sat, 29 Dec 2012 15:10:07 +0100
Subject: [PATCH 0/6 v12] gpio: Add block GPIO
In-Reply-To: <20121229121356.GB7360@game.jcrosoft.org>
References: <1356281376-25853-1-git-send-email-stigge@antcom.de>
 <20121229102017.GA7360@game.jcrosoft.org> <50DEDB99.5080701@antcom.de>
 <20121229121356.GB7360@game.jcrosoft.org>
Message-ID: <50DEF9BF.6020301@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/12/12 13:13, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 13:01 Sat 29 Dec     , Roland Stigge wrote:
>> On 29/12/12 11:20, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>> On 17:49 Sun 23 Dec     , Roland Stigge wrote:
>>>> This set of patches adds:
>>>>
>>>> * Block GPIO API to gpiolib
>>>> * Sysfs support for GPIO API, to provide userland access
>>>> * Device interface for userland access (alternative to sysfs)
>>>> * Devicetree support to instantiate GPIO blocks via DT
>>>> * Example implementations in several gpio drivers since they need
>>>>   special accessor functions for block wise GPIO access (only for some
>>>>   selected drivers since the feature is optional and not suitable for
>>>>   all GPIO hardware)
>>>> * Fix for race condition in gpiolib on device creation
>>>>
>>>> Signed-off-by: Roland Stigge <stigge@antcom.de>
>>>> Tested by: Wolfgang Grandegger <wg@grandegger.com>
>>>> --
>>>>
>>>> Testing branch available at: git://git.antcom.de/linux-2.6.git blockgpio
>>>>
>>>> Changes since v11:
>>>> * Removed support for at91, since this one is currently in the migration
>>>>   process to pinctrl implementation
>>> already done for 3.8
>>>
>>> in Linus tree
>>
>> Good, thanks for the note! So we include support for block GPIO in
>> pinctrl-at91.c now.
>>
>> I guess the redundant code in arch/arm/mach-at91/gpio.c will be removed?
> no we keep for non DT platform

So would it be helpful it to maintain/mainline Wolfgang's patch for this
one regarding block GPIO? (Besides patching pinctrl-at91.c?)

Thanks,

Roland
