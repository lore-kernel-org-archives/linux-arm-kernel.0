From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Jul 2014 20:52:58 +0200
Subject: [PATCH] ARM: imx6: fix SMP compilation again
In-Reply-To: <20140722145256.GA8537@dragon>
References: <37015543.ZyZKZyEIPW@wuerfel> <12850450.mxMbPOMjsW@wuerfel>
 <20140722145256.GA8537@dragon>
Message-ID: <6831797.zmrgHS8Arb@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 July 2014 22:52:57 Shawn Guo wrote:
> On Tue, Jul 22, 2014 at 04:37:55PM +0200, Arnd Bergmann wrote:
> > On Tuesday 22 July 2014 21:48:16 Shawn Guo wrote:
> > > I tried both mainline and -next tree.  I really need some help to
> > > reproduce the error first.
> > 
> > My branch is at git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
> > in the randconfig-next branch. Sorry for the inconvenience.
> 
> Okay, I can see the error on your branch with the fixing patch reverted.
> 
> > 
> > > > arch/arm/mach-imx/built-in.o: In function `v7_secondary_startup':
> > > > :(.text+0x5124): undefined reference to `v7_invalidate_l1'
> > > > 
> > > > This puts the code inside of an "ifdef CONFIG_SMP" to hopefully
> > > 
> > > The code says "ifdef CONFIG_SOC_IMX6"?
> > 
> > It seems I'm having a bad day. I'll fix it up.
> 
> With that fixed up,
> 
> Acked-by: Shawn Guo <shawn.guo@freescale.com>
> 
> Or let me know if you expect me to handle the patch.
> 

If you don't mind, just put it into your tree. I'm currently in the
middle of going through my older patches and don't want to lose this one.

	Arnd
