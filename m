From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Apr 2014 14:18:04 +0200
Subject: [RFC 3/3] asm-generic: Drop renameat syscall from default list
In-Reply-To: <1398247687-13453-4-git-send-email-james.hogan@imgtec.com>
References: <1398247687-13453-1-git-send-email-james.hogan@imgtec.com>
 <1398247687-13453-4-git-send-email-james.hogan@imgtec.com>
Message-ID: <201404231418.05174.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 23 April 2014, James Hogan wrote:
> The new renameat2 syscall provides all the functionality provided by the
> renameat syscall and adds flags, so future architectures won't need to
> include renameat.
> 
> Therefore drop the renameat syscall from the generic syscall list unless
> __ARCH_WANT_RENAMEAT is defined by the architecture's unistd.h prior to
> including asm-generic/unistd.h, and adjust all architectures using the
> generic syscall list to define it so that no in-tree architectures are
> affected.

I should have read this one before replying to patch 2 ;-)

> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arch at vger.kernel.org
> Cc: Vineet Gupta <vgupta@synopsys.com>
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
> Cc: Chris Metcalf <cmetcalf@tilera.com>
> Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
> ---
> Is this the approach we want to take to keep the default syscall list
> minimal? We could for example have made renameat2 use the renameat
> syscall number for new arches, but it seemed best to leave a gap for new
> arches to improve consistency of numbering.

I think leaving the hole is best.

> This patch is a no-op for arches in tree, so there's no harm for this to
> wait for the v3.16 merge window.

Sounds good. I guess I'll have to put this into my asm-generic tree
then, unless I can get the nios2 maintainers to pick it up.

If you don't mind, can you submit the first two patches to Linus
directly?

	Arnd
