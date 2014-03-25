From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 25 Mar 2014 10:37:00 +0100
Subject: [PATCH] ARM: ux500: remove pointless cache setup args
In-Reply-To: <20140321140308.GJ7528@n2100.arm.linux.org.uk>
References: <1395410113-19965-1-git-send-email-linus.walleij@linaro.org>
 <20140321140308.GJ7528@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdapfLCMp_wpkybVXLhtHPRMX2Yo49M-BxAXyAK7HySeSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 21, 2014 at 3:03 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Mar 21, 2014 at 02:55:13PM +0100, Linus Walleij wrote:
>> This removes the setup of the l2x0 lines that are essentially
>> just noops bouncing on the hardware as the cache registers are
>> protected in the secure world and there is no point in writing
>> them. Put in (0, ~0) to the l2x0_of_init() function as
>> suggested by Russell and cut the complex code out.
>>
>> Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> Russell: I don't know how this fits with other changes hitting
>> the l2x0 code, this file is pretty much stand-alone and
>> orthogonal to any other stuff hitting the Ux500 code, so I
>> can put it in your patch tracker if you want to take it or
>> some version of it into your tree.
>
> I already have something which does a similar modification.  Here's
> the existing commits in order (copy'n'pasted with gpm so whitespace
> damaged):

All looking good, Acked-by.

I can do any additional cleanups on top of this once it
lands upstream.

Yours,
Linus Walleij
