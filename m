From: will.deacon@arm.com (Will Deacon)
Date: Mon, 2 Jul 2018 11:34:29 +0100
Subject: [PATCH] arm64: Use aarch64elf and aarch64elfb emulation mode
 variants
In-Reply-To: <20180702091659.17571-1-contact@paulk.fr>
References: <20180702091659.17571-1-contact@paulk.fr>
Message-ID: <20180702103429.GC28665@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 02, 2018 at 11:16:59AM +0200, Paul Kocialkowski wrote:
> The aarch64linux and aarch64linuxb emulation modes are not supported by
> bare-metal toolchains and Linux using them forbids building the kernel
> with these toolchains.
> 
> Since there is apparently no reason to target these emulation modes, the
> more generic elf modes are used instead, allowing to build on bare-metal
> toolchains as well as the already-supported ones.
> 
> Fixes: 3d6a7b99e3fa ("arm64: ensure the kernel is compiled for LP64")
> 
> Cc: stable at vger.kernel.org
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  arch/arm64/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 87f7d2f9f17c..3e959ac43b40 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -67,14 +67,14 @@ KBUILD_CPPFLAGS	+= -mbig-endian
>  CHECKFLAGS	+= -D__AARCH64EB__
>  AS		+= -EB
>  LD		+= -EB
> -LDFLAGS		+= -maarch64linuxb
> +LDFLAGS		+= -maarch64elfb
>  UTS_MACHINE	:= aarch64_be
>  else
>  KBUILD_CPPFLAGS	+= -mlittle-endian
>  CHECKFLAGS	+= -D__AARCH64EL__
>  AS		+= -EL
>  LD		+= -EL
> -LDFLAGS		+= -maarch64linux
> +LDFLAGS		+= -maarch64elf
>  UTS_MACHINE	:= aarch64
>  endif

Acked-by: Will Deacon <will.deacon@arm.com>

Will
