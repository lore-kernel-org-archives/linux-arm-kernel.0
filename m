From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Tue, 27 Jan 2015 23:52:47 +0000
Subject: [PATCH v2 1/3] ARM: shmobile: armadillo800eva: Properly specify
 HDMI audio link format
In-Reply-To: <54C74A2D.6000606@metafoo.de>
References: <1421847492-8857-1-git-send-email-lars@metafoo.de>
 <8761bsacx5.wl%kuninori.morimoto.gx@renesas.com>
 <54C74A2D.6000606@metafoo.de>
Message-ID: <87fvavlr0b.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Lars

> > I guess if you want to use common .daifmt, it should be same as "codec" side.
> > (cpu side "S" means, codec / daifmt side "M")
> > So, this mean above should be
> >
> > @@ -1040,9 +1040,9 @@ static struct asoc_simple_card_info fsi2_hdmi_info = {
> >   	.card		= "FSI2B-HDMI",
> >   	.codec		= "sh-mobile-hdmi",
> >   	.platform	= "sh_fsi2",
> > +	.daifmt		= SND_SOC_DAIFMT_CBM_CFM,   <=
> >   	.cpu_dai = {
> > 		.name	= "fsib-dai",
> > -		.fmt	= SND_SOC_DAIFMT_CBS_CFS,
> >   	},
> 
> Right now the CPU is configured as master, with your proposed change it 
> would be configured as slave. These flags are always from the CODEC's 
> perspective.

I see, your patch was correct for CPU = Master
