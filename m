From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 28 Mar 2013 19:20:17 +0100
Subject: [PATCH 1/2] ARM: irq: Call irqchit_init if no init_irq function
 is specified
In-Reply-To: <201303281549.49990.arnd@arndb.de>
References: <1364463704-13692-1-git-send-email-maxime.ripard@free-electrons.com>
 <201303281525.42334.arnd@arndb.de>
 <20130328153617.GC3368@n2100.arm.linux.org.uk>
 <201303281549.49990.arnd@arndb.de>
Message-ID: <515489E1.6070409@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 28/03/2013 16:49, Arnd Bergmann a ?crit :
> On Thursday 28 March 2013, Russell King - ARM Linux wrote:
>> On Thu, Mar 28, 2013 at 03:25:42PM +0000, Arnd Bergmann wrote:
>>>       if (IS_DEFINED(CONFIG_OF) && !machine_desc->init_irq)
>>>               irqchip_init();
>>>       else
>>>               machine_desc->init_irq();
>>>
>>> to the same effect.
>>
>> Provided irqchip_init() keeps its prototype visible, then yes.
> 
> Yes, I checked that before my reply. We have a few function declarations
> that are unfortunately completely hidden when some config symbol is not
> defined, but this is not one of them.

I'll send a v2 with the suggested change.

Thanks!
Maxime


-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
