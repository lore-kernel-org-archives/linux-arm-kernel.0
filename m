From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 22 Mar 2017 15:32:09 +0000
Subject: [PATCH] [v2] arm64: define BUG() instruction without CONFIG_BUG
In-Reply-To: <CAK8P3a0A0-gnBnBBuWdPjgoDMo=2P9yXcLjZYm9Yz+xpQnCyCw@mail.gmail.com>
References: <20170314213939.3874497-1-arnd@arndb.de>
 <20170322143729.GB25645@e104818-lin.cambridge.arm.com>
 <CAK8P3a0A0-gnBnBBuWdPjgoDMo=2P9yXcLjZYm9Yz+xpQnCyCw@mail.gmail.com>
Message-ID: <20170322153208.GC25645@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 03:51:54PM +0100, Arnd Bergmann wrote:
> On Wed, Mar 22, 2017 at 3:37 PM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > Hi Arnd,
> >
> > On Tue, Mar 14, 2017 at 10:39:21PM +0100, Arnd Bergmann wrote:
> >> This mirrors commit e9c38ceba8d9 ("ARM: 8455/1: define __BUG as
> >> asm(BUG_INSTR) without CONFIG_BUG") to make the behavior of
> >> arm64 consistent with arm and x86, and avoids lots of warnings in
> >> randconfig builds, such as:
> >>
> >> kernel/seccomp.c: In function '__seccomp_filter':
> >> kernel/seccomp.c:666:1: error: no return statement in function returning non-void [-Werror=return-type]
> >>
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > A side-effect of this patch is that it turns WARN into BUG. I hit the
> > WARN_ONCE in arch/arm64/kernel/efi.c:34 (on Juno with 64K pages) and
> > with your patch applied, the kernel panics.
> 
> Taht was certainly not intended, and I don't see yet what exactly is going on.
> What is your setting for CONFIG_BUG and CONFIG_BUGVERBOSE?

CONFIG_BUG=y
CONFIG_DEBUG_BUGVERBOSE=y

(just defconfig + 64K pages)

-- 
Catalin
