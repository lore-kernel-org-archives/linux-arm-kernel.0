From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 26 Jan 2013 10:06:11 -0500
Subject: [PATCH V3 8/8] ARM: kirkwood: mv643xx_eth dt conversion
In-Reply-To: <20130126123827.GA5786@lunn.ch>
References: <cover.1359146831.git.jason@lakedaemon.net>
 <a4805edf01c39a374d71fbf4a6b6207dedf6b2bf.1359146831.git.jason@lakedaemon.net>
 <20130126123827.GA5786@lunn.ch>
Message-ID: <20130126150611.GL1758@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 26, 2013 at 01:38:27PM +0100, Andrew Lunn wrote:
> > diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
> > index 73b76e4..7ab92e5 100644
> > --- a/arch/arm/mach-kirkwood/board-dt.c
> > +++ b/arch/arm/mach-kirkwood/board-dt.c
> > @@ -48,7 +48,7 @@ static void __init kirkwood_legacy_clk_init(void)
> >  	clkspec.args_count = 1;
> >  
> >  	clkspec.args[0] = CGC_BIT_GE0;
> > -	orion_clkdev_add(NULL, "mv643xx_eth_port.0",
> > +	orion_clkdev_add(NULL, "f1072000.egiga0",
> >  			 of_clk_get_from_provider(&clkspec));
> >  
> >  	clkspec.args[0] = CGC_BIT_PEX0;
> > @@ -60,7 +60,7 @@ static void __init kirkwood_legacy_clk_init(void)
> >  			 of_clk_get_from_provider(&clkspec));
> >  
> >  	clkspec.args[0] = CGC_BIT_GE1;
> > -	orion_clkdev_add(NULL, "mv643xx_eth_port.1",
> > +	orion_clkdev_add(NULL, "f1076000.egiga1",
> >  			 of_clk_get_from_provider(&clkspec));
> >  }
> >  
> 
> Hi Jason
> 
> These changes break any platform not yet converted, eg my QNAP box now
> locks up solid.
> 
> Something is not right here, or i'm not understanding something. DT
> devices should not need code like this, only devices not yet using
> DT....

Yes, hence my frustration yesterday.  I posted this so everyone could
see exactly what I was working with, and perhaps spot something I had
missed.  Looks like you did in your followup to Sebastian.

thx,

Jason.
