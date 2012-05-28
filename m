From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 May 2012 11:33:57 +0100
Subject: amba, tegra-ahb and pci (Kconfig question)
In-Reply-To: <4FC3523A.1030405@codethink.co.uk>
References: <20120528082452.GH24149@n2100.arm.linux.org.uk>
 <20120528081737.GA8031@mail.gnudd.com> <20120528083443.GA8599@mail.gnudd.com>
 <4FC3523A.1030405@codethink.co.uk>
Message-ID: <20120528103357.GJ24149@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 28, 2012 at 11:23:54AM +0100, Ben Dooks wrote:
> On 28/05/12 09:34, Alessandro Rubini wrote:
>>> Normally, ARM_AMBA is selected when required, so this would be:
>>>
>>> config PCI_AMBA
>>> 	bool "PCI-to-AMBA bridge"
>>> 	depends on PCI
>>> 	select ARM_AMBA
>>
>> But this would open the new question in a zillion boards that are
>> not interested in it. It's the board that selects arm-amba, in my opinion.
>>
>>> I guess I should look at moving ARM_AMBA to drivers/amba/Kconfig too...
>>
>> If you want I can submit a patch for this (btw, the rename to primecell
>> is dead, isn't it?)
>
> Would doing a change from ARM_AMBA to AMBA also be useful, or
> adding CONFIG_AMBA and having ARM_AMBA select it?

Why?  There's nothing wrong with the ARM prefix, because the bus is an
ARM design.  And in any case, if we're considering changing the name
we really should change it to be PRIMECELL and not AMBA - and that is
even more of a reason to keep the ARM_ prefix.
