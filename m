From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 17 Nov 2017 15:44:47 -0600
Subject: [PATCH 3/4] [v6] pinctrl: qcom: disable GPIO groups with no pins
In-Reply-To: <20171117214207.GA18379@codeaurora.org>
References: <1510096056-13765-1-git-send-email-timur@codeaurora.org>
 <1510096056-13765-4-git-send-email-timur@codeaurora.org>
 <20171117024332.GU11955@codeaurora.org>
 <dff45d26-e9df-6a4f-00a9-7d9ec5cbdf49@codeaurora.org>
 <20171117174617.GA29777@codeaurora.org>
 <2671cc63-6c8b-987d-ceb3-bd158bb9d1c3@codeaurora.org>
 <20171117214207.GA18379@codeaurora.org>
Message-ID: <393b4ba0-237f-5108-b20c-f4e55052e82d@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/17/2017 03:42 PM, Stephen Boyd wrote:
>> Patch 1 prevents gpiolib from accessing GPIOs that haven't been
>> properly requested.
>>
>> Patch 2 adds an infrastructure for sparse GPIO maps
>>
>> Patch 3 updates pinctrl-msm to use that expose that new infrastructure
>>
>> Patch 4 updates pinctrl-qdf2xxx to work with the new feature in pinctrl-msm
>>
> Ok. What path doesn't request the gpio though? If we don't have a
> path that fails to request the gpio before using it then I don't
> see the need for this patch.

Sorry, I don't understand your question.  Patches 2-4 are all about 
creating a sparse GPIO map.  All patch 1 does is stop initializing all 
the GPIOs with an initial direction.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
