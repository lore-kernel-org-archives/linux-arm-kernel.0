From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 05 Jan 2014 14:32:00 +0100
Subject: [PATCH v2 2/4] ARM: sunxi: Add ahci-sunxi driver for the Allwinner
 SUNXi SoCs sata
In-Reply-To: <52C9534E.4000701@schinagl.nl>
References: <1388826878-5602-1-git-send-email-hdegoede@redhat.com>
 <1388826878-5602-3-git-send-email-hdegoede@redhat.com>
 <4502242.kKUgLAVDcb@wuerfel> <3250214.yUrU0CPosZ@wuerfel>
 <52C9534E.4000701@schinagl.nl>
Message-ID: <52C95ED0.5060207@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/05/2014 01:42 PM, Olliver Schinagl wrote:
> On 01/04/14 22:47, Arnd Bergmann wrote:
>> On Saturday 04 January 2014 22:39:50 Arnd Bergmann wrote:
>>>> +Required properties:
>>>> +- compatible : compatible list, contains "allwinner,sun4i-a10-ahci"
>>>> +- reg                : <registers mapping>
>>>> +- interrupts : <interrupt mapping for AHCI IRQ>
>>>> +- clocks     : clocks for ACHI
>>>> +- clock-names        : clock names for AHCI
>>> The binding needs to specify the required names for the clocks.
>> fwiw, the imx driver uses "ahb" and "sata_ref" as the clock names.
>> I would strongly suggest using the same names here, and documenting
>> them in the ahci binding as optional.
> This is my fault, and you just reminded me I should have fixed that from the previous comments. It just slipped my mind and I'm sorry for that!
>
> Hans, I'll go over the original commit thread and pick up all changes and send them as a patch to you Monday.

As I just mentioned to Arnd I've a better idea to be able to re-use most of
the ahci_platform.c code without copy-pasting it. So I'm going to do a v3
soonish. Can you please just make a mail with summary of the requested
changes and send that to me, or do this after I've send v3 ?

Thanks,

Hans
