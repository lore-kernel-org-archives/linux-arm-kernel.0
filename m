From: will.deacon@arm.com (Will Deacon)
Date: Wed, 7 Nov 2018 14:55:54 +0000
Subject: [RFC PATCH 1/4] kconfig: add as-instr macro to
 scripts/Kconfig.include
In-Reply-To: <1541583608-26375-2-git-send-email-vladimir.murzin@arm.com>
References: <1541583608-26375-1-git-send-email-vladimir.murzin@arm.com>
 <1541583608-26375-2-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20181107145552.GC2623@brain-police>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 07, 2018 at 09:40:05AM +0000, Vladimir Murzin wrote:
> There are cases where the whole feature, for instance arm64/lse or
> arm/crypto, can depend on assembler. Current practice is to report
> buildtime that selected feature is not supported, which can be quite
> annoying...

Why is it annoying? You still end up with a working kernel.

> It'd nicer if we can check assembler first and opt-in feature
> visibility in Kconfig.
> 
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
>  scripts/Kconfig.include | 4 ++++
>  1 file changed, 4 insertions(+)

One issue I have with doing the check like this is that if somebody sends
you a .config with e.g. ARM64_LSE_ATOMICS=y and you try to build a kernel
using that .config and an old toolchain, the option is silently dropped.

I think the diagnostic is actually useful in this case.

Will
