From: Li.Xiubo@freescale.com (Li.Xiubo at freescale.com)
Date: Fri, 21 Mar 2014 01:52:25 +0000
Subject: [PATCH v2 16/16] ASoC: fsl-ssi: Use regmap
In-Reply-To: <532B04D1.9000405@tabi.org>
References: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
 <1394887464-969-17-git-send-email-mpa@pengutronix.de>
 <1394894616.578942243@f331.i.mail.ru>
 <20140318081019.GJ11360@pengutronix.de>
 <5b62326226b54b1da0addf839cbcd104@BY2PR03MB505.namprd03.prod.outlook.com>
 <532B04D1.9000405@tabi.org>
Message-ID: <283cb220a2e5421f8ba7e9ca11bec60d@BY2PR03MB505.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: Re: [PATCH v2 16/16] ASoC: fsl-ssi: Use regmap
> 
> On 03/20/2014 01:07 AM, Li.Xiubo at freescale.com wrote:
> > While for the scenario like our LS1(ARM) platform.
> > CPU		SSI
> > LE		BE	then should we set the .val_format_endian to
> > 			REGMAP_ENDIAN_BIG
> >
> >
> > And so not only for PowerPC, but also maybe for ARM platforms.
> > So here how about just adding one Boolean property like 'big-endian' in DT
> node
> > to learn the endianness of the devices dynamically ?
> 
> That's not a bad idea.  The property should be something like,
> "fsl,ssi-endian" and is should be set to "big", "little", or "native".
> In the absence of the property, it should default to native endian.
> 

Well, yes, sounds good.
That will lead the individual driver a little more complex. I do think that
The regmap core should use the REGMAP_ENDIAN_SWAP instead of 
REGMAP_ENDIAN_BIG/LITTLE ones if possible.


:)
Thanks,
--

Best Regards,
Xiubo
