From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 28 Nov 2017 14:37:39 +0000
Subject: [question] extract the feature bits width to 4
In-Reply-To: <e110a4fa-2537-9ac0-0dc1-dded5d88f34f@huawei.com>
References: <17ab0a11-7ca2-ff22-35d6-7446dbccc3ea@huawei.com>
 <f9d9af3e-e7c0-88fe-156e-a7969ca7394f@arm.com>
 <e110a4fa-2537-9ac0-0dc1-dded5d88f34f@huawei.com>
Message-ID: <82d7525a-558e-619a-4235-c20d6011f7cf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/11/17 12:38, gengdongjiu wrote:
> 
> On 2017/11/28 19:40, Suzuki K Poulose wrote:
>> Cc: linux-arm-kernel
>>
>> On 28/11/17 11:17, gengdongjiu wrote:
>>> Hi,suzuki/mark,
>>
>> Hello!
>>
>> Please Cc linux-arm-kernel mailing list in the future for any arm/arm64 kernel
>> related queries.
> Thanks a lot for the reply, Ok
> 
>>
>>>
>>>  ?? very sorry to disturb you, I have a question that want to consult with you. For the CPU feature detection,
>>> why we use extract 4 bits width for the feature match instead of the actual bits number[1]?? may be the actual hardware feature bit more than 4 bits.
>>
>>
>> There are features which could be more or less than 4bit wide. However,
>> all the arm64_cpu_capabilities features are 4bits and hence the hard coded
>> bits there. If we ever come across handling capabilities which are not
>> standard size, we could add the necessary code to support it.
> yes, normally the arm64_cpu_capabilities features are 4bits. However, in my
> platform, there is a private CPU feature which is more than 4bits.
> 
>>
>> Are you planning to add something which does require the change ? Please
>> feel free to send patches.
> 
> If I support this feature, I have to change it and not use 4bits. This CPU
> feature is private, I does not want to upstream the whole feature.
> 
> If I only send the change about using actual width instead of 4 bits when detection feature ,
> I am not sure you are agree.

Well, if the feature is not going to be upstream, the change may not be accepted.
You could always add your custom code for "matching" the capability, like for e.g,
ARM64_HAS_VIRT_HOST_EXTN.

Cheers
Suzuki
