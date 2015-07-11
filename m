From: eric@anholt.net (Eric Anholt)
Date: Fri, 10 Jul 2015 23:01:01 -0700
Subject: [PATCH 3/4] irqchip: Add documentation for the bcm2836 interrupt
 controller.
In-Reply-To: <55A0A251.1010301@wwwdotorg.org>
References: <1436303617-17185-1-git-send-email-eric@anholt.net>
 <1436303617-17185-4-git-send-email-eric@anholt.net>
 <55A0A251.1010301@wwwdotorg.org>
Message-ID: <87io9r9qsi.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> writes:

> On 07/07/2015 03:13 PM, Eric Anholt wrote:
>> This is a new per-cpu root interrupt controller on the Raspberry Pi 2,
>> which will chain to the bcm2835 interrupt controller for peripheral
>> interrupts.
>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2836-l1-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2836-l1-intc.txt
>
>> +local_intc: local_intc {
>
>> +	interrupt-parent = <&local_intc>;
>
> I think that property shouldn't be there?

If you don't have it there, the core finds the interrupt-parent in the
parent node, and waits for that one before initializing (which is in
turn waiting for us).  Note that for original 2835, you're finding the
parent node as well.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150710/89a22ce9/attachment.sig>
