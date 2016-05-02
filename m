From: Vineet.Gupta1@synopsys.com (Vineet Gupta)
Date: Mon, 2 May 2016 05:13:46 +0000
Subject: [PATCH v2] asm-generic: Drop renameat syscall from default list
References: <1461965366-7893-1-git-send-email-james.hogan@imgtec.com>
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075F4EA010A@us01wembx1.internal.synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 30 April 2016 02:59 AM, James Hogan wrote:
> The newer renameat2 syscall provides all the functionality provided by
> the renameat syscall and adds flags, so future architectures won't need
> to include renameat.
>
> Therefore drop the renameat syscall from the generic syscall list unless
> __ARCH_WANT_RENAMEAT is defined by the architecture's unistd.h prior to
> including asm-generic/unistd.h, and adjust all architectures using the
> generic syscall list to define it so that no in-tree architectures are
> affected.
>
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arch at vger.kernel.org
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: linux-snps-arc at lists.infradead.org
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Mark Salter <msalter@redhat.com>
> Cc: Aurelien Jacquiot <a-jacquiot@ti.com>
> Cc: linux-c6x-dev at linux-c6x.org
> Cc: Richard Kuo <rkuo@codeaurora.org>
> Cc: linux-hexagon at vger.kernel.org
> Cc: linux-metag at vger.kernel.org
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: linux at lists.openrisc.net
> Cc: Chen Liqin <liqin.linux@gmail.com>
> Cc: Lennox Wu <lennox.wu@gmail.com>
> Cc: Chris Metcalf <cmetcalf@mellanox.com>
> Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
> Cc: Ley Foon Tan <lftan@altera.com>
> Cc: nios2-dev at lists.rocketboards.org
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: uclinux-h8-devel at lists.sourceforge.jp
> ---
> I just found this patch on an old branch, it appears to have slipped
> through the cracks. Time for a respon.
>
> Changes in v2:
> - Rebase onto v4.6-rc5.
> - Add __ARCH_WANT_RENAMEAT to h8300 and nios2 arches too.
> ---
>  arch/arc/include/uapi/asm/unistd.h       | 1 +

Acked-by: Vineet Gupta <vgupta@synopsys.com>  # for arch/arc
