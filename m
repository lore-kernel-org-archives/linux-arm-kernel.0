From: timur@tabi.org (Timur Tabi)
Date: Thu, 20 Mar 2014 10:10:09 -0500
Subject: [PATCH v2 16/16] ASoC: fsl-ssi: Use regmap
In-Reply-To: <5b62326226b54b1da0addf839cbcd104@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
 <1394887464-969-17-git-send-email-mpa@pengutronix.de>
 <1394894616.578942243@f331.i.mail.ru> <20140318081019.GJ11360@pengutronix.de>
 <5b62326226b54b1da0addf839cbcd104@BY2PR03MB505.namprd03.prod.outlook.com>
Message-ID: <532B04D1.9000405@tabi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/20/2014 01:07 AM, Li.Xiubo at freescale.com wrote:
> While for the scenario like our LS1(ARM) platform.
> CPU		SSI
> LE		BE	then should we set the .val_format_endian to
> 			REGMAP_ENDIAN_BIG
>
>
> And so not only for PowerPC, but also maybe for ARM platforms.
> So here how about just adding one Boolean property like 'big-endian' in DT node
> to learn the endianness of the devices dynamically ?

That's not a bad idea.  The property should be something like, 
"fsl,ssi-endian" and is should be set to "big", "little", or "native". 
In the absence of the property, it should default to native endian.
