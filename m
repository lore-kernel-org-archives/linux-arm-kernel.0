From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 16 May 2018 14:30:20 -0400
Subject: [RFC PATCH] efi/fb: Convert PCI bus address to resource if
 translated by the bridge
In-Reply-To: <1526495029-25783-1-git-send-email-okaya@codeaurora.org>
References: <1526495029-25783-1-git-send-email-okaya@codeaurora.org>
Message-ID: <dd4dfce5-7f7e-824c-999f-b31bbd683f72@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/16/2018 2:23 PM, Sinan Kaya wrote:
> +		if (win_start <= base && win_end >= base + win_size - 1) {
> +			base += window->offset;
> +			break;
> +		}

I should probably add window->offset!=0 to the if statement in order not to
break non-translating case.

Any other comments?

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
