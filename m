From: hch@lst.de (Christoph Hellwig)
Date: Mon, 2 May 2016 17:22:48 +0200
Subject: [question] pread2, pwrite2 unistd symbols for compat
In-Reply-To: <9552994.HgmuyIW9Ty@wuerfel>
References: <20160502134706.GA11396@yury-N73SV> <9552994.HgmuyIW9Ty@wuerfel>
Message-ID: <20160502152248.GA716@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 02, 2016 at 05:20:22PM +0200, Arnd Bergmann wrote:
> After I got the original patch from Andre and the same one from Christoph,
> I did not consider the possibility that they were both wrong and so I
> applied Andre's version.

It's because adding syscalls is simple a giant pain, full of pitfalls
that are completely non-obvious.  When asked to add syscalls for
architectures I can't personally test I'll have to rely on the test
bot giving me some feedback - and it seems the wrong thing here will
just silently pass without any notice.

The change looks fine to me, but then again I just demonstrated a complete
lack of clue on asm-generic syscalls..
