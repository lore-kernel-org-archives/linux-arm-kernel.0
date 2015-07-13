From: fainelli@broadcom.com (Florian Fainelli)
Date: Mon, 13 Jul 2015 10:35:57 -0700
Subject: [PATCH v3 2/4] dt-bindings: brcmstb-gpio: document properties
 for wakeup
In-Reply-To: <CACRpkdY5YH7MwGxA_UFg1bzwojT6XouBErBm86PtL_8RCSej0Q@mail.gmail.com>
References: <1434589243-502-1-git-send-email-gregory.0xf0@gmail.com>	<1434589243-502-3-git-send-email-gregory.0xf0@gmail.com>
 <CACRpkdY5YH7MwGxA_UFg1bzwojT6XouBErBm86PtL_8RCSej0Q@mail.gmail.com>
Message-ID: <55A3F6FD.1070006@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/07/15 05:29, Linus Walleij wrote:
> On Thu, Jun 18, 2015 at 3:00 AM, Gregory Fong <gregory.0xf0@gmail.com> wrote:
> 
>> Some brcmstb GPIO controllers can be used to wake from suspend, so use
>> the de facto standard property 'wakeup-source' to mark the nodes of
>> controllers with that capability.
>>
>> Also document interrupts-extended, which will be used for wakeup
>> handling because the interrupt parent for the wake IRQ is different
>> from the regular IRQ.
>>
>> While we're at it, a few more fixes: We don't actually use the
>> "interrupt-names" property, so remove it from the listed optional
>> properties and from the examples.  And since we're modifying the
>> examples, also follow Brian's suggestions to:
>> - change #gpio-cells, #interrupt-cells, and brcm,gpio-bank-widths from
>>   hex to dec
>> - use phandles
>>
>> Reviewed-by: Brian Norris <computersforpeace@gmail.com>
>> Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>
>> ---
>> v3: Update per Brian's suggestions described in above message.
> 
> I'm very uncertain regarding these interrupts-extended etc.

Gregory's additions to the binding are correct and comply with how the
'interrupts-extended' property is meant to be used. FYI, this is
required because most wake-up capable HW on brcmstb chips have N
interrupts feeding to a GIC, but their wake-up interrupt(s) feed to an
always-on interrupt controller. With the 'interrupts' +
'interrupt-parent' property, you can "cross" multiple interrupt domains.

The precedence and rules for interpreting the "legacy" interrupts
property vs. interrupts-extended is documented in the tree.

> 
> Can someone who understands that ACK this?

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> 
> E.g. Grant Likely, Bj?rn Helgaas, Rob Herring.
> 
> Yours,
> Linus Walleij
> 


-- 
Florian
