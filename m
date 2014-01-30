From: cov@codeaurora.org (Christopher Covington)
Date: Thu, 30 Jan 2014 12:43:29 -0500
Subject: [PATCH] arm: document "mach-virt" platform.
In-Reply-To: <1391102149.9495.39.camel@kazak.uk.xensource.com>
References: <1391098262-15944-1-git-send-email-ian.campbell@citrix.com>
 <52EA83D6.9050506@codeaurora.org>
 <1391102149.9495.39.camel@kazak.uk.xensource.com>
Message-ID: <52EA8F41.5060403@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ian,

On 01/30/2014 12:15 PM, Ian Campbell wrote:
> On Thu, 2014-01-30 at 11:54 -0500, Christopher Covington wrote:
>>> +++ b/Documentation/devicetree/bindings/arm/mach-virt.txt
>>> @@ -0,0 +1,32 @@
>>> +* Mach-virt "Dummy Virtual Machine" platform
>>> +
>>> +"mach-virt" is the smallest, dumbest platform possible, to be used as
>>> +a guest for Xen, KVM and other hypervisors.
>>
>> The platform is also useful to, and used by, simulators like QEMU in TCG mode.
> 
> I can mention this, although I don't think the list needs to be
> exhaustive.

Cool, thanks. Agreed, but I thought it'd be nice to list the simulator class.

>                                       It has no
>>> +properties/functionality of its own and is driven entirely by device
>>> +tree.
>>
>> I find this wording confusing. I read it as saying the platform has no
>> properties or functionality. Perhaps you could phrase it slightly differently,
>> such as having no properties or functionality beyond what's described in the
>> device tree.
> 
> Yes, this is what I was trying to say, I'll update with something along
> those lines.
> 
>>> +The platform may also provide hypervisor specific functionality
>>> +(e.g. PV I/O), if it does so then this functionality must be
>>> +discoverable (directly or indirectly) via device tree.
>>
>> I think it would be informative to provide pointers here to commonly used
>> paravirtualized devices, especially VirtIO PCI/MMIO.
> 
> Under what criteria would something be eligible/appropriate to be
> listed? I was trying to avoid "advocating" any particular type of PV
> devices. We already have something of a problem with people incorrectly
> assuming that mach-virt == virtio, which is not the case.

This isn't particularly scientific, but maybe a practical criteria could be
that it's mentioned in this thread? I think if we word the introduction to the
list clearly, readers will know that that these are just a few examples known
to be in use when the binding was written and by no means required. I think
that providing more information is more likely to fix the incorrect assumption
than providing less information.

> If we did want to include an explicit list here at a minimum I would
> also want to include the Xen PV devices as well and surely there would
> be others which ought to be included too.

Yes, I assumed you would include Xen. I'm not aware of any others*, but
perhaps those who do could speak up about them?

(*I do use Angel semihosting and DCC from time to time, but I've never seen
devicetree bindings for these facilities. I'm not sure whether they count in
this context.)

Thanks,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
