From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Thu, 23 Feb 2017 15:05:42 -0600
Subject: [PATCH v2] arm64: Fix the kernel panic() on QDF2400 platform
In-Reply-To: <4d97310a-4b91-07ac-1ce0-faacb8da03b0@codeaurora.org>
References: <1487880125-1371-1-git-send-email-shankerd@codeaurora.org>
 <4d97310a-4b91-07ac-1ce0-faacb8da03b0@codeaurora.org>
Message-ID: <3fb32277-9d9e-c84d-4e98-c19ace690433@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/23/2017 02:46 PM, Timur Tabi wrote:
> On 02/23/2017 02:02 PM, Shanker Donthineni wrote:
>> The commit 38fd94b0275c 'arm64: Work around Falkor erratum 1003' has
>> been added to fix the hardware bug but causing a system crash. The
>
> "causes"
>
>> value of the register x1 which contains 'struct mm_struct *' should
>> be preserved inside macro pre_ttbr0_update_workaround.
>
> The subject line seems a bit vague and alarmist to me.  In my opinion, 
> this is more descriptive:
>
> arm64: qcom: pre_ttbr0_update_workaround should not clobber register x1
>
>
Why do you want keep 'pre_ttbr0_update_workaround' in subject, nothing 
wrong with macro definition itself. Problem with the caller, not passing 
the right arguments.

-- 
Shanker Donthineni
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
