From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 7 Apr 2017 12:51:01 -0400
Subject: [PATCH] scsi: mpt3sas: remove redundant wmb on arm/arm64
In-Reply-To: <1491583306-20551-1-git-send-email-okaya@codeaurora.org>
References: <1491583306-20551-1-git-send-email-okaya@codeaurora.org>
Message-ID: <a335dc48-45e0-bfde-87df-f6931889325b@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/7/2017 12:41 PM, Sinan Kaya wrote:
> The right thing was to either call __raw_writel/__raw_readl or
> write_relaxed/read_relaxed for multi-arch compatibility.

One can also argue to get rid of wmb(). I can go either way based
on the recommendation.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
