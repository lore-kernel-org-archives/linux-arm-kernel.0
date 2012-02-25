From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 25 Feb 2012 09:28:47 +0800
Subject: [PATCH 6/6] ASoC: fsl: check property 'compatible' for the
 machine name
In-Reply-To: <20120224141207.GI5450@opensource.wolfsonmicro.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-7-git-send-email-shawn.guo@linaro.org>
 <20120224141207.GI5450@opensource.wolfsonmicro.com>
Message-ID: <20120225012845.GF24268@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2012 at 02:12:07PM +0000, Mark Brown wrote:
> On Fri, Feb 24, 2012 at 10:09:41PM +0800, Shawn Guo wrote:
> > The fsl_ssi probe function detects the client machine name using model
> > property of the device tree.  But it will not work for the ARM client
> > machines which are to be added.  The model property is given as a
> > descriptive string on all ARM device tree (arch/arm/boot/*.dts).
> > Instead, the compatible property gives the machine name.
> 
> The ARM machines really shouldn't be using the bindings that PowerPC is
> using for the machine as they conflate the machine driver with the SSI
> binding.  The idiom for new systems is that machine drivers should be
> first class devices in the device tree referencing the SSI and CODEC.
> 
> The current bindings should be preserved for existing systems of course.

Per discussion [1], the whole point we move to fsl_ssi is that we can
reuse the DT support already in fsl_ssi.  If it's something we should
not use for IMX, I fail to see why we should make this move.

Regards,
Shawn

[1] http://article.gmane.org/gmane.linux.drivers.devicetree/6637
