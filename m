From: okaya@codeaurora.org (Sinan Kaya)
Date: Sun, 6 Aug 2017 22:59:49 -0400
Subject: [PATCH V8 1/2] PCI: handle CRS returned by device after FLR
In-Reply-To: <1502071792-15263-1-git-send-email-okaya@codeaurora.org>
References: <1502071792-15263-1-git-send-email-okaya@codeaurora.org>
Message-ID: <b841281a-cb6c-dfb2-001c-bc13a261c741@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/6/2017 10:09 PM, Sinan Kaya wrote:
> +	pcie_capability_read_word(dev, PCI_EXP_RTCAP, &root_cap);
> +	if (root_cap & PCI_EXP_RTCAP_CRSVIS) {
> +		/* don't touch the HW before waiting 100ms */
> +		msleep(100);

This is obviously broken. I should have checked the capability
on the root port. I was trying to get it out before Monday.

However, I still want to hear about the preference of this
methodology.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
