From: julien.grall@arm.com (Julien Grall)
Date: Fri, 9 Feb 2018 10:55:18 +0000
Subject: [PATCH v3 04/41] KVM: arm64: Rework hyp_panic for VHE and non-VHE
In-Reply-To: <20180208132416.GP29286@cbox>
References: <20180112120747.27999-1-christoffer.dall@linaro.org>
 <20180112120747.27999-5-christoffer.dall@linaro.org>
 <be470bdb-258e-6b4d-b409-e230d2d90888@arm.com> <20180208132416.GP29286@cbox>
Message-ID: <82ed8658-383e-4b10-866f-10389f697b73@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 02/08/2018 01:24 PM, Christoffer Dall wrote:
> On Mon, Feb 05, 2018 at 06:04:25PM +0000, Julien Grall wrote:
>> On 12/01/18 12:07, Christoffer Dall wrote:
>>> +
>>>   	panic(__hyp_panic_string,
>>>   	      spsr,  elr,
>>>   	      read_sysreg_el2(esr),   read_sysreg_el2(far),
>>>   	      read_sysreg(hpfar_el2), par, vcpu);
>>>   }
>>> -static hyp_alternate_select(__hyp_call_panic,
>>> -			    __hyp_call_panic_nvhe, __hyp_call_panic_vhe,
>>> -			    ARM64_HAS_VIRT_HOST_EXTN);
>>
>> Out of interest, any specific rather to remove hyp_alternate_select and
>> "open-code" it?
>>
> 
> Not sure I understand your question.
> 
> Are you asking why I replace the hyp alternatives with the has_vhe()?
> If so, has_vhe() uses a static key and should therefore have the same
> performance characteristics, but I find the has_vhe() version below much
> more readable.

That what I was asking. Thank you for the explanation.

Cheers,

-- 
Julien Grall
