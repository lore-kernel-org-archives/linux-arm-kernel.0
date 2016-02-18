From: eric@anholt.net (Eric Anholt)
Date: Wed, 17 Feb 2016 20:09:23 -0800
Subject: [PATCH V2 3/8] dmaengine: bcm2835: use shared interrupt for
 channel 11 to 14.
In-Reply-To: <1452187987-2605-4-git-send-email-kernel@martin.sperl.org>
References: <1452187987-2605-1-git-send-email-kernel@martin.sperl.org>
 <1452187987-2605-4-git-send-email-kernel@martin.sperl.org>
Message-ID: <87ziuywtfw.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kernel at martin.sperl.org writes:

> From: Martin Sperl <kernel@martin.sperl.org>
>
> The bcm2835 dma channel 11 to 14 only have a single shared irq line,
> so this patch implements shared interrupts for these channels.
>
> To avoid changes to the device tree (with regards to interrupts listed,
> which reflects on pdev->num_resources) a fixed channel count had
> to get used in the code instead.
>
> With this patch applied we now have 11 dma channels available to
> the ARM side of the SOC.
>
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>

Particularly given the existing DT bindings we have, I actually think
this is a good way to go.  This is internal to the hardware module about
how its features map to interrupt lines that leave the hardware module
(which are exposed in DT appropriately).

I thought about "what if we had the last interrupt line hooked up to a
different interrupt handler that read out and decided which channels to
wake up", but this seems much simpler.

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160217/ca03aa66/attachment.sig>
