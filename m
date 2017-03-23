From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 23 Mar 2017 14:01:19 +0100
Subject: [PATCH] ARM: gemini: don't select SERIAL_OF_PLATFORM
In-Reply-To: <CAK8P3a24Knn_7zkZz3oO+rshwP9on7Bfz2hWeObYnz7DWYMizQ@mail.gmail.com>
References: <20170321205310.188381-1-arnd@arndb.de>
 <CACRpkdYfi2_Tu+RD+s=xR8pHkp0bQ96pB4BSJdA1bO4kdwku5Q@mail.gmail.com>
 <CAK8P3a24Knn_7zkZz3oO+rshwP9on7Bfz2hWeObYnz7DWYMizQ@mail.gmail.com>
Message-ID: <CACRpkdZ4UWAWnkR7Q9AxVQgbnxB_wkMRNRxT7TDK8Lpm1CfVoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 23, 2017 at 1:13 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Mar 23, 2017 at 11:22 AM, Linus Walleij
> <linus.walleij@linaro.org> wrote:
>> On Tue, Mar 21, 2017 at 9:52 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>>> We cannot select the option when SERIAL_8250 is not also set:
>>>
>>> warning: (ARCH_GEMINI) selects SERIAL_OF_PLATFORM which has unmet direct dependencies (TTY && HAS_IOMEM && SERIAL_8250 && OF)
>>>
>>> This removes the 'select' statement, requiring that users enable the
>>> option manually. Alternatively, we could make it a conditional
>>> 'select SERIAL_OF_PLATFORM if SERIAL_8250' or also select a handful
>>> of other symbols that it depends on.
>>>
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> Will you apply this directly to the interestingly misspelled
>> "gemeni/multiplatform" branch in the ARM SoC tree
>> directly?
>>
>> I will send pull requests on top of that branch later
>> for more features.
>
> If you are going to send more pull requests, just add the fixup there,
> it's not urgent.

OK thanks, I'll queue it.

Yours,
Linus Walleij
