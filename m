From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 26 Sep 2016 10:46:38 -0600
Subject: [PATCH 2/3] gpio: Add a driver for the Raspberry Pi's firmware
 GPIO calls.
In-Reply-To: <87mviy92qw.fsf@eliezer.anholt.net>
References: <20160919161314.25858-1-eric@anholt.net>
 <20160919161314.25858-2-eric@anholt.net>
 <CACRpkda6HpJp97FUAh6yvo-BhiDbAXxzQS9U6uT+jvg6hiB8ag@mail.gmail.com>
 <87mviy92qw.fsf@eliezer.anholt.net>
Message-ID: <25fc865c-ef95-75c7-cf9d-7034572e98b6@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/23/2016 07:15 AM, Eric Anholt wrote:
> Linus Walleij <linus.walleij@linaro.org> writes:
>
>> On Mon, Sep 19, 2016 at 6:13 PM, Eric Anholt <eric@anholt.net> wrote:
>>
>>> This driver will be used for accessing the FXL6408 GPIO exander on the
>>> Pi3.  We can't drive it directly from Linux because the firmware is
>>> continuously polling one of the expander's lines to do its
>>> undervoltage detection.
>>>
>>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> (...)
>>
>>> +config GPIO_RASPBERRYPI
>>> +       tristate "Raspberry Pi firmware-based GPIO access"
>>> +       depends on OF_GPIO && RASPBERRYPI_FIRMWARE && (ARCH_BCM2835 || COMPILE_TEST)
>>> +       help
>>> +         Turns on support for using the Raspberry Pi firmware to
>>> +         control GPIO pins.  Used for access to the FXL6408 GPIO
>>> +         expander on the Pi 3.
>>
>> Maybe it should be named GPIO_RPI_FXL6408 ?
>>
>> (No strong opinion.)
>
> See DT binding comment -- I think since this driver has no dependency on
> being to the 6408 on the pi3, we shouldn't needlessly bind it to the
> FXL6408.  (the help comment was just context for why you would want the
> driver today).

I'd suggest including "FW" or "FIRMWARE" in the Kconfig option too; the 
Raspberry Pi has multiple GPIO drivers; one accessing the BCM283x HW 
directly and the other going through the FW. It'd be good if each 
Kconfig name was pretty explicit re: which one it represented.
