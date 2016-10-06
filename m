From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 6 Oct 2016 18:11:49 -0400
Subject: [PATCH] Revert "debugfs: ->d_parent is never NULL or negative"
In-Reply-To: <ead77f2f-ec0f-f31a-428c-9671faaa30f9@codeaurora.org>
References: <1475789429-11414-1-git-send-email-okaya@codeaurora.org>
 <20161006213734.GM19539@ZenIV.linux.org.uk>
 <f6ba2bf7-4f0b-e874-d642-6620d5df2212@codeaurora.org>
 <ead77f2f-ec0f-f31a-428c-9671faaa30f9@codeaurora.org>
Message-ID: <0a4ae5f1-e665-365e-d9d7-f73ad560ea97@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/6/2016 5:56 PM, Sinan Kaya wrote:
> The fact that directory is removed might be leaving the stats in limbo.
> 
> Let me test without this line.

This did the trick. Thanks for the heads up. The second line was a left over
from the code review. I was removing files piece by piece at the beginning. 
Then, somebody said why don't you use recursive. While changing it to recursive,
I forgot to remove the second line.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
