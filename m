From: kirill@shutemov.name (Kirill A. Shutemov)
Date: Mon, 27 Jul 2015 09:43:00 +0300
Subject: [PATCH V5 2/7] mm: mlock: Add new mlock system call
In-Reply-To: <1437773325-8623-3-git-send-email-emunson@akamai.com>
References: <1437773325-8623-1-git-send-email-emunson@akamai.com>
 <1437773325-8623-3-git-send-email-emunson@akamai.com>
Message-ID: <20150727064300.GB11657@node.dhcp.inet.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 05:28:40PM -0400, Eric B Munson wrote:
> With the refactored mlock code, introduce a new system call for mlock.
> The new call will allow the user to specify what lock states are being
> added.  mlock2 is trivial at the moment, but a follow on patch will add
> a new mlock state making it useful.
> 
> Signed-off-by: Eric B Munson <emunson@akamai.com>
> Cc: Michal Hocko <mhocko@suse.cz>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-alpha at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: adi-buildroot-devel at lists.sourceforge.net
> Cc: linux-cris-kernel at axis.com
> Cc: linux-ia64 at vger.kernel.org
> Cc: linux-m68k at lists.linux-m68k.org
> Cc: linux-am33-list at redhat.com
> Cc: linux-parisc at vger.kernel.org
> Cc: linuxppc-dev at lists.ozlabs.org
> Cc: linux-s390 at vger.kernel.org
> Cc: linux-sh at vger.kernel.org
> Cc: sparclinux at vger.kernel.org
> Cc: linux-xtensa at linux-xtensa.org
> Cc: linux-api at vger.kernel.org
> Cc: linux-arch at vger.kernel.org
> Cc: linux-mm at kvack.org
> ---
> Changes from V4:
> * Drop all architectures except x86[_64] from this patch, MIPS is added
>   later in the series.  All others will be left to their maintainers.
> 
> Changes from V3:
> * Do a (hopefully) complete job of adding the new system calls
>  arch/alpha/include/uapi/asm/mman.h     | 2 ++
>  arch/mips/include/uapi/asm/mman.h      | 5 +++++
>  arch/parisc/include/uapi/asm/mman.h    | 2 ++
>  arch/powerpc/include/uapi/asm/mman.h   | 2 ++
>  arch/sparc/include/uapi/asm/mman.h     | 2 ++
>  arch/tile/include/uapi/asm/mman.h      | 5 +++++
>  arch/x86/entry/syscalls/syscall_32.tbl | 1 +
>  arch/x86/entry/syscalls/syscall_64.tbl | 1 +
>  arch/xtensa/include/uapi/asm/mman.h    | 5 +++++

Define MLOCK_LOCKED in include/uapi/asm-generic/mman-common.h.
This way you can drop changes in powerpc, sparc and tile.

Otherwise looks good.

-- 
 Kirill A. Shutemov
