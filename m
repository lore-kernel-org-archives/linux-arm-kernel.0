From: broonie@kernel.org (Mark Brown)
Date: Thu, 18 Apr 2013 15:56:02 +0100
Subject: [alsa-devel] [PATCH v4 02/10] ASoC: imx-pcm-dma: DT support
In-Reply-To: <5170069F.4030200@metafoo.de>
References: <1366288424-7660-1-git-send-email-mpa@pengutronix.de>
 <1366288424-7660-3-git-send-email-mpa@pengutronix.de>
 <5170069F.4030200@metafoo.de>
Message-ID: <20130418145602.GL13687@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 04:43:43PM +0200, Lars-Peter Clausen wrote:
> On 04/18/2013 02:33 PM, Markus Pargmann wrote:

> > +	if (pdev->dev.platform_data)
> > +		pdev->dev.of_node = pdev->dev.platform_data;

> In my opinion it's better to use pdev->dev.parent->of_node here. In the ssi
> driver you use platform_device_register_data, which will create a copy of
> the of_node you pass in as platform data. I'm not quite sure how well this
> will work. If you want to continue to use platform_data you should at least
> change the code in the ssi driver to not make a copy of the of_node.

If nothing else the above code just looks wrong and confusing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130418/2fc43ee6/attachment-0001.sig>
