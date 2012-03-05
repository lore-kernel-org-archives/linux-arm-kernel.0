From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 5 Mar 2012 17:32:30 +0000
Subject: [PATCH 20/20] ASoC: fsl: add imx-sgtl5000 machine driver
In-Reply-To: <4F54F0CE.60706@freescale.com>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
 <1330788001-10158-21-git-send-email-shawn.guo@linaro.org>
 <20120304133818.GE3083@opensource.wolfsonmicro.com>
 <20120305080623.GD16232@S2101-09.ap.freescale.net>
 <20120305115612.GB3224@opensource.wolfsonmicro.com>
 <20120305130707.GF16232@S2101-09.ap.freescale.net>
 <20120305131332.GM3224@opensource.wolfsonmicro.com>
 <4F54F0CE.60706@freescale.com>
Message-ID: <20120305173230.GW3224@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2012 at 10:58:54AM -0600, Timur Tabi wrote:
> Mark Brown wrote:

> > The DMA and SSI drivers should have some relationship with each other if
> > they're the same piece of hardware.  

> The DMA and SSI are completely separate blocks in the SOC.  On PowerPC,
> the P1022 SOC has an SSI and the standard FSL PPC DMA controller (we call
> it the Elo controller).  On i.MX, there is a completely different DMA
> controller (I'm not familiar with it), but the same exact SSI.

Right, but in both cases we're talking about the adaption layer from
ASoC to the support for the controller which is shared between
everything on the SoC (though currently the PowerPC one just talks to
the registers directly) so logically from a system perspective it's a
part of the SSI driver.

Possibly the way to go here is to just call the DMA driver something
generic (though you don't really need a separate Linux level device from
a subsystem point of view) or have a library function which is
implemented differently on each platform then have the SSI driver either
create the device or do the call.

Either way it's something the SoC code ought to be handling, individual
machine drivers shouldn't have to worry themselves about it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120305/36480437/attachment.sig>
