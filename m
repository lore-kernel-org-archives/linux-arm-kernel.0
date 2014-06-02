From: will.deacon@arm.com (Will Deacon)
Date: Mon, 2 Jun 2014 13:35:17 +0100
Subject: [PATCH] arm64: uid16: fix __kernel_old_{gid,uid}_t definitions
In-Reply-To: <24318565.Hg3EHrYVE1@wuerfel>
References: <1401706049-1787-1-git-send-email-will.deacon@arm.com>
 <24318565.Hg3EHrYVE1@wuerfel>
Message-ID: <20140602123517.GC13968@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Mon, Jun 02, 2014 at 12:45:39PM +0100, Arnd Bergmann wrote:
> On Monday 02 June 2014 11:47:29 Will Deacon wrote:
> > Whilst native arm64 applications don't have the 16-bit UID/GID syscalls
> > wired up, compat tasks can still access them. The 16-bit wrappers for
> > these syscalls use __kernel_old_uid_t and __kernel_old_gid_t, which must
> > be 16-bit data types to maintain compatibility with the 16-bit UIDs used
> > by compat applications.
> > 
> > This patch defines 16-bit __kernel_old_{gid,uid}_t types for arm64
> > instead of using the 32-bit types provided by asm-generic.
> > 
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Cheers!

> Is this a theoretical problem, or did you actually encounter binaries
> with old uid syscalls?

I hit it during an AArch32 LTP run which passes '-1' for some parameters
to the 16-bit flavours of setreuid etc. So I suppose it's theoretical in
the sense that I've only observed the issue within a testsuite as opposed
to a real application.

Will
