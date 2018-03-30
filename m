From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 30 Mar 2018 10:46:05 -0400
Subject: [PATCH] io: prevent compiler reordering on the default writeX()
 implementation
In-Reply-To: <1522420199-23548-1-git-send-email-okaya@codeaurora.org>
References: <1522420199-23548-1-git-send-email-okaya@codeaurora.org>
Message-ID: <4e3acc1a-0c06-5b1b-1b87-91bef2daae38@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/30/2018 10:29 AM, Sinan Kaya wrote:
> In the abscence of a write barrier or when using a strongly ordered
> architecture, writeX() should at least have a compiler barrier in
> it to prevent commpiler from clobbering the execution order.

Same is true for readX(). I'll wait for review feedback on this before
posting another change for readX().

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
