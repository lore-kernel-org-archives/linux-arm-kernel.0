From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 2 Jul 2018 16:40:10 -0400
Subject: [PATCH V4 4/7] PCI: Unify try slot and bus reset API
In-Reply-To: <CAHp75VcYbeRTiggEiQnEV6DKR=F47RxNR0FZ+E-XKPpq8VNpqw@mail.gmail.com>
References: <1530214274-21139-1-git-send-email-okaya@codeaurora.org>
 <1530214274-21139-4-git-send-email-okaya@codeaurora.org>
 <CAHp75VcYbeRTiggEiQnEV6DKR=F47RxNR0FZ+E-XKPpq8VNpqw@mail.gmail.com>
Message-ID: <9674e845-765c-cc16-654e-21036038f2d5@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/29/2018 5:43 PM, Andy Shevchenko wrote:
>> +int pci_try_reset_bus(struct pci_dev *pdev)
>> +{
>> +       bool slot = false;
>> +
>> +       if (!pci_probe_reset_slot(pdev->slot))
>> +               slot = true;
>> +
>> +       return slot ? __pci_try_reset_slot(pdev->slot) :
>> +                       __pci_try_reset_bus(pdev->bus);
> This can be as simple as
> 
>   return pci_probe_reset_slot(pdev->slot) ?
>     __pci_try_reset_bus(pdev->slot) : __pci_try_reset_slot(pdev->bus);
> 
> 

done

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
