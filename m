From: stefan@agner.ch (Stefan Agner)
Date: Mon, 07 May 2018 22:24:51 +0200
Subject: [PATCH v2 0/6] ARM: clang support
In-Reply-To: <20180325180959.28008-1-stefan@agner.ch>
References: <20180325180959.28008-1-stefan@agner.ch>
Message-ID: <d099cce32d109caefd2fc39196ce5bca@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.03.2018 20:09, Stefan Agner wrote:
> This patchset fixes some remaining issues when building the ARM
> architecture using LLVM/clang.  The patchset requires the following
> kbuild change:
> https://lkml.org/lkml/2018/3/19/1756
> 
> With that patch and this patchset applied and I can successfully
> build (and boot) the multi_v7_defconfig with 4.16-rc5 using clang
> 5.0.1 and 6.0.0.

Russel, Arnd, any comment on this patch series? How can we get it
merged?

I was thinking patch 1 through armsoc since that is the way previous
patches have been merged.

Note sure about patch 2, Russel can you comment on Thierry's email?

And patch 3 through 6 through Russel's tree?

--
Stefan

> 
> This version also adds a patch to mitigate a often printed warning
> about duplicate 'const' declaration specifier when using get_user().
> 
> Stefan Agner (6):
>   bus: arm-cci: use asm unreachable
>   efi/libstub/arm: add support for building with clang
>   ARM: trusted_foundations: do not use naked function
>   ARM: drop no-thumb-interwork in EABI mode
>   ARM: add support for building ARM kernel with clang
>   ARM: uaccess: remove const to avoid duplicate specifier
> 
>  arch/arm/Makefile                       |  2 +-
>  arch/arm/boot/compressed/Makefile       |  2 +-
>  arch/arm/firmware/trusted_foundations.c | 14 +++++++++-----
>  arch/arm/include/asm/uaccess.h          |  2 +-
>  drivers/bus/arm-cci.c                   |  2 --
>  drivers/firmware/efi/libstub/Makefile   |  3 ++-
>  6 files changed, 14 insertions(+), 11 deletions(-)
