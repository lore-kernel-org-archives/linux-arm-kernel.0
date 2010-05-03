From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 03 May 2010 10:20:02 +0530
Subject: [PATCH V2] ST SPEAr: Adding support for shared irq layer
In-Reply-To: <20100501095649.GD12172@n2100.arm.linux.org.uk>
References: <1272369611-20988-1-git-send-email-viresh.kumar@st.com>
	<4BDA716E.6010009@st.com>
	<20100501095649.GD12172@n2100.arm.linux.org.uk>
Message-ID: <4BDE55FA.2010207@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/1/2010 3:26 PM, Russell King - ARM Linux wrote:
> On Fri, Apr 30, 2010 at 11:28:06AM +0530, Viresh KUMAR wrote:
>> On 4/27/2010 5:30 PM, Viresh KUMAR wrote:
>>> Multiple peripherals in SPEAr share common hardware interrupt lines.
>>> This patch adds support for a shared irq layer, which registers hardware
>>> irqs by itself and exposes virtual irq numbers to peripherals.
>>>
>>> Modifications in V2:
>>> - use get_irq_data instead of get_irq_chip_data
>>> - add support for enabling and clearing interrupt based on machine specific
>>>   implementation. (i.e. It may be required to set/reset a bit in different
>>>   machines for enabling/clearing interrupt.)
>>> - Modified shirq related structures in spear320.c
>>>
>>> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
>>
>> If this patch looks fine, can i send this to russell's patch system.
> 
> Patch looks fine - my only concern is that the IRQ subsystem isn't used
> to decode things like serial status register interrupts.  It's supposed
> to be used to decode the interrupt using the interrupt controllers only.
> 

Russell,

I didn't understood your point clearly. Few weeks back i raised this query
in LKML, and you suggested to implement this layer using irq_chained_handlers.
And this is how it is done in multiple platforms, and GPIO everywhere.

Should i implement it some other way?

viresh.
