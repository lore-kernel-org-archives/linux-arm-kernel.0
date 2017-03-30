From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 30 Mar 2017 09:25:11 -0400
Subject: [PATCH V6 5/5] PCI/ASPM: move link_state cleanup to bridge remove
In-Reply-To: <1490828667-30973-6-git-send-email-okaya@codeaurora.org>
References: <1490828667-30973-1-git-send-email-okaya@codeaurora.org>
 <1490828667-30973-6-git-send-email-okaya@codeaurora.org>
Message-ID: <c9bbde75-c976-4f7d-8c31-167f6d173994@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/29/2017 7:04 PM, Sinan Kaya wrote:
>  	if (!parent || !parent->link_state)
>  		return;
>  
> +	if (pdev->has_secondary_link) {
> +		link = pdev->link_state;

I think I accidentally moved the parent check above this code
and broke the case where you can actually remove the root port.

I'll post v7 with reverting this change.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
