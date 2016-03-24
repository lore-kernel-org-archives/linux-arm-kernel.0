From: cov@codeaurora.org (Christopher Covington)
Date: Thu, 24 Mar 2016 10:36:48 -0400
Subject: [PATCH 1/2] ARM64:VDSO: Improve gettimeofday, don't use udiv
In-Reply-To: <1457898620-1867-2-git-send-email-apinski@cavium.com>
References: <1457898620-1867-1-git-send-email-apinski@cavium.com>
 <1457898620-1867-2-git-send-email-apinski@cavium.com>
Message-ID: <56F3FB80.50402@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/13/2016 03:50 PM, Andrew Pinski wrote:
> On many cores, udiv with a large value is slow, expand instead
> the division out to be what GCC would have generated for the
> divide by 1000.

This like checking object code into version control. Why not write in C
and let GCC perform the generation?

Thanks,
Cov

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
