From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 18 Mar 2015 02:39:21 +0100
Subject: [PATCH v6 6/8] pinctrl: cygnus: add gpio/pinconf driver
In-Reply-To: <CACRpkdZbxTyYWpxWCmdN8a7p+MjcUo6UxEwfgStPWsNzf4NZ=g@mail.gmail.com>
References: <1425933902-20652-1-git-send-email-rjui@broadcom.com>
 <1425933902-20652-7-git-send-email-rjui@broadcom.com>
 <CACRpkdZ1ErfikdF41aANTM-7LE6AExizHtCZTq1_TTxwYjeSQA@mail.gmail.com>
 <54FF306C.7020407@broadcom.com>
 <CACRpkdZbxTyYWpxWCmdN8a7p+MjcUo6UxEwfgStPWsNzf4NZ=g@mail.gmail.com>
Message-ID: <CACRpkdYhMw36xrqptbd8b7KpkVyrZMW_nkxQTPcGkQvt3z3w=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 11, 2015 at 10:15 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Tue, Mar 10, 2015 at 6:57 PM, Ray Jui <rjui@broadcom.com> wrote:
>> On 3/10/2015 3:20 AM, Linus Walleij wrote:
>>> On Mon, Mar 9, 2015 at 9:45 PM, Ray Jui <rjui@broadcom.com> wrote:
>>>
>>>> This adds the initial support of the Broadcom Cygnus GPIO/PINCONF driver
>>>> that supports all 3 GPIO controllers on Cygnus including the ASIU GPIO
>>>> controller, the chipCommonG GPIO controller, and the always-on GPIO
>>>> controller. Basic PINCONF configurations such as bias pull up/down, and
>>>> drive strength are also supported in this driver.
>>>>
>>>> Pins from the ASIU GPIO controller can be individually muxed to GPIO
>>>> function, through interaction with the Cygnus IOMUX controller
>>>>
>>>> Signed-off-by: Ray Jui <rjui@broadcom.com>
>>>> Reviewed-by: Scott Branden <sbranden@broadcom.com>
>>>> Tested-by: Dmitry Torokhov <dtor@chromium.org>
>>>
>>> Patch applied! But please look at this:
>>>
>>>> +#include <linux/gpio.h>
>>>
>>> Doesn't just #include <linux/gpio/driver.h> work?
>>>
>>
>> I think I need linux/gpio.h for gpiochip_add_pin_range and some related
>> APIs.
>
> OK you're right ... I need to fix this.

I sent a patch fixing this now... hope it will work.

Yours,
Linus Walleij
