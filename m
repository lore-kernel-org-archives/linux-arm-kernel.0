From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 08 Apr 2013 16:16:15 -0600
Subject: [PATCH 1/1] of/irq: store IRQ trigger/level in struct resource
 flags
In-Reply-To: <51633F26.7000400@gmail.com>
References: <1365148088-11175-1-git-send-email-javier.martinez@collabora.co.uk>
 <51633F26.7000400@gmail.com>
Message-ID: <516341AF.7030207@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08/2013 04:05 PM, Rob Herring wrote:
> On 04/05/2013 02:48 AM, Javier Martinez Canillas wrote:
>> According to Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>> the "#interrupt-cells" property of an "interrupt-controller" is used
>> to define the number of cells needed to specify a single interrupt.
...
>> But the type is never returned so it can't be saved on the IRQ struct
>> resource flags member.
>>
>> This means that drivers that need the IRQ type/level flags defined in
>> the DT won't be able to get it.
> 
> But the interrupt controllers that need the information should be able
> to get to it via irqd_get_trigger_type. What problem exactly are you
> trying to fix? What driver would use this?

FYI, that is indeed what I did in sound/soc/codecs/wm8903.c. Thinking
back, I'm not sure if that was the right thing or whether I should have
sent this same patch:-)
