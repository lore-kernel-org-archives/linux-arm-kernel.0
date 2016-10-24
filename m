From: okaya@codeaurora.org (Sinan Kaya)
Date: Sun, 23 Oct 2016 23:48:52 -0400
Subject: [PATCH V4 2/3] Revert "ACPI,PCI,IRQ: remove SCI penalize function"
In-Reply-To: <20161021015814.GC31044@localhost>
References: <1476915664-27231-1-git-send-email-okaya@codeaurora.org>
 <1476915664-27231-3-git-send-email-okaya@codeaurora.org>
 <20161021015814.GC31044@localhost>
Message-ID: <72cf5204-b6cd-d3c0-a354-c1e11dfe7331@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/20/2016 9:58 PM, Bjorn Helgaas wrote:
> I like this patch fine, except for the changelog.  I don't think it's
> useful to describe this as a revert and give all the historical
> details.  I think the important part is something like this:
> 
>   We previously used irq_get_trigger_type(irq) to help compute the
>   penalty for the SCI, but that depends on the SCI having been
>   registered already.  Add acpi_penalize_sci_irq() so platforms can
>   tell us the SCI IRQ, trigger, and polarity so we can compute the
>   penalty even before the SCI has been registered.

OK, will replace with this and also change the commit summary as

"ACPI,PCI,IRQ: save SCI IRQ details for runtime penalty calculation"
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
>> > Link: https://lkml.org/lkml/2016/10/4/283
>> > Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> > Fixes: commit 103544d86976 ("ACPI,PCI,IRQ: reduce resource requirements")
>> > Fixes: commit 9e5ed6d1fb87 ("ACPI,PCI,IRQ: remove SCI penalize function")
> "commit" is redundant; it's sufficient to say:

OK. I have been fighting with checkpatch. Checkpatch doesn't like a commit
summary without "commit 12 char SHA"
> 
>   Fixes: 103544d86976 ("ACPI,PCI,IRQ: reduce resource requirements")
> 
> In fact, I don't think you really need to include "commit" in the
> reference to 9e5ed6d1fb87 above either.
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
