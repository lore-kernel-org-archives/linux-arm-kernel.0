From: horms@verge.net.au (Simon Horman)
Date: Thu, 21 Jul 2016 08:14:17 +0900
Subject: [PATCH] Fix shmobile build with CONFIG_SMP=n
In-Reply-To: <CAMuHMdWfqbv4MXuThRPL2hsdN4Hq53Ng=1cp8DBB7o7XGzM9Zw@mail.gmail.com>
References: <20160719115703.GJ1041@n2100.armlinux.org.uk>
 <CAMuHMdWfqbv4MXuThRPL2hsdN4Hq53Ng=1cp8DBB7o7XGzM9Zw@mail.gmail.com>
Message-ID: <20160720231416.GC9599@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2016 at 02:02:53PM +0200, Geert Uytterhoeven wrote:
> Hi Russell,
> 
> On Tue, Jul 19, 2016 at 1:57 PM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > Shmobile currently fails to build when CONFIG_SMP is disabled:
> >
> > arch/arm/mach-shmobile/built-in.o: In function `shmobile_smp_init_fallback_ops':
> > pm-rcar-gen2.c:(.init.text+0x744): undefined reference to `platform_can_secondary_boot'
> > make[1]: *** [vmlinux] Error 1
> >
> > Fix this by providing a stub for this function.
> >
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> 
> Arnd send a smaller one https://patchwork.kernel.org/patch/9207413/,
> which seems have fallen through the cracks.

Sorry for missing that. I have queued up Arnd's patch as a fix for v4.8
with Acked-by Geert and a Reported-by Russel tags.
