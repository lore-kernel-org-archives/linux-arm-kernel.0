From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 22 Jan 2018 14:13:33 -0500
Subject: [PATCH] PCI/ASPM: Suppress common clock mode setting failure
In-Reply-To: <1516642093-15633-1-git-send-email-okaya@codeaurora.org>
References: <1516642093-15633-1-git-send-email-okaya@codeaurora.org>
Message-ID: <9a557c73-ac13-96b3-2eff-6b3a1ccaa7d6@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/22/2018 12:28 PM, Sinan Kaya wrote:
> +++ b/drivers/pci/pcie/aspm.c
> @@ -253,6 +253,11 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
>  
>  	/* Configure upstream component */
>  	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
> +
> +	/* Port might be already in common clock mode */
> +	if ((same_clock) && (reg16 & PCI_EXP_LNKCTL_CCC))
> +		return;
> +

I think the placement of this statement is too late. I'll move it a couple of lines
and post V2.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
