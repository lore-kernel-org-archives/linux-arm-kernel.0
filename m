From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 26 Aug 2013 18:06:36 +0800
Subject: [PATCH v3 1/3] arm: mvebu: add missing of_node_put() to fix
 reference leak
In-Reply-To: <20130826120200.2269ba82@skate>
References: <1377510981-1793-1-git-send-email-jszhang@marvell.com>
 <1377510981-1793-2-git-send-email-jszhang@marvell.com>
 <20130826120200.2269ba82@skate>
Message-ID: <20130826180636.3e2bdb20@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Thomas,

On Mon, 26 Aug 2013 03:02:00 -0700
Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> Dear Jisheng Zhang,
> 
> On Mon, 26 Aug 2013 17:56:19 +0800, Jisheng Zhang wrote:
> 
> > diff --git a/arch/arm/mach-mvebu/armada-370-xp.c
> > b/arch/arm/mach-mvebu/armada-370-xp.c index 97cbb80..8a1ae83 100644
> > --- a/arch/arm/mach-mvebu/armada-370-xp.c
> > +++ b/arch/arm/mach-mvebu/armada-370-xp.c
> > @@ -64,6 +64,7 @@ static void __init armada_370_xp_mbus_init(void)
> >  			ARMADA_370_XP_MBUS_WINS_SIZE,
> >  			of_translate_address(dn, &sdram_wins_offs),
> >  			ARMADA_370_XP_SDRAM_WINS_SIZE);
> > +	of_node_put(dn);
> >  }
> 
> With the integration of Ezequiel patches that add DT support to the
> mvebu-mbus driver, this chunk of the code is no longer needed, as of
> linux-next.
> 
Got it. Thanks for the information. Will send v4 latter

Thanks,
Jisheng
