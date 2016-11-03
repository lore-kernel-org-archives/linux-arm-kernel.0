From: sricharan@codeaurora.org (Sricharan)
Date: Fri, 4 Nov 2016 03:55:45 +0530
Subject: [PATCH V3 0/8] IOMMU probe deferral support
References: <1475600632-21289-1-git-send-email-sricharan@codeaurora.org>
 <60ee8066-f167-e9df-ae3e-4138f1133bad@arm.com>
 <003a01d22f97$82534c70$86f9e550$@codeaurora.org>
 <421e2b14-0231-d376-02a0-097423120b3d@arm.com>
Message-ID: <003801d23621$3cb91970$b62b4c50$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

>>>> [   39.901592] iommu: Removing device 0000:08:00.0 from group 0
>>
>>Yikes, on second look, that definitely shouldn't be happening.
>>Everything below is probably the resulting fallout.
>
>[   40.206703] vfio-pci 0000:08:00.0: Failed to setup iommu ops
>
>I think the above print which says "failed to setup iommu_ops"
>because the call ops->add_device failed in of_pci_iommu_configure
>is the reason for the failure, in my case i simply do not get this even with
>your scripts. ops->add_device succeeds in the rebind as well. So still
>checking what could be happening in your case.

I was looking at your code base from [1].The ops->add_device
callback from of_pci_iommu_configure on the rebind is the
one which is causing the failure. But not able to spot out
from code which point is causing the failure. It would be very helpful
if i can know which is the return value from the add_device callback
or point inside add_device callback which fails in your setup.


[1] git://linux-arm.org/linux-rm iommu/misc
>
>
>Regards,
>  Sricharan
>
