From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 5 Mar 2012 13:13:32 +0000
Subject: [PATCH 20/20] ASoC: fsl: add imx-sgtl5000 machine driver
In-Reply-To: <20120305130707.GF16232@S2101-09.ap.freescale.net>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
 <1330788001-10158-21-git-send-email-shawn.guo@linaro.org>
 <20120304133818.GE3083@opensource.wolfsonmicro.com>
 <20120305080623.GD16232@S2101-09.ap.freescale.net>
 <20120305115612.GB3224@opensource.wolfsonmicro.com>
 <20120305130707.GF16232@S2101-09.ap.freescale.net>
Message-ID: <20120305131332.GM3224@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2012 at 09:07:09PM +0800, Shawn Guo wrote:
> On Mon, Mar 05, 2012 at 11:56:12AM +0000, Mark Brown wrote:

> > In that
> > case they should either both be using the same device or should have
> > some sort of parent/child/sibling relationship.

> Sorry, I do not understand it.  Can you elaborate it a little bit?

The DMA and SSI drivers should have some relationship with each other if
they're the same piece of hardware.  The machine driver certainly
shouldn't be creating either of them.

> > Either way the machine
> > driver really shouldn't be involved in instantiating things, perhaps
> > arch/arm but not the audio machine driver.

> So you are saying neither what tegra_wm8903 and tegra_alc5632 are doing
> (registering pcm device in machine driver) nor what imx-ssi is doing
> (registering pcm device in DAI driver) is correct?  Can you please make
> it clear what's the right thing to do?

The above.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120305/b76986e0/attachment.sig>
