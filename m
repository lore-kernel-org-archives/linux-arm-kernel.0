From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 10 Jul 2018 09:25:58 +0200
Subject: [PATCH] MAINTAINERS: arm64: Remove boot/dts/ directory from arm64
 entry
In-Reply-To: <1530879736-7650-1-git-send-email-will.deacon@arm.com>
References: <1530879736-7650-1-git-send-email-will.deacon@arm.com>
Message-ID: <CAMuHMdUqRXde5DNgK6ih+ivuwY9HFbcWwbx_x3q5PmFcrGi0pQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Fri, Jul 6, 2018 at 2:22 PM Will Deacon <will.deacon@arm.com> wrote:
> The arm-soc tree does a good job handling .dts files, so exclude them
> from the ARM64 entry in MAINTAINERS.
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Thanks for your patch!

> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2264,6 +2264,7 @@ L:        linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
>  S:     Maintained
>  F:     arch/arm64/
> +X:     arch/arm64/boot/dts/
>  F:     Documentation/arm64/

Please note that this does not cause checkpatch to point to the arm-soc
tree, but does drop the reference to linux-arm-kernel, which may not
be intentional?

--- scripts/get_maintainer.pl -f arch/arm64/boot/dts old 2018-07-10
09:21:51.595392363 +0200
+++ scripts/get_maintainer.pl -f arch/arm64/boot/dts new 2018-07-10
09:22:14.671368341 +0200
@@ -1,7 +1,4 @@
 Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND
FLATTENED DEVICE TREE BINDINGS)
 Mark Rutland <mark.rutland@arm.com> (maintainer:OPEN FIRMWARE AND
FLATTENED DEVICE TREE BINDINGS)
-Catalin Marinas <catalin.marinas@arm.com> (maintainer:ARM64 PORT
(AARCH64 ARCHITECTURE))
-Will Deacon <will.deacon@arm.com> (maintainer:ARM64 PORT (AARCH64
ARCHITECTURE))
 devicetree at vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
DEVICE TREE BINDINGS)
-linux-arm-kernel at lists.infradead.org (moderated list:ARM64 PORT
(AARCH64 ARCHITECTURE))
 linux-kernel at vger.kernel.org (open list)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
