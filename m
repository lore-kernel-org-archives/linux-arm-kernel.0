From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 3 Apr 2016 18:35:15 +0200
Subject: [PATCH] ARM: sa1100: Initialize gpio after gpio subsystem has
 been initialized
In-Reply-To: <20160401140218.GA14502@roeck-us.net>
References: <1459275349-11356-1-git-send-email-linux@roeck-us.net>
 <20160331162116.GB5605@roeck-us.net>
 <CACRpkdYg3-XBBCmrKHK5EukEwxU3J4h_4BAKnoVHEiZbFkU5QA@mail.gmail.com>
 <20160401140218.GA14502@roeck-us.net>
Message-ID: <CACRpkdYrTCRaeXjjEOripqtqhC-ndqTrht6cByCMBw_iVLsC5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 1, 2016 at 4:02 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Fri, Apr 01, 2016 at 10:04:57AM +0200, Linus Walleij wrote:

>> > Please ignore/drop this patch - a better (cleaner) fix is in the works
>> > for gpiolib.
>>
>> This delivers though. I tested it on my also regressing iPAQ.
>>
> I am a bit concerned that the gpio initialization was that early on purpose,
> and that by moving it we might miss some use cases. I did not find any, but that
> doesn't mean that there are none. Without knowing _why_ the initialization was
> that early, I would prefer not to touch the code if it can be avoided.

I think we'll go for the other patch to gpiolib. It seems much more clean
and generic to support this kind of cases.

Yours,
Linus Walleij
