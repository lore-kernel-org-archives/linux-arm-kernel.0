From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 06 Oct 2015 17:41:44 +0100
Subject: [PATCH v3] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
In-Reply-To: <8520D5D51A55D047800579B0941471980169063F@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1444146289-28940-1-git-send-email-bharatku@xilinx.com>
 <5613F310.6060305@arm.com>
 <8520D5D51A55D047800579B0941471980169063F@XAP-PVEXMBX01.xlnx.xilinx.com>
Message-ID: <5613F9C8.9020000@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/15 17:27, Bharat Kumar Gogada wrote:
> Subject: Re: [PATCH v3] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL PCIe Host Controller

[...]

Please use an email client that does proper quoting - I cannot see what
you are replying to. Or at least annotate your answers so that I can
spot them.

>> +struct nwl_msi {			/* struct nwl_msi - MSI information */
>> +	struct msi_controller chip;	/* chip: MSI controller */
> 
>> We're moving away from msi_controller altogether, as the kernel now
>> has all the necessary infrastructure to do this properly.
> 
> Our current GIC version does not have separate msi controller (we are
> not using GICv2m or GICv3), so is it necessary to have separate msi
> controller node ? Please give me clarity on this.

This has nothing to do with the version of the GIC you are using (XGene
doesn't have GICv2m or v3 either). This is about reducing code
duplication and having something that we can maintain. See also
https://lkml.org/lkml/2015/9/20/193 for yet another example.

I still plan to kill msi_controller, and I'd like to avoid more
dependencies with it. MSI domains are the way to do it.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
