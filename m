From: olof@lixom.net (Olof Johansson)
Date: Tue, 2 Aug 2016 12:35:24 -0700
Subject: [PATCH] Fix shmobile build with CONFIG_SMP=n
In-Reply-To: <20160720231416.GC9599@verge.net.au>
References: <20160719115703.GJ1041@n2100.armlinux.org.uk>
 <CAMuHMdWfqbv4MXuThRPL2hsdN4Hq53Ng=1cp8DBB7o7XGzM9Zw@mail.gmail.com>
 <20160720231416.GC9599@verge.net.au>
Message-ID: <20160802193524.GA6423@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 21, 2016 at 08:14:17AM +0900, Simon Horman wrote:
> On Tue, Jul 19, 2016 at 02:02:53PM +0200, Geert Uytterhoeven wrote:
> > Hi Russell,
> > 
> > On Tue, Jul 19, 2016 at 1:57 PM, Russell King - ARM Linux
> > <linux@armlinux.org.uk> wrote:
> > > Shmobile currently fails to build when CONFIG_SMP is disabled:
> > >
> > > arch/arm/mach-shmobile/built-in.o: In function `shmobile_smp_init_fallback_ops':
> > > pm-rcar-gen2.c:(.init.text+0x744): undefined reference to `platform_can_secondary_boot'
> > > make[1]: *** [vmlinux] Error 1
> > >
> > > Fix this by providing a stub for this function.
> > >
> > > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > 
> > Arnd send a smaller one https://patchwork.kernel.org/patch/9207413/,
> > which seems have fallen through the cracks.
> 
> Sorry for missing that. I have queued up Arnd's patch as a fix for v4.8
> with Acked-by Geert and a Reported-by Russel tags.

Since I haven't seen this patch yet, I've applied it (Arnd's version) directly
to our fixes branch.


-Olof
