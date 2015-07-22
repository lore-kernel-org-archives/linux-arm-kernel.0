From: eric@anholt.net (Eric Anholt)
Date: Wed, 22 Jul 2015 11:17:20 -0700
Subject: [PATCH v2 2/4] irqchip: bcm2835: If a parent interrupt is
 registered, chain from it.
In-Reply-To: <55AEFB1D.6090108@wwwdotorg.org>
References: <1436837718-956-1-git-send-email-eric@anholt.net>
 <1436837718-956-3-git-send-email-eric@anholt.net>
 <55AEFB1D.6090108@wwwdotorg.org>
Message-ID: <87bnf4giq7.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> writes:

> On 07/13/2015 07:35 PM, Eric Anholt wrote:
>> The BCM2836 (Raspberry Pi 2) uses two levels of interrupt handling
>> with the CPU-local interrupts being the root, so we need to register
>> ours as chained off of the CPU's local interrupt.
>
> Sorry for the slow review; laziness after vacation!
>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
>
>> +The BCM2836 contains the same interrupt controller with the same
>> +interrupts, but the per-CPU interrupt controller is the root, and an
>> +interrupt there indicates that the ARMCTRL has an interrupt to handle.
>> +
>>  Required properties:
>>  
>>  - compatible : should be "brcm,bcm2835-armctrl-ic"
>
> Since there are some differences between the bcm2835 and bcm2836 HW
> blocks, I'd expect the compatible value to be different for each. In
> particular...

Well, there are actually no differences within this block of the HW (HDL
is unmodified), it's just where the output interrupt line gets consumed.
But it's not much extra to add a new compatible value, so sure.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150722/0c8559aa/attachment.sig>
