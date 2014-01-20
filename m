From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 20 Jan 2014 17:38:38 +0000
Subject: [PATCH v2 0/5] arm64: advertise availability of CRC and crypto
 instructions
In-Reply-To: <1387807592-26375-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1387807592-26375-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20140120173838.GD29971@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 23, 2013 at 02:06:27PM +0000, Ard Biesheuvel wrote:
> This series is a followup to the patch that was recently merged by Catalin that
> allocates hwcaps bits for CRC and Crypto Extensions instructions so userland can
> discover whether the current CPU has any of those capabilities.
> 
> Patch #1 enables ARM support for the ELF_HWCAP2/AT_HWCAP2 ELF auxv entry that
> was recently added to the kernel and glibc (2.18). It extends the feature bit
> space to 64 bits (on 32-bit architectures)
> 
> Patch #2 adds generic support for ELF_HWCAP2/AT_HWCAP2 to the 32-bit ELF compat
> mode for 64-bit architectures.
> 
> Patch #3 adds support for ELF_HWCAP2/AT_HWCAP2 to arm64's 32-bit ELF compat mode
> 
> Patch #4 allocates the HWCAP2 bits in the arch/arm tree. This is necessary
> because 32-bit ARM binaries can execute both under ARM and under arm64 kernels,
> so there should be agreement about the meaning of feature bits, even if the ARM
> kernel has no support yet for ARMv8 32-bit only hardware (such as ARMv8-R).

It looks a bit strange to start filling HWCAP2 before HWCAP is full but
I guess we want to preserve some future extensions in HWCAP for older
glibc.

-- 
Catalin
