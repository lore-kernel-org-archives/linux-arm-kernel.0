From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 1 Sep 2016 20:25:35 -0400
Subject: [PATCH 2/2] PCI: add CRS support to error handling path
In-Reply-To: <1472770801-30671-2-git-send-email-okaya@codeaurora.org>
References: <1472770801-30671-1-git-send-email-okaya@codeaurora.org>
 <1472770801-30671-2-git-send-email-okaya@codeaurora.org>
Message-ID: <95c0239b-76ef-aa95-0101-bcdb39ef1544@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/1/2016 7:00 PM, Sinan Kaya wrote:
>  	pcibios_reset_secondary_bus(dev);
>  	pci_bus_restore(dev->bus);
> +	pci_bus_probe_crs(dev->subordinate);
>  }

I should have done this instead.

  	pcibios_reset_secondary_bus(dev);
 +	pci_bus_probe_crs(dev->subordinate);
  	pci_bus_restore(dev->bus);

I can fix it on the next version. Looking forward to feedback.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
