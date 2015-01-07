From: lauraa@codeaurora.org (Laura Abbott)
Date: Wed, 07 Jan 2015 09:55:43 -0800
Subject: [PATCH] kernel/module.c: Mark module state before set RO and
 NX regions
In-Reply-To: <878uhf4457.fsf@rustcorp.com.au>
References: <1420535256-6091-1-git-send-email-js07.lee@gmail.com>
 <878uhf4457.fsf@rustcorp.com.au>
Message-ID: <54AD731F.3080408@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/6/2015 8:16 PM, Rusty Russell wrote:
> Jungseung Lee <js07.lee@gmail.com> writes:
>> In some architectures like arm/arm64, set_memory_*() check module address
>> and state as well. Mark module state before set RO and NX regions for
>> the routine is passed.
>>
>> It will fix wrong RO/NX protection for loadable kernel modules on arm/arm64.
>
> This partially reverts commit 4982223e51e8ea9d09bb33c8323b5ec1877b2b51
> Author: Rusty Russell <rusty@rustcorp.com.au>
> Date:   Wed May 14 10:54:19 2014 +0930
>
>      module: set nx before marking module MODULE_STATE_COMING.
>
> Laura Abbott (CC'd) was looking at an alternative fix for this.  Laura?
>
> Thanks,
> Rusty.
>

Yes, my proposal was to stop using is_module_address and just bounds
check against the module ranges[1]. I got bogged down with other
tasks and hadn't submitted a patch for review yet.

Thanks,
Laura

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/311574.html


-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
