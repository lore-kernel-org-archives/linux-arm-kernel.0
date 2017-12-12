From: gengdongjiu@huawei.com (gengdongjiu)
Date: Tue, 12 Dec 2017 10:07:21 +0800
Subject: [RESEND PATCH] arm64: v8.4: Support for new floating point
 multiplication variant
In-Reply-To: <8ebb6a36-0e09-1ac1-7785-cc9d4e4147fb@arm.com>
References: <1512833322-35503-1-git-send-email-gengdongjiu@huawei.com>
 <20171211115947.GS12608@e103592.cambridge.arm.com>
 <4c6d83f1-e8f3-46d7-f3cd-af2db77e3a9c@huawei.com>
 <20171211132914.GJ22781@e103592.cambridge.arm.com>
 <8ebb6a36-0e09-1ac1-7785-cc9d4e4147fb@arm.com>
Message-ID: <8b9d2aa5-4525-bdd2-0867-be04eb9845aa@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/12/12 2:58, Suzuki K Poulose wrote:
> Hi gengdongjiu
> 
> Sorry for the late response. I have a similar patch to add the support for "FHM", which I was about to post it this week.
Suzuki, you are welcome.
May be you can not post again to avoid the duplicate review, thanks!

> 
> On 11/12/17 13:29, Dave Martin wrote:
>> On Mon, Dec 11, 2017 at 08:47:00PM +0800, gengdongjiu wrote:
>>>
>>> On 2017/12/11 19:59, Dave P Martin wrote:
>>>> On Sat, Dec 09, 2017 at 03:28:42PM +0000, Dongjiu Geng wrote:
>>>>> ARM v8.4 extensions include support for new floating point
>>>>> multiplication variant instructions to the AArch64 SIMD
>>>>
>>>> Do we have any human-readable description of what the new instructions
>>>> do?
>>>>
>>>> Since the v8.4 spec itself only describes these as "New Floating
>>>> Point Multiplication Variant", I wonder what "FHM" actually stands
>>>> for.
>>> Thanks for the point out.
>>> In fact, this feature only adds two instructions:
>>> FP16 * FP16 + FP32
>>> FP16 * FP16 - FP32
>>>
>>> The spec call this bit to ID_AA64ISAR0_EL1.FHM, I do not know why it
>>> will call "FHM", I? think call it "FMLXL" may be better, which can
>>> stand for FMLAL/FMLSL instructions.
>>
>> Although "FHM" is cryptic, I think it makes sense to keep this as "FHM"
>> to match the ISAR0 field name -- we've tended to follow this policy
>> for other extension names unless there's a much better or more obvious
>> name available.
>>
>> For "FMLXL", new instructions might be added in the future that match
>> the same pattern, and then "FMLXL" could become ambiguous.? So maybe
>> this is not the best choice.
> 
> I think the FHM stands for "FP Half precision Multiplication instructions". I vote for keeping the feature bit in sync with the register bit definition. i.e, FHM.
 agree with you

> 
> However, my version of the patch names the HWCAP bit "asimdfml", following the compiler name for the feature option "fp16fml", which
> is not perfect either. I think FHM is the safe option here.
yes, "FHM" is safe here.

> 
>>
>>>> Maybe something like "widening half-precision floating-point multiply
>>>> accumulate" is acceptable wording consistent with the existing
>>>> architecture, but I just made that up, so it's not official ;)
>>>
>>> how about something like "performing a multiplication of each FP16
>>> element of one vector with the corresponding FP16 element of a second
>>> vector, and to add or subtract this without an intermediate rounding
>>> to the corresponding FP32 element in a third vector."?
>>
>> We could have that, I guess.
>>
> 
> I agree, and that matches the feature description.
Ok, thanks!

> 
> 
