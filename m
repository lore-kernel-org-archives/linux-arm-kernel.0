From: Li.Xiubo@freescale.com (Li.Xiubo at freescale.com)
Date: Fri, 26 Sep 2014 03:14:26 +0000
Subject: [PATCH v3] ARM: ls1021a: add gating clocks to IP blocks.
In-Reply-To: <20140926015713.GG21077@dragon>
References: <1411476275-9164-1-git-send-email-Li.Xiubo@freescale.com>
 <20140925085403.GG6405@dragon>
 <e44a1930e8de43ec8beb6e60fa9c1e9e@BY2PR0301MB0613.namprd03.prod.outlook.com>
 <20140926015713.GG21077@dragon>
Message-ID: <eb17fb36d1a04812836ad46bace8c4bf@BY2PR0301MB0613.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > As the parent of the clocks registered by this function is "dummy" from
> > > what I see, what is the point of setting flag CLK_SET_RATE_PARENT then?
> > >
> > > > +			CLK_IGNORE_UNUSED, reg,	shift,
> > >
> > > Why flag CLK_IGNORE_UNUSED?
> > >
> >
> > As the SoC reference manual all the IP blocks will be enabled when powered
> up.
> > But the Linux OS will disable all the IP blocks' clocks as default without
> this.
> >
> > For now, this gate driver will only used for PM support of some IP blocks.
> For the
> > Others needed to be enabled as default.
> 
> Ok, got it. I'm fine with the flag then, and we can remove it after all
> those client devices manage their clocks well.
> 

Okay.

Thanks,

BRs
Xiubo


> Shawn
