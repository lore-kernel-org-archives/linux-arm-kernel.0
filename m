From: bharat.kumar.gogada@xilinx.com (Bharat Kumar Gogada)
Date: Fri, 9 Oct 2015 05:11:20 +0000
Subject: [PATCH v3] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
In-Reply-To: <5613F9C8.9020000@arm.com>
References: <1444146289-28940-1-git-send-email-bharatku@xilinx.com>
 <5613F310.6060305@arm.com>
 <8520D5D51A55D047800579B0941471980169063F@XAP-PVEXMBX01.xlnx.xilinx.com>
 <5613F9C8.9020000@arm.com>
Message-ID: <8520D5D51A55D047800579B09414719801690CD0@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> +struct nwl_msi {                  /* struct nwl_msi - MSI information
> */
> >> +  struct msi_controller chip;     /* chip: MSI controller */
> >
> >> We're moving away from msi_controller altogether, as the kernel now
> >> has all the necessary infrastructure to do this properly.
> >
> > Our current GIC version does not have separate msi controller (we are
> > not using GICv2m or GICv3), so is it necessary to have separate msi
> > controller node ? Please give me clarity on this.
>
> This has nothing to do with the version of the GIC you are using (XGene
> doesn't have GICv2m or v3 either). This is about reducing code duplication
> and having something that we can maintain. See also
> https://lkml.org/lkml/2015/9/20/193 for yet another example.
>
> I still plan to kill msi_controller, and I'd like to avoid more dependencies with
> it. MSI domains are the way to do it.
>
Sorry previously I haven't configured my email client properly so resending.

Since we don't have separate MSI controller, and our PCIe controller is handling MSI, is it necessary to create a separate MSI controller node because we don't have any 'reg' space.
Please let me know whether we require a separate msi file as suggested in your previous comments to separate MSI controller and PCIE controller in two files, if we don't have separate node.
If we do not need a separate node do we need to embed MSI controller child node  in PCIe controller node itself, and what properties does this child node will require other than 'interrupts'.

Bharat
> Thanks,
>
>       M.
> --
> Jazz is not dead. It just smells funny...


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
