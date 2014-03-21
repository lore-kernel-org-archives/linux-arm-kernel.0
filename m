From: Li.Xiubo@freescale.com (Li.Xiubo at freescale.com)
Date: Fri, 21 Mar 2014 09:19:13 +0000
Subject: [PATCH v2 16/16] ASoC: fsl-ssi: Use regmap
In-Reply-To: <20140321084537.GA30910@pengutronix.de>
References: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
 <1394887464-969-17-git-send-email-mpa@pengutronix.de>
 <1394894616.578942243@f331.i.mail.ru>
 <20140318081019.GJ11360@pengutronix.de>
 <5b62326226b54b1da0addf839cbcd104@BY2PR03MB505.namprd03.prod.outlook.com>
 <532B04D1.9000405@tabi.org> <20140321084537.GA30910@pengutronix.de>
Message-ID: <94d67ae23a9f4458ba7ed00ec4c748c2@BY2PR03MB505.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Subject: Re: [PATCH v2 16/16] ASoC: fsl-ssi: Use regmap
> 
> Hi,
> 
> On Thu, Mar 20, 2014 at 10:10:09AM -0500, Timur Tabi wrote:
> > On 03/20/2014 01:07 AM, Li.Xiubo at freescale.com wrote:
> > >While for the scenario like our LS1(ARM) platform.
> > >CPU		SSI
> > >LE		BE	then should we set the .val_format_endian to
> > >			REGMAP_ENDIAN_BIG
> > >
> > >
> > >And so not only for PowerPC, but also maybe for ARM platforms.
> > >So here how about just adding one Boolean property like 'big-endian' in DT
> node
> > >to learn the endianness of the devices dynamically ?
> >
> > That's not a bad idea.  The property should be something like,
> > "fsl,ssi-endian" and is should be set to "big", "little", or
> > "native". In the absence of the property, it should default to
> > native endian.
> 
> Perhaps it is better to create some generic binding for that? There may
> be other drivers/components that have the same strange combinations and
> need a similar binding to use for regmap.
> 
> We could use something like an "endian" property with "big", "little"
> and "native" which is then parsed by some function of the regmap
> framework. It could directly fill those information into the
> struct regmap_config.
> 
> Thanks,
> 
> Markus
> 

Yes, actually the fsl-sai, fsl-esai and fsl-spdif have already supported
this. In our Platforms of Vybird, LS1 and LS2 will support different endianess
of these devices and also many other IP blocks.

But I used the Boolean property like "big-endian" and this is enough, because
for now the regmap core does not support the following scenario:

CPU		IP
------------------
BE		LE

:)

Thanks,
--

Best Regards,
Xiubo
