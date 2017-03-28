From: tbaicar@codeaurora.org (Baicar, Tyler)
Date: Tue, 28 Mar 2017 10:44:07 -0600
Subject: [PATCH V13 10/10] arm/arm64: KVM: add guest SEA support
In-Reply-To: <734ab018-2112-eddf-10dc-426f8ebe3848@huawei.com>
References: <1490136425-4324-1-git-send-email-tbaicar@codeaurora.org>
 <1490136425-4324-11-git-send-email-tbaicar@codeaurora.org>
 <20170324160158.GH25903@cbox>
 <734ab018-2112-eddf-10dc-426f8ebe3848@huawei.com>
Message-ID: <e5cf6a5a-eb15-1f32-b9af-785a5ce7627b@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,


On 3/27/2017 10:19 PM, gengdongjiu wrote:
> Hi Tyler,
>
> I have a question for below code.
>
> On 2017/3/25 0:01, Christoffer Dall wrote:
>>   	is_iabt = kvm_vcpu_trap_is_iabt(vcpu);
>> -	if (unlikely(!is_iabt && kvm_vcpu_dabt_isextabt(vcpu))) {
>> +	if (unlikely(!is_iabt && kvm_vcpu_dabt_isextabt(vcpu)) && sea_status) {
>>   		kvm_inject_vabt(vcpu);
> when it is SEA synchronized abort, why here inject a asynchronous abort through kvm_inject_vabt(vcpu) instead of synchronized abort? seem the original kvm source code is also do that, so I am confused about that.
> thanks .
If the SEA was properly handled, then sea_status will avoid injecting 
the vabt. I'm going to just return after the SEA handling in the next 
patch though.

Thanks,
Tyler
>
>>   		return 1;
>>   	}

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
