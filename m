From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 13 Jul 2015 23:09:56 -0600
Subject: [PATCH 4/4] irqchip: Add bcm2836 interrupt controller for
 Raspberry Pi 2.
In-Reply-To: <alpine.DEB.2.11.1507110940420.17353@nanos>
References: <1436303617-17185-1-git-send-email-eric@anholt.net>
 <1436303617-17185-5-git-send-email-eric@anholt.net>
 <55A0A5EB.4090007@wwwdotorg.org> <alpine.DEB.2.11.1507110940420.17353@nanos>
Message-ID: <55A499A4.2000809@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11/2015 01:51 AM, Thomas Gleixner wrote:
> On Fri, 10 Jul 2015, Stephen Warren wrote:
>> On 07/07/2015 03:13 PM, Eric Anholt wrote:
>>> +static struct arm_local_intc intc  __read_mostly;
>>
>> It'd be nice to give everything (types, functions, variables) a
>> consistent symbol prefix; bcm2836_arm_irqchip_ sounds like a good
>> bikeshed to me, but perhaps just propagating the above arm_local_ to the
>> functions too would be good, although that seems to risk symbol name
>> collisions with other ARM SoCs.
> 
> Which is irrelevant because its static.

Except if you want to look up a symbol name without having to qualify it
by filename.

Or, does e.g. gdb require statics always be qualified even if they're
globally unique?
