From: rabin@rab.in (Rabin Vincent)
Date: Wed, 14 Jul 2010 22:53:19 +0530
Subject: [PATCH] arm: fix mach-versatile booting in qemu
In-Reply-To: <201007141716.09384.arnd@arndb.de>
References: <201007141716.09384.arnd@arndb.de>
Message-ID: <20100714172319.GA8933@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 14, 2010 at 05:16:09PM +0200, Arnd Bergmann wrote:
> The versatile platform has not been able to boot in qemu since 2.6.34-rc2,
> because e388771 "ARM: Realview/Versatile: separate out common SP804
> timer code" changed the behavior of the versatile_set_mode function.
> 
> This restores the original way it worked until 2.6.34-rc1.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I found this with git-bisect. I do not know wether the old behavior
> that this reverts to is sensible, but it's how both versatile and
> realview have been doing it since they first started using clockevents.
> 
> I also don't know if the same problem exists on actual versatile
> hardware or if it's really a qemu bug.

It's a QEMU bug.  It was fixed with this patch to QEMU:

http://www.mail-archive.com/qemu-devel at nongnu.org/msg30785.html

Rabin
