From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 6 Sep 2017 14:00:28 +0100
Subject: [PATCH] arm64: KVM: VHE: save and restore some PSTATE bits
In-Reply-To: <11e22405-1214-3dee-e2d2-f1e10340d0e4@huawei.com>
References: <0184EA26B2509940AA629AE1405DD7F2015DF717@DGGEMA503-MBX.china.huawei.com>
 <2a5d4299-2523-aef5-7db1-f351ca66b562@arm.com>
 <e47a9304-b429-b2bd-f151-d65f1c32044c@huawei.com>
 <981d7334-8841-d3e3-0833-1aa061bf97a2@arm.com>
 <62860a85-c29c-87bb-24b7-c6e5ac6065f9@huawei.com>
 <31b18967-c32a-1761-7e60-15c0de28203c@arm.com>
 <57ba125f-9c3c-3504-35a6-9800a47450cf@huawei.com>
 <b7d8388d-d9df-9cc4-3d07-82e7f807017a@arm.com>
 <11e22405-1214-3dee-e2d2-f1e10340d0e4@huawei.com>
Message-ID: <c334eba3-532e-e8af-7512-8ef4acf665b3@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/09/17 13:44, gengdongjiu wrote:
> 
> 
> On 2017/9/6 20:30, Vladimir Murzin wrote:
>> On 06/09/17 13:14, gengdongjiu wrote:
>>>
>>>
>>> On 2017/9/6 20:00, Vladimir Murzin wrote:
>>>> On 06/09/17 11:35, gengdongjiu wrote:
>>>>> Vladimir,
>>>>>
>>>>> On 2017/9/6 17:41, Vladimir Murzin wrote:
>>>>>> Can you please elaborate on cases where PAN is not enabled?
>>>>>
>>>>> I mean the informal private usage, For example, he disabled the PAN dynamically to let kernel space to access the user space.
>>>>> After he dynamic disabled the PAN, then switched to guest OS. after return to host. he found the PAN stage is modified.
>>>>> Of cause this is not a formal usage, in our host kernel, it is always enabled, no dynamic change, but I means it may exist such cases.
>>>>>
>>>>>
>>>>
>>>> So, in short, there is no real issue with PAN, right? What about UAO?
>>> For the PAN, if host OS dynamically enable/disable PAN should have issue.
>>> Do you think that is not a issue as above description?
>>>
>>> "host OS dynamically disable the PAN, but after go back from the guest OS, The PAN is unexpectedly enabled"
>>
>> Do you see effect of "PAN is unexpectedly enabled"?
> In fact I did not encounter this case, but I think it can exist.
> I think if host OS dynamically disable PAN, it wants the host kernel access the user space address space not through copy_to/from_user API.
> Now if it is unexpectedly enabled, when host kernel still accesses the user space address,  it will happen MMU fault exception.

And this is expected! The only allowed channel for kernel <-> user is uaccess
API.

I guess that you have test (and that great!) which violates that rule (for
testing purpose, why not?) and now you are trying to fit kernel into it...

Cheers
Vladimir

> 
> 
>>
>> Cheers
>> Vladimir
>>
>>>
>>>>
>>>> Cheers
>>>> Vladimir
>>>>
>>>> .
>>>>
>>>
>>>
>>
>>
>> .
>>
> 
> 
