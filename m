From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 25 Nov 2015 09:56:14 +0000
Subject: [PATCH v9] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
In-Reply-To: <CABHD4K9PH-1tpwmxmPSBK3dW04G3XMfNtPFqtWFb7gnThe=uNQ@mail.gmail.com>
References: <1447911323-12567-1-git-send-email-bharatku@xilinx.com>
 <20151124173556.18aff6b5@arm.com>
 <8520D5D51A55D047800579B0941471982586607F@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20151125075018.68e97010@arm.com>
 <CABHD4K9PH-1tpwmxmPSBK3dW04G3XMfNtPFqtWFb7gnThe=uNQ@mail.gmail.com>
Message-ID: <20151125095614.523cd8b7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 25 Nov 2015 14:23:29 +0530
Amit Tomer <amittomer25@gmail.com> wrote:

> Sorry to intervene but just trying to learn from your comments.
> 
>  > You have plenty, and that's the whole of your device space. *All of it*. So
> >   just take the base address of your PCIe controller, and be done with
> >   it.
> 
> but isn't few of PCIe controller's registers itself are mapped
> here(base address). So, how can we use this address for MSI?

You can, because the PCIe controller never writes to itself. If it
writes to that base address, then it *is* the MSI doorbell and the
bridge will hopefully do the right thing.

> Or you said from base address of PCIe controller, find an offset that
> can be used as MSI address?

That works as well. Given the description of the HW we've been given,
any address will do, as long as it is behind the PCIe RC.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
