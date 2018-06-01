From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 1 Jun 2018 14:58:48 -0400
Subject: [PATCH V2] PCI: move early dump functionality from x86 arch into
 the common code
In-Reply-To: <20180601185310.GA175802@bhelgaas-glaptop.roam.corp.google.com>
References: <1527878854-21419-1-git-send-email-okaya@codeaurora.org>
 <20180601185310.GA175802@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <dac3d600-86c4-456a-046b-f2229a8c19d7@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/1/2018 2:53 PM, Bjorn Helgaas wrote:
>> +	pci_info(pdev, "pci 0000:%02x:%02x.%d config space:\n",
>> +		 pdev->bus->number, PCI_SLOT(pdev->devfn),
>> +		 PCI_FUNC(pdev->devfn));
> I'm still missing something -- why go to the trouble of pdev->bus->number,
> PCI_SLOT(), etc?  Isn't the output going to look like this?
> 
>   pci 0000:00:00.0: pci 0000:00:00.0 config space:
> 
> In other words, wouldn't the following be enough?
> 
>   pci_info(pdev, "config space:\n");
> 

You are right. The origin print function was pr_info. We don't need that
stuff anymore. 

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
