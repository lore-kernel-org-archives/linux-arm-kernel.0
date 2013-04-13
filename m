From: mpa@pengutronix.de (Markus Pargmann)
Date: Sat, 13 Apr 2013 15:52:31 +0200
Subject: [PATCH v2 06/11] ASoC: fsl-ssi: Setup generic imx dma params
In-Reply-To: <5162306B.6090207@tabi.org>
References: <1365362721-3731-1-git-send-email-mpa@pengutronix.de>
 <1365362721-3731-7-git-send-email-mpa@pengutronix.de>
 <5162306B.6090207@tabi.org>
Message-ID: <20130413135231.GC4573@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 07, 2013 at 09:50:19PM -0500, Timur Tabi wrote:
> Markus Pargmann wrote:
> >-		ret = of_property_read_u32_array(pdev->dev.of_node,
> >-					"fsl,ssi-dma-events", dma_events, 2);
> 
> Does this mean that the "fsl,ssi-dma-events" property is no longer used?

Yes, I just realized that it would break all platforms that do not have
a DMA driver with generic bindings yet. So I will instead still check
for this property in case 'dmas' is not set.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
