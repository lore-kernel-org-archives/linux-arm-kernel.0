From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 5 Mar 2012 11:56:12 +0000
Subject: [PATCH 20/20] ASoC: fsl: add imx-sgtl5000 machine driver
In-Reply-To: <20120305080623.GD16232@S2101-09.ap.freescale.net>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
 <1330788001-10158-21-git-send-email-shawn.guo@linaro.org>
 <20120304133818.GE3083@opensource.wolfsonmicro.com>
 <20120305080623.GD16232@S2101-09.ap.freescale.net>
Message-ID: <20120305115612.GB3224@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2012 at 04:06:25PM +0800, Shawn Guo wrote:
> On Sun, Mar 04, 2012 at 01:38:18PM +0000, Mark Brown wrote:

> > This looks like there's a problem with the bindings, why are you
> > registering the DMA device from the card?

> There is a dma node in the device tree to instantiate the dma device
> backed by a dmaengine driver.  As a client peripheral of that dmaengine
> device, the SSI owns just a dma request/event number.  With the number
> encoded in SSI node, there is no hardware resource to be claimed by
> that pcm-device, so we do not have it in device tree.  Then we have
> to register this device in either fsl_ssi driver or machine driver.
> I chose to do something that tegra is doing, registering the pcm device
> in machine driver, to keep fsl_ssi away from imx specific bits as much
> as possible.

The above sounds like you have a unified DAI and PCM driver.  In that
case they should either both be using the same device or should have
some sort of parent/child/sibling relationship.  Either way the machine
driver really shouldn't be involved in instantiating things, perhaps
arch/arm but not the audio machine driver.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120305/077dad37/attachment.sig>
