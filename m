From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 6 May 2014 01:58:10 -0700
Subject: [PATCH] ARM: at91: localize GPIO header
In-Reply-To: <20140505035609.GA11035@quad.lixom.net>
References: <1395924553-5387-1-git-send-email-linus.walleij@linaro.org>
 <20140505035609.GA11035@quad.lixom.net>
Message-ID: <5368A422.2000100@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/2014 20:56, Olof Johansson :
> On Thu, Mar 27, 2014 at 01:49:13PM +0100, Linus Walleij wrote:
>> This moves the <mach/gpio.h> header in the AT91 platform down
>> into the machine directory and removes the reliance on
>> MACH_NEED_GPIO_H from the AT91.
>>
>> This does not move the platform to GENERIC_GPIO but localize
>> the remaining work to be done for this to the mach-at91
>> folder.
>>
>> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> This version is rebased on top of the timex-remove branch in
>> the ARM SoC tree. I have done a few trial compilations with the
>> defconfigs after rebasing but more may still be needed. IIRC
>> one of the board files is now removed from the mainline kernel
>> so there will be some simple merge conflict wherever it gets
>> merged.
>>
>> If you're happy with this I'd suggest applying it directly in
>> the ARM SoC tree.
> 
> Looks like this one didn't make it for 3.15 given timing. Want to respin for
> 3.16 to handle the above conflicts and send to Nicolas?

I already did it actually no need to worry Linus: It sits in my
at91-3.16-cleanup branch that I didn't send to arm-soc yet.

I'll try to collect all "cleanup" stuff today or tomorrow and send the
pull-request soon.

Thanks for the heads-up Olof.

Bye,
-- 
Nicolas Ferre
