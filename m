From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 15 Feb 2016 20:25:34 +0900
Subject: [PATCH] ARM: drop redundant "PHONY += FORCE"
In-Reply-To: <1454839174-5464-1-git-send-email-yamada.masahiro@socionext.com>
References: <1454839174-5464-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNASARrPWgsvBjMjEyGAC-CzOAMkL8=GSsuj_i3Eq+xCyEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-02-07 18:59 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> "PHONY += FORCE" is already cared by scripts/Makefile.build,
> which this file is included from.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  arch/arm/boot/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
> index 9eca7ae..ba73a20 100644
> --- a/arch/arm/boot/Makefile
> +++ b/arch/arm/boot/Makefile
> @@ -88,7 +88,7 @@ $(obj)/bootpImage: $(obj)/bootp/bootp FORCE
>         $(call if_changed,objcopy)
>         @$(kecho) '  Kernel: $@ is ready'
>
> -PHONY += initrd FORCE
> +PHONY += initrd
>  initrd:
>         @test "$(INITRD_PHYS)" != "" || \
>         (echo This machine does not support INITRD; exit -1)
> --

If there is no objection to this patch,
I will put it into Russell's patch tracker.



-- 
Best Regards
Masahiro Yamada
