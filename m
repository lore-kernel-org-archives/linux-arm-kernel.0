From: okaya@codeaurora.org (Sinan Kaya)
Date: Sat, 1 Oct 2016 11:19:43 -0400
Subject: [PATCH V4 05/10] dmaengine: qcom_hidma: make pending_tre_count
 atomic
In-Reply-To: <20161001061906.GG2467@localhost>
References: <1475115167-5898-1-git-send-email-okaya@codeaurora.org>
 <1475115167-5898-6-git-send-email-okaya@codeaurora.org>
 <20161001061906.GG2467@localhost>
Message-ID: <e5782331-0dc6-9e0e-777c-372dc88f38e3@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/1/2016 2:19 AM, Vinod Koul wrote:
>> Making it atomic so that it can be updated from multiple contexts.
> How is it multiple contexts? It's either existing context of MSI, not both!
> 

I was trying to mean multiple processor contexts here. The driver allocates 11
MSI interrupts. Each MSI interrupt can be assigned to a different CPU. Then, 
we have a race condition for common variables as they share the same interrupt
handler with a different cause bit. 

I will put the above description into the commit text.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
