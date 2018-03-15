From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 15 Mar 2018 18:48:45 +0000
Subject: [PATCH v2] KVM: arm: reserve bit in KVM_REG_ARM encoding for
 secure/nonsecure
In-Reply-To: <CAFEAcA-p-N6eF4LpDVfXOM4niBZTEyZi+Xg6RnjM7a5RQk+WCw@mail.gmail.com>
References: <20180306194741.30395-1-peter.maydell@linaro.org>
 <CAFEAcA-p-N6eF4LpDVfXOM4niBZTEyZi+Xg6RnjM7a5RQk+WCw@mail.gmail.com>
Message-ID: <6591fb85-0e7c-3ab9-b613-13ddc7d03746@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/03/18 17:57, Peter Maydell wrote:
> On 6 March 2018 at 19:47, Peter Maydell <peter.maydell@linaro.org> wrote:
>> We have a KVM_REG_ARM encoding that we use to expose KVM guest registers
>> to userspace. Define that bit 28 in this encoding indicates secure vs
>> nonsecure, so we can distinguish the secure and nonsecure banked versions
>> of a banked AArch32 register.
>>
>> For KVM currently, all guest registers are nonsecure, but defining
>> the bit is useful for userspace. In particular, QEMU uses this
>> encoding as part of its on-the-wire migration format, and needs to be
>> able to describe secure-bank registers when it is migrating (fully
>> emulated) EL3-enabled CPUs.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> v1->v2: expanded comment
> 
> Ping -- is this version OK, Marc?

Sorry, I thought I had replied.

Yup, this looks good to me. I start building the patch queue tomorrow,
and this will likely be the first patch.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
