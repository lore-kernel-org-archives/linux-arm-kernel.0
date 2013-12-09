From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 9 Dec 2013 11:31:57 +0800
Subject: [PATCH 3/3] Add support for the eukrea-cpuimx28.
In-Reply-To: <20131209032530.GC825@S2101-09.ap.freescale.net>
References: <1386250086-4666-1-git-send-email-denis@eukrea.com>
 <1386250086-4666-3-git-send-email-denis@eukrea.com>
 <20131209032530.GC825@S2101-09.ap.freescale.net>
Message-ID: <20131209033150.GA6265@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 09, 2013 at 11:25:32AM +0800, Shawn Guo wrote:
> > diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
> > index 02b17f7..3b5f57e 100644
> > --- a/arch/arm/mach-mxs/mach-mxs.c
> > +++ b/arch/arm/mach-mxs/mach-mxs.c
> > @@ -448,6 +448,12 @@ static int __init mxs_restart_init(void)
> >  	return 0;
> >  }
> >  
> > +static void __init eukrea_mbmx283lc_init(void)
> > +{
> > +	enable_clk_enet_out();
> 
> This shouldn't be needed since commit daa7d39 (net: freescale: fec: add
> support for optional enet_out clk) and commit (f231a9f ARM: dts: mxs:
> add enet_out clock to devicetree)

I just fixed it up and apply the patch.  Please test it and report back
if it does not work for you.

Shawn
