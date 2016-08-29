From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Mon, 29 Aug 2016 10:22:06 -0500
Subject: [PATCH] arm64: KVM: Save two instructions in __guest_enter()
In-Reply-To: <20160825133122.GA8016@lvm>
References: <1470791736-13949-1-git-send-email-shankerd@codeaurora.org>
 <20160825133122.GA8016@lvm>
Message-ID: <daa6aa0c-27d0-25bd-02fd-4e87e9a908fe@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

This is change may not provide the measurable performance improvement, 
but still we can
save a few cpu cycles on vCPU context switch and also improves the code 
readability.


On 08/25/2016 08:31 AM, Christoffer Dall wrote:
> Hi Shanker,
>
> On Tue, Aug 09, 2016 at 08:15:36PM -0500, Shanker Donthineni wrote:
>> We are doing an unnecessary stack push/pop operation when restoring
>> the guest registers x0-x18 in __guest_enter(). This patch saves the
>> two instructions by using x18 as a base register. No need to store
>> the vcpu context pointer in stack because it is redundant and not
>> being used anywhere, the same information is available in tpidr_el2.
> Does this have any measureable benefit?
>
> Thanks,
> -Christoffer

-- 
Shanker Donthineni
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
