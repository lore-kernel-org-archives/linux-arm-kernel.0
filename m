From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 15 Mar 2018 21:13:10 -0400
Subject: [PATCH v2 5/6] ixgbevf: keep writel() closer to wmb()
In-Reply-To: <1521162296-19729-6-git-send-email-okaya@codeaurora.org>
References: <1521162296-19729-1-git-send-email-okaya@codeaurora.org>
 <1521162296-19729-6-git-send-email-okaya@codeaurora.org>
Message-ID: <98853dc0-694d-ab29-bf16-54fc5a05c7b8@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/15/2018 9:04 PM, Sinan Kaya wrote:
>  	/* notify HW of packet */
> -	ixgbevf_write_tail(tx_ring, i);
> +	writel(value, tx_ring->tail);
>  

oops. copy paste mistake. 

I'll hold onto posting v3 until i hear more feedback.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
