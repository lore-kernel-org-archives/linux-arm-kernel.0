From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 25 Feb 2012 21:09:53 +0800
Subject: [PATCH 6/6] ASoC: fsl: check property 'compatible' for the
 machine name
In-Reply-To: <20120225114227.GB3167@opensource.wolfsonmicro.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-7-git-send-email-shawn.guo@linaro.org>
 <20120224141207.GI5450@opensource.wolfsonmicro.com>
 <20120225012845.GF24268@S2101-09.ap.freescale.net>
 <20120225114227.GB3167@opensource.wolfsonmicro.com>
Message-ID: <20120225130943.GB25201@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 25, 2012 at 11:42:28AM +0000, Mark Brown wrote:
> On Sat, Feb 25, 2012 at 09:28:47AM +0800, Shawn Guo wrote:
> 
> > Per discussion [1], the whole point we move to fsl_ssi is that we can
> > reuse the DT support already in fsl_ssi.  If it's something we should
> > not use for IMX, I fail to see why we should make this move.
> 
> I was assuming that the idea was to share the code for device control
> as the same IP block was being deployed in the various Freescale SoCs
> - if the only thing they have in common is the device tree support it
> would be a bit strange to merge them.
> 
Here is the thing.

For historical reason, there are two drivers for the same SSI block
found on PowerPC and IMX, fsl_ssi and imx-ssi.  The fsl_ssi driver is
used on PowerPC with DT support, while imx-ssi is used on IMX with no
DT support.  Along with the work of supporting DT for the modern IMX
SoCs, I was planning to add DT support into imx-ssi.  But I was told
by Timur that instead of doing that, I should reuse fsl_ssi for those
DT aware IMX platforms.  From his POV, one big reason of why imx-ssi
was created is that ARM/IMX did not support DT before while fsl_ssi was
born to support DT only.  Since ARM/IMX starts supporting DT, fsl_ssi
should be reused there.

I'm personally fine with either reusing fsl_ssi or adding DT support
into imx-ssi.  I do not see any problem with reusing fsl_ssi so far,
but I can quickly turn around to adding new binding for imx-ssi if
you are strong on this position.

> Note that it's purely the bit where the machine driver is instantiated
> from the SSI (which is just one or two of several properties) that I'm
> talking about here, the bindings for the SSI itself look good.

Hmm, there is no SSI binding property contributing to instantiating
the machine driver.  It looks /model property for the device name used
to instantiate the machine driver, which I personally think is fine.

-- 
Regards,
Shawn
