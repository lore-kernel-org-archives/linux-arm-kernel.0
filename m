From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 18 Dec 2013 10:50:38 +0100
Subject: [PATCH 0/4] arm64: advertise availability of CRC and crypto
 instructions
In-Reply-To: <20131217122519.GI32118@arm.com>
References: <1387227878-30438-1-git-send-email-ard.biesheuvel@linaro.org>
 <20131217122519.GI32118@arm.com>
Message-ID: <CAKv+Gu824T1vx=O9taLaDSB-HE3OLSpwnpWMn4z+x8YdmLuM+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 December 2013 13:25, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Mon, Dec 16, 2013 at 09:04:34PM +0000, Ard Biesheuvel wrote:
>> This series is an expansion of the patch posted by Steve Capper about 6 weeks
>> ago that allocates hwcaps bits for CRC and Crypto Extensions instructions so
>> userland can discover whether the current CPU has any of those capabilities.
>>
>> Patch #1 is a cleanup patch for read_cpuid(), which allowed me to skip adding
>> yet another #define to asm/cputype.h (for ID_ISAR5_EL1)
>>
>> Patch #2 is Steve's original patch, but slightly tweaked because hwcaps bit 2
>> has been allocated for something else in the mean time.
>>
>> Patch #3 allocates the capability bits in the arch/arm tree. This is necessary
>> because 32-bit ARM binaries can execute both under ARM and under arm64 kernels,
>> so there should be agreement about the meaning of feature bits, even if those
>> features don't actually exist on systems covered by the arch/arm tree.
>>
>> @Russell: if this looks ok to you, could you please indicate whether you prefer
>> to take this patch separately, or ack it and let it be merged as part of the
>> series.
>>
>> Patch #4 advertises the CRC and Crypto Extensions to 32-bit binaries running
>> under an arm64 kernel.
>
> The series look fine to me. I'm happy to take all the patches if Russell
> Acks the arm one (or it can send it via the patch system).
>

Hello Russell,

Care to share your take on this? I imagine new hwcaps bits take a
while to percolate and make their way into a stable glibc, so I would
like to have these changes in sooner rather than later, and 3.14 seems
feasible.

Regards,
Ard.
