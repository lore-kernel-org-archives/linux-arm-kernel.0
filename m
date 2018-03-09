From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 9 Mar 2018 16:09:19 +0000
Subject: [PATCH] arm64: Relax ARM_SMCCC_ARCH_WORKAROUND_1 discovery
In-Reply-To: <CAKv+Gu9vhS-CmyCMm8arYE0rgAPwKqXHnG7JDmSzW=vhwAYDMw@mail.gmail.com>
References: <20180309154050.30656-1-marc.zyngier@arm.com>
 <CAKv+Gu9vhS-CmyCMm8arYE0rgAPwKqXHnG7JDmSzW=vhwAYDMw@mail.gmail.com>
Message-ID: <7e59ba1c-c6dd-5d71-d163-99a674b4762b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/03/18 15:55, Ard Biesheuvel wrote:
> On 9 March 2018 at 15:40, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> A recent update to the ARM SMCCC ARCH_WORKAROUND_1 specification
>> allows firmware to return a non zero, positive value to describe
>> that although the mitigation is implemented at the higher exception
>> level, the CPU on which the call is made is not affected.
>>
>> Let's relax the check on the return value from ARCH_WORKAROUND_1
>> so that we only error out if the returned value is negative.
>>
>> Fixes: b092201e0020 ("arm64: Add ARM_SMCCC_ARCH_WORKAROUND_1 BP hardening support")
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> OK, so this means the current code running on new firmware will
> erroneously assume that the mitigation is not implemented or needed if
> it, say, happens to run on the A53 cluster on Juno?

Yup, that's the problem. To my knowledge, there is no such firmware in
the wild, as the spec has just been published.

	M.
-- 
Jazz is not dead. It just smells funny...
