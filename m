From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 28 Jun 2018 15:17:45 -0400
Subject: [PATCH V3 5/6] PCI: Rename pci_try_reset_bus() to pci_reset_bus()
In-Reply-To: <1530210507-9287-5-git-send-email-okaya@codeaurora.org>
References: <1530210507-9287-1-git-send-email-okaya@codeaurora.org>
 <1530210507-9287-5-git-send-email-okaya@codeaurora.org>
Message-ID: <006d7041-6d5c-af10-6252-005978bdc203@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/28/2018 2:28 PM, Sinan Kaya wrote:
> --- a/drivers/infiniband/hw/hfi1/pcie.c
> +++ b/drivers/infiniband/hw/hfi1/pcie.c
> @@ -905,7 +905,7 @@ static int trigger_sbr(struct hfi1_devdata *dd)
>  	 * delay after a reset is required.  Per spec requirements,
>  	 * the link is either working or not after that point.
>  	 */
> -	return pci_try_reset_bus(dev->bus);
> +	return pci_reset_bus(dev->bus);
>  }
>  

This should have been 

return pci_reset_bus(dev);

I'll wait until I hear more feedback.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
