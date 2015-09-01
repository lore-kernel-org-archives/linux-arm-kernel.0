From: broonie@kernel.org (Mark Brown)
Date: Tue, 1 Sep 2015 19:43:35 +0100
Subject: ARM: pxa: build error in arch/arm/plat-pxa/ssp.c
In-Reply-To: <55E54754.1060002@linux.intel.com>
References: <1441073073.12012.3.camel@ingics.com>
 <55E54754.1060002@linux.intel.com>
Message-ID: <20150901184335.GY5313@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 01, 2015 at 09:36:04AM +0300, Jarkko Nikula wrote:

> No I'm pondering how to fix this. I see these bindings are added by the
> commit a6e56c28a178 ("ARM: pxa: ssp: add DT bindings") but some of the types
> are not used anywhere. For instance PXA168_SSP or PXA910_SSP. Then
> PXA3xx_SSP is used in sound/soc/pxa/pxa-ssp.c and CE4100_SSP in
> drivers/spi/spi-pxa2xx.c (where LPSS_SSP was used too before differentiating
> it).

IIRC the PXA168 and PXA910 are software compatible with the PXA3xx SPI
controller.  Those SoCs never got wide distribution compared to the
older PXA models I think.

> What I'm wondering is this binding below correct in arch/arm/plat-pxa/ssp.c?
> LPSS_SSP was meant to be for Intel Intel Low Power Subsystem SPI.

> "{ .compatible = "mrvl,lpss-ssp",	.data = (void *) LPSS_SSP }"

> Mika, Daniel: do you know is there any change there is a Marvell PXA
> platform compatible with Intel LPSS or is above binding bogus?

I bet it's just cut'n'paste because everything else about the driver and
all the DT is for Marvell stuff.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150901/4364aa1a/attachment.sig>
