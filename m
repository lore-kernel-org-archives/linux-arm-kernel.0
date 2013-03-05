From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 5 Mar 2013 19:02:31 +0100
Subject: [PATCH] ARM: dove: Fix typo "COMMON_CLK_DOVE"
In-Reply-To: <20130305140025.GO23237@titan.lakedaemon.net>
References: <1362476098.16460.65.camel@x61.thuisdomein>
 <20130305140025.GO23237@titan.lakedaemon.net>
Message-ID: <20130305190232.0b1a5e29@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 5 Mar 2013 09:00:25 -0500
Jason Cooper <jason@lakedaemon.net> wrote:

> On Tue, Mar 05, 2013 at 10:34:58AM +0100, Paul Bolle wrote:
> > Commit 5b03df9ace680d7cdd34a69dfd85ca5f74159d18 ("ARM: dove: switch to
> > DT clock providers") added "select COMMON_CLK_DOVE" to Marvell Dove's
> > Kconfig entry. But there's no Kconfig symbol COMMON_CLK_DOVE, which
> > makes this select statement a nop. Since the Marvell Dove code includes
> > <linux/clk-provider.h> we can assume that this entry needs to select
> > COMMON_CLK instead.
> > 
> > Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> > ---
> > Untested.
> > 
> >  arch/arm/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)  
> 
> Nice catch, thanks for the patch.  Sebastian, could you test this and
> report back?

I also have a Cubox and I generated a kernel 3.9-rc1 for it (not tested
yet).

The .config contains CONFIG_COMMON_CLK=y naturally because MACH_DOVE
selects PLAT_ORION_LEGACY which selects PLAT_ORION which selects
COMMON_CLK.

So, "select COMMON_CLK" is not needed in ARCH_DOVE.

BTW, why is there a PLAT_ORION_LEGACY?

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
