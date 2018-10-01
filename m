From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 2 Oct 2018 05:34:18 +0900
Subject: [PATCH v4 6/9] kbuild: consolidate Devicetree dtb build rules
In-Reply-To: <20181001152531.3385-7-robh@kernel.org>
References: <20181001152531.3385-1-robh@kernel.org>
 <20181001152531.3385-7-robh@kernel.org>
Message-ID: <CAK7LNAQAG1pAOMbnrFd5VbmUfcN5337tcGdeFrRo92rPWkVWAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018?10?2?(?) 0:26 Rob Herring <robh@kernel.org>:
>
> There is nothing arch specific about building dtb files other than their
> location under /arch/*/boot/dts/. Keeping each arch aligned is a pain.
> The dependencies and supported targets are all slightly different.
> Also, a cross-compiler for each arch is needed, but really the host
> compiler preprocessor is perfectly fine for building dtbs. Move the
> build rules to a common location and remove the arch specific ones. This
> is done in a single step to avoid warnings about overriding rules.
>
> The build dependencies had been a mixture of 'scripts' and/or 'prepare'.
> These pull in several dependencies some of which need a target compiler
> (specifically devicetable-offsets.h) and aren't needed to build dtbs.
> All that is really needed is dtc, so adjust the dependencies to only be
> dtc.
>
> This change enables support 'dtbs_install' on some arches which were
> missing the target.
>
> Acked-by: Will Deacon <will.deacon@arm.com>
> Acked-by: Paul Burton <paul.burton@mips.com>
> Acked-by: Ley Foon Tan <ley.foon.tan@intel.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>

Please change this to

Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>


Thanks.


> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: linux-kbuild at vger.kernel.org
> Cc: linux-snps-arc at lists.infradead.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: uclinux-h8-devel at lists.sourceforge.jp
> Cc: linux-mips at linux-mips.org
> Cc: nios2-dev at lists.rocketboards.org
> Cc: linuxppc-dev at lists.ozlabs.org
> Cc: linux-xtensa at linux-xtensa.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v4:
>  - Make dtbs and %.dtb rules depend on arch/$ARCH/boot/dts path rather than
>    CONFIG_OF_EARLY_FLATTREE
>  - Fix install path missing kernel version for dtbs_install
>  - Fix "make CONFIG_OF_ALL_DTBS=y" for arches like ARM which selectively
>    enable CONFIG_OF (and therefore dtc)




-- 
Best Regards
Masahiro Yamada
