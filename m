From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 12 May 2016 11:09:19 +0100
Subject: [PATCH v3 27/55] KVM: arm/arm64: vgic-new: Add PRIORITY registers
 handlers
In-Reply-To: <CAFEAcA95nt_4wueOTzergNfupg4zGMTj_EQgCLrRunpg6GUbPA@mail.gmail.com>
References: <1462531568-9799-1-git-send-email-andre.przywara@arm.com>
 <1462531568-9799-28-git-send-email-andre.przywara@arm.com>
 <57344889.1050802@arm.com>
 <CAFEAcA95nt_4wueOTzergNfupg4zGMTj_EQgCLrRunpg6GUbPA@mail.gmail.com>
Message-ID: <5734564F.2080001@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/05/16 10:56, Peter Maydell wrote:
> On 12 May 2016 at 10:10, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> This is wrong. We should only write the number of bits of priority we
>> actually emulate. And given that we use a common framework for v2 and
>> v3, this should probably be 5 bits (32 priorities should be enough for
>> everybody).
> 
> FWIW QEMU's GICv2 and GICv3 emulations both implement the full
> 8 bits of priority.

On GICv2, GICH_APR is only 32bit, implying that a guest can only ever
use 5 bits of priority. GICH_VTR also says that the only allowed value
for PRIbits is 32 priority levels (iow 5 bits).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
