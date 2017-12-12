From: gengdongjiu@huawei.com (gengdongjiu)
Date: Tue, 12 Dec 2017 09:44:06 +0800
Subject: [RESEND PATCH] arm64: v8.4: Support for new floating point
 multiplication variant
In-Reply-To: <20171211132914.GJ22781@e103592.cambridge.arm.com>
References: <1512833322-35503-1-git-send-email-gengdongjiu@huawei.com>
 <20171211115947.GS12608@e103592.cambridge.arm.com>
 <4c6d83f1-e8f3-46d7-f3cd-af2db77e3a9c@huawei.com>
 <20171211132914.GJ22781@e103592.cambridge.arm.com>
Message-ID: <d39500ed-0d17-a8b2-b7e2-9e48b5d8d43a@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 2017/12/11 21:29, Dave Martin wrote:
>> Thanks for the point out.
>> In fact, this feature only adds two instructions:
>> FP16 * FP16 + FP32
>> FP16 * FP16 - FP32
>>
>> The spec call this bit to ID_AA64ISAR0_EL1.FHM, I do not know why it
>> will call "FHM", I  think call it "FMLXL" may be better, which can
>> stand for FMLAL/FMLSL instructions.
> Although "FHM" is cryptic, I think it makes sense to keep this as "FHM"
> to match the ISAR0 field name -- we've tended to follow this policy
> for other extension names unless there's a much better or more obvious
> name available
Agree with you, I also think the "FHM" is better.

> 
> For "FMLXL", new instructions might be added in the future that match
> the same pattern, and then "FMLXL" could become ambiguous.  So maybe
> this is not the best choice.
Ok.

> 
>>> Maybe something like "widening half-precision floating-point multiply
>>> accumulate" is acceptable wording consistent with the existing
>>> architecture, but I just made that up, so it's not official ;)
>> how about something like "performing a multiplication of each FP16
>> element of one vector with the corresponding FP16 element of a second
>> vector, and to add or subtract this without an intermediate rounding
>> to the corresponding FP32 element in a third vector."?
> We could have that, I guess.
Ok, thanks!

> 
>>>> instructions set. Let the userspace know about it via a
>>>> HWCAP bit and MRS emulation.
