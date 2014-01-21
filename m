From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 21 Jan 2014 09:55:53 +0100
Subject: [PATCH v2 0/5] arm64: advertise availability of CRC and crypto
 instructions
In-Reply-To: <20140120173838.GD29971@arm.com>
References: <1387807592-26375-1-git-send-email-ard.biesheuvel@linaro.org>
 <20140120173838.GD29971@arm.com>
Message-ID: <CAKv+Gu-u_5P_LvGmBz6ZAfDiEUF+=Y30m7zWV9L40DvSBquWyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

@Russell,

May we have your comments/opinion please on this alternative approach?

Regards,
Ard.


On 20 January 2014 18:38, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Mon, Dec 23, 2013 at 02:06:27PM +0000, Ard Biesheuvel wrote:
>> This series is a followup to the patch that was recently merged by Catalin that
>> allocates hwcaps bits for CRC and Crypto Extensions instructions so userland can
>> discover whether the current CPU has any of those capabilities.
>>
>> Patch #1 enables ARM support for the ELF_HWCAP2/AT_HWCAP2 ELF auxv entry that
>> was recently added to the kernel and glibc (2.18). It extends the feature bit
>> space to 64 bits (on 32-bit architectures)
>>
>> Patch #2 adds generic support for ELF_HWCAP2/AT_HWCAP2 to the 32-bit ELF compat
>> mode for 64-bit architectures.
>>
>> Patch #3 adds support for ELF_HWCAP2/AT_HWCAP2 to arm64's 32-bit ELF compat mode
>>
>> Patch #4 allocates the HWCAP2 bits in the arch/arm tree. This is necessary
>> because 32-bit ARM binaries can execute both under ARM and under arm64 kernels,
>> so there should be agreement about the meaning of feature bits, even if the ARM
>> kernel has no support yet for ARMv8 32-bit only hardware (such as ARMv8-R).
>
> It looks a bit strange to start filling HWCAP2 before HWCAP is full but
> I guess we want to preserve some future extensions in HWCAP for older
> glibc.
>
> --
> Catalin
