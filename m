From: dave.long@linaro.org (David Long)
Date: Mon, 21 Mar 2016 04:35:13 -0400
Subject: [PATCH v11 4/9] arm64: add conditional instruction simulation
 support
In-Reply-To: <20160314073803.22c90d69@arm.com>
References: <1457501543-24197-1-git-send-email-dave.long@linaro.org>
 <1457501543-24197-5-git-send-email-dave.long@linaro.org>
 <20160313120903.54b0c8f2@arm.com> <20160314040455.GB6584@dhcppc6.redhat.com>
 <20160314073803.22c90d69@arm.com>
Message-ID: <56EFB241.80909@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/14/2016 03:38 AM, Marc Zyngier wrote:
> On Mon, 14 Mar 2016 09:34:55 +0530
> Pratyush Anand <panand@redhat.com> wrote:
>
> Hi Pratyush,
>
>> On 13/03/2016:12:09:03 PM, Marc Zyngier wrote:
>>> On Wed,  9 Mar 2016 00:32:18 -0500
>>> David Long <dave.long@linaro.org> wrote:
>>>
>>>> +pstate_check_t * const opcode_condition_checks[16] = {
>>>> +	__check_eq, __check_ne, __check_cs, __check_cc,
>>>> +	__check_mi, __check_pl, __check_vs, __check_vc,
>>>> +	__check_hi, __check_ls, __check_ge, __check_lt,
>>>> +	__check_gt, __check_le, __check_al, __check_al
>>>
>>> The very last entry seems wrong, or is at least the opposite of what
>>> the current code has. It should be something called __check_nv(), and
>>> always return false (condition code NEVER).
>>
>> May be __check_nv() name is more appropriate as per definition, but shouldn't it
>> still return true, because TRM says:
>> "The condition code NV exists only to provide a valid disassembly of the 0b1111
>> encoding, otherwise its behavior is identical to AL"
>
> Indeed, I missed that. But this interpretation is for the A64
> instruction set, and this array is also used by the new
> arm32_check_condition. The condition code table for A32 seems to
> completely ignore the 0b1111 code (there is simply no entry for it), and
> it is only in the ConditionHolds pseudocode that you can see how this
> is actually special-cased.
>
> So I'm fine leaving the code as it is, but a comment and a pointer to
> the ARMv8 ARM wouldn't go amiss.
>
> Thanks,
>
> 	M.
>

OK.

-dl
