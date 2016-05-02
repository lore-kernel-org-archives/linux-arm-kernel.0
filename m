From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 02 May 2016 17:40:30 +0200
Subject: [question] pread2, pwrite2 unistd symbols for compat
In-Reply-To: <20160502152248.GA716@lst.de>
References: <20160502134706.GA11396@yury-N73SV> <9552994.HgmuyIW9Ty@wuerfel>
 <20160502152248.GA716@lst.de>
Message-ID: <1979597.XqcnTZ9GDk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 May 2016 17:22:48 Christoph Hellwig wrote:
> On Mon, May 02, 2016 at 05:20:22PM +0200, Arnd Bergmann wrote:
> > After I got the original patch from Andre and the same one from Christoph,
> > I did not consider the possibility that they were both wrong and so I
> > applied Andre's version.
> 
> It's because adding syscalls is simple a giant pain, full of pitfalls
> that are completely non-obvious.  When asked to add syscalls for
> architectures I can't personally test I'll have to rely on the test
> bot giving me some feedback - and it seems the wrong thing here will
> just silently pass without any notice.
> 
> The change looks fine to me, but then again I just demonstrated a complete
> lack of clue on asm-generic syscalls..

Ok, so I didn't miss anything obvious here and will forward the patch
as soon as Yury sends it.

I guess this is one more reason for me to finally do the job of
generalizing the system call tables to the point where we only
add them in one place of the kernel. There are probably 22 new syscalls
we need for 64-bit time_t, so doing it right then can also some
copy-paste errors.

	Arnd
