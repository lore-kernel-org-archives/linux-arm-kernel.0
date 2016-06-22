From: cov@codeaurora.org (Christopher Covington)
Date: Wed, 22 Jun 2016 09:24:58 -0400
Subject: [PATCH 1/2] arm64: Refactor vDSO time functions
In-Reply-To: <1462797421-33103-2-git-send-email-kevin.brodsky@arm.com>
References: <1462797421-33103-1-git-send-email-kevin.brodsky@arm.com>
 <1462797421-33103-2-git-send-email-kevin.brodsky@arm.com>
Message-ID: <576A91AA.1040608@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On 05/09/2016 08:37 AM, Kevin Brodsky wrote:
> Time functions are directly implemented in assembly in arm64, and it
> is desirable to keep it this way for performance reasons (everything
> fits in registers, so that the stack is not used at all). However, the

Why do you say that? My simple tests indicate passing -O1 to GCC (4.8)
is sufficient to make it only spill to the stack when necessary.

Cheers,
Cov

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
