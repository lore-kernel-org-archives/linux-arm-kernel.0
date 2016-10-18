From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 18 Oct 2016 12:49:32 +0100
Subject: [PATCH v2 0/8] crypto: ARM/arm64 - big endian fixes
In-Reply-To: <1476209720-21114-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1476209720-21114-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20161018114932.GG10115@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 11, 2016 at 07:15:12PM +0100, Ard Biesheuvel wrote:
> As it turns out, none of the accelerated crypto routines under arch/arm64/crypto
> currently work, or have ever worked correctly when built for big endian. So this
> series fixes all of them. This v2 now includes a similar fix for 32-bit ARM as
> well, and an additional fix for XTS which escaped my attention before.
> 
> Each of these patches carries a fixes tag, and could be backported to stable.
> However, for patches #1 and #5, the fixes tag denotes the oldest commit that the
> fix is compatible with, not the patch that introduced the algorithm.

I think for future reference, the Fixes tag should denote the commit
that introduced the issue. An explicit Cc: stable tag would state how
far back it should be applied.

> Ard Biesheuvel (8):
>   crypto: arm64/aes-ce - fix for big endian
>   crypto: arm64/ghash-ce - fix for big endian
>   crypto: arm64/sha1-ce - fix for big endian
>   crypto: arm64/sha2-ce - fix for big endian
>   crypto: arm64/aes-ccm-ce: fix for big endian
>   crypto: arm64/aes-neon - fix for big endian
>   crypto: arm64/aes-xts-ce: fix for big endian
>   crypto: arm/aes-ce - fix for big endian

The changes look fine to me but I can't claim I fully understand these
algorithms. FWIW:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

(Will may pick them up for 4.9-rcX)
