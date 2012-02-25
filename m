From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 25 Feb 2012 11:42:28 +0000
Subject: [PATCH 6/6] ASoC: fsl: check property 'compatible' for the
 machine name
In-Reply-To: <20120225012845.GF24268@S2101-09.ap.freescale.net>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-7-git-send-email-shawn.guo@linaro.org>
 <20120224141207.GI5450@opensource.wolfsonmicro.com>
 <20120225012845.GF24268@S2101-09.ap.freescale.net>
Message-ID: <20120225114227.GB3167@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 25, 2012 at 09:28:47AM +0800, Shawn Guo wrote:

> Per discussion [1], the whole point we move to fsl_ssi is that we can
> reuse the DT support already in fsl_ssi.  If it's something we should
> not use for IMX, I fail to see why we should make this move.

I was assuming that the idea was to share the code for device control
as the same IP block was being deployed in the various Freescale SoCs
- if the only thing they have in common is the device tree support it
would be a bit strange to merge them.

Note that it's purely the bit where the machine driver is instantiated
from the SSI (which is just one or two of several properties) that I'm
talking about here, the bindings for the SSI itself look good.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120225/2640971a/attachment.sig>
