From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 1 Apr 2016 10:04:57 +0200
Subject: [PATCH] ARM: sa1100: Initialize gpio after gpio subsystem has
 been initialized
In-Reply-To: <20160331162116.GB5605@roeck-us.net>
References: <1459275349-11356-1-git-send-email-linux@roeck-us.net>
 <20160331162116.GB5605@roeck-us.net>
Message-ID: <CACRpkdYg3-XBBCmrKHK5EukEwxU3J4h_4BAKnoVHEiZbFkU5QA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 31, 2016 at 6:21 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Tue, Mar 29, 2016 at 11:15:49AM -0700, Guenter Roeck wrote:
>> The sa1100 gpio driver was initialized from interrupt initialization code,
>> which is earlier than the gpio subsystem is initialized. Since commit
>> ff2b13592299 ("gpio: make the gpiochip a real device"), this is fatal
>> and causes the system to crash.
>>
>> The sa1100 gpio driver must be initialized prior to arch_initcall, since
>> its gpio pins are used in arch_initcall code, but after the gpio subsystem
>> is initialized (core_initcall). Initialize it with postcore_initcall.
>>
>> Fixes: ff2b13592299 ("gpio: make the gpiochip a real device")
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>
> Please ignore/drop this patch - a better (cleaner) fix is in the works
> for gpiolib.

This delivers though. I tested it on my also regressing iPAQ.

Yours,
Linus Walleij
