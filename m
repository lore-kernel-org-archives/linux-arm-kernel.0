From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 22 Jun 2018 13:03:32 -0500
Subject: [PATCH 1/2] hwrng: msm: add a spinlock and support for blocking
 reads
In-Reply-To: <152968991381.16708.522979730327886581@swboyd.mtv.corp.google.com>
References: <1529594276-12210-1-git-send-email-timur@codeaurora.org>
 <acc7e9d3-8a81-ff15-27c7-78ec7c17f6cc@linaro.org>
 <6d655b97-418e-bacf-7e88-b9179cdc6fd1@codeaurora.org>
 <152968991381.16708.522979730327886581@swboyd.mtv.corp.google.com>
Message-ID: <4bc0afe1-0189-88c0-40aa-23a312325635@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/22/18 12:51 PM, Stephen Boyd wrote:
> Perhaps it's because you implemented the 'wait' functionality in this
> driver? Before the patch there wasn't any sort of wait check so we would
> bail out if there wasn't any data even if the caller requested that we
> wait for randomness to be available.

No, my tests showed the race condition (or at least something that looks 
like a race condition) even without the 'wait' feature.  I added support 
for 'wait' only recently, but I've been working with the crypto people 
for a month on everything else.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
