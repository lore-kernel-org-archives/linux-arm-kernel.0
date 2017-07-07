From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 7 Jul 2017 11:07:10 -0400
Subject: [PATCH V2] PCI: Do not enable extended tags on pre-dated (v1.x)
 systems
In-Reply-To: <1499439193-16628-1-git-send-email-okaya@codeaurora.org>
References: <1499439193-16628-1-git-send-email-okaya@codeaurora.org>
Message-ID: <f95ae702-1b7b-b2d4-72bd-0518badfefbc@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/7/2017 10:53 AM, Sinan Kaya wrote:
> +	ret = pcie_capability_read_word(dev, PCI_EXP_FLAGS, &flags);
> +	if (ret || ((flags & PCI_EXP_FLAGS_VERS) < 2))
> +		return 0;
>  

Never mind, there is a problem here. I shouldn't have added it here.
I'll remove these and post again.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
