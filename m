From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 13 Jul 2017 17:09:55 -0400
Subject: [PATCH v7 2/3] PCI: Enable PCIe Relaxed Ordering if supported
In-Reply-To: <1499955692-26556-3-git-send-email-dingtianhong@huawei.com>
References: <1499955692-26556-1-git-send-email-dingtianhong@huawei.com>
 <1499955692-26556-3-git-send-email-dingtianhong@huawei.com>
Message-ID: <e496ff1d-b836-ebef-fdf7-76273aaaaef6@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/13/2017 10:21 AM, Ding Tianhong wrote:
> static void pci_configure_relaxed_ordering(struct pci_dev *dev)
> +{
> +	/* We should not alter the relaxed ordering bit for the VF */
> +	if (dev->is_virtfn)
> +		return;
> +
> +	/* If the releaxed ordering enable bit is not set, do nothing. */
> +	if (!pcie_relaxed_ordering_supported(dev))
> +		return;
> +
> +	if (pci_dev_should_disable_relaxed_ordering(dev)) {
> +		pcie_clear_relaxed_ordering(dev);
> +		dev_info(&dev->dev, "Disable Relaxed Ordering\n");
> +	}
> +}

I couldn't find anywhere where you actually enable the relaxed ordering
like the subject suggests.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
