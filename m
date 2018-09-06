From: will.deacon@arm.com (Will Deacon)
Date: Thu, 6 Sep 2018 11:05:47 +0100
Subject: [PATCH v2 6/9] kbuild: consolidate Devicetree dtb build rules
In-Reply-To: <20180905235327.5996-7-robh@kernel.org>
References: <20180905235327.5996-1-robh@kernel.org>
 <20180905235327.5996-7-robh@kernel.org>
Message-ID: <20180906100546.GJ3592@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 05, 2018 at 06:53:24PM -0500, Rob Herring wrote:
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
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: Ley Foon Tan <lftan@altera.com>
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
> Please ack so I can take the whole series via the DT tree.

For arm64:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
