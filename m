From: Li.Xiubo@freescale.com (Li.Xiubo at freescale.com)
Date: Thu, 19 Dec 2013 05:19:26 +0000
Subject: [PATCHv3 5/7] ASoC: fsl: Add SGTL5000 based audio machine driver.
In-Reply-To: <20131218183743.GG31886@sirena.org.uk>
References: <1387250684-23406-1-git-send-email-Li.Xiubo@freescale.com>
 <1387250684-23406-6-git-send-email-Li.Xiubo@freescale.com>
 <20131218183743.GG31886@sirena.org.uk>
Message-ID: <f9a19c59bfaf4844bbeaca1aeb91e305@DM2PR03MB509.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Tue, Dec 17, 2013 at 11:24:42AM +0800, Xiubo Li wrote:
> 
> > This is the SGTL5000 codec based audio driver supported with both
> > playback and capture dai link implemention.
> 
> > This implementation is only compatible with device tree definition.
> 
> It looks like these cards should be supportable using the generic simple card
> bindings that Morimoto-san implemented, you can see these in -next as "ASoC:
> simple-card: add Device Tree support".  Can you check to see if that's the
> case?  If it is you'll still need Kconfig to enable building the SoC and CODEC
> drivers.
> 

Yes, almost, but maybe still need to do some adjust about it.

In this series of patches, the PATCH1~PATCH4 are about SAI only, and can be
apart from VF610-twr sound driver, I will sent the SAI driver and VF610-twr
sound driver separately. Could you apply the SAI's first if they are all fine?

I will use the simpe-card driver for the VF610-twr later.

> > +menuconfig SND_FSL_SOC
> > +	tristate "SoC Audio for Freescale VF610 CPUs"
> > +	help
> > +	  Say Y or M if you want to add support for codecs attached to
> > +	  the VF610 CPUs.
> > +
> > +	  This will enable Freeacale SAI and SGTL5000 codec, and an extra
> > +	  TWR-AUDIO-SGTL sub-board is needed for SGTL5000.
> 
> This should select the dmaengine helpers (and should really have been split
> out as part of the first patch).

I will revise this.

Best Regards,
Xiubo
