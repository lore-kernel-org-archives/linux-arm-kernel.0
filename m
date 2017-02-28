From: jonathanh@nvidia.com (Jon Hunter)
Date: Tue, 28 Feb 2017 15:54:13 +0000
Subject: [PATCH 2/2] crypto: arm - add build time test for CRC instruction
 support
In-Reply-To: <1488292617-27317-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1488292617-27317-1-git-send-email-ard.biesheuvel@linaro.org>
 <1488292617-27317-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <be137899-cd94-5fb3-1f14-c1921509e0d7@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 28/02/17 14:36, Ard Biesheuvel wrote:
> The accelerated CRC32 module for ARM may use either the scalar CRC32
> instructions, the NEON 64x64 to 128 bit polynomial multiplication
> (vmull.p64) instruction, or both, depending on what the current CPU
> supports.
> 
> However, this also requires support in binutils, and as it turns out,
> versions of binutils exist that support the vmull.p64 instruction but
> not the crc32 instructions.
> 
> So refactor the Makefile logic so that this module only gets built if
> binutils has support for both.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Thanks!

Acked-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
