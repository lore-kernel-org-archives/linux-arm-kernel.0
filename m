From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 6 Mar 2012 20:11:53 +0000
Subject: [alsa-devel] [PATCH 20/20] ASoC: fsl: add imx-sgtl5000 machine
 driver
In-Reply-To: <4F565528.1090505@wwwdotorg.org>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
 <1330788001-10158-21-git-send-email-shawn.guo@linaro.org>
 <20120304133818.GE3083@opensource.wolfsonmicro.com>
 <20120305080623.GD16232@S2101-09.ap.freescale.net>
 <20120305115612.GB3224@opensource.wolfsonmicro.com>
 <20120305130707.GF16232@S2101-09.ap.freescale.net>
 <20120305131332.GM3224@opensource.wolfsonmicro.com>
 <74CDBE0F657A3D45AFBB94109FB122FF17BE861C14@HQMAIL01.nvidia.com>
 <20120305170317.GV3224@opensource.wolfsonmicro.com>
 <4F565528.1090505@wwwdotorg.org>
Message-ID: <20120306201153.GF19635@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 06, 2012 at 11:19:20AM -0700, Stephen Warren wrote:

> > In this case (and probably in the i.MX case, at a guess the structure is
> > the same) I'd just have the DAI drivers kick off registration of the
> > ASoC DMA stuff, it's all part of the ASoC driver for the hardware really.
> 
> How would that work when there are multiple DAIs, e.g. on a system with
> 2 I2S and 1 SPDIF DAI and they all want to register the PCM driver? I
> guess I could just add some utility function in the PCM driver file to
> ensure that the platform device only gets created once, and probably
> would also need to refcount it for when the DAIs get unloaded etc.

You could just create a DMA device per DAI since it's just a wrapper,
you shouldn't even need to allocate a new struct device but just use the
DAI device when registering the ASoC DMA driver.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120306/6289f0aa/attachment.sig>
