From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 28 Jul 2012 16:02:50 +0800
Subject: [PATCH 2/2 V3] MXS: Implement DMA support into mxs-i2c
In-Reply-To: <20120721124406.GA9946@pengutronix.de>
References: <1341850974-11977-1-git-send-email-marex@denx.de>
 <1341850974-11977-2-git-send-email-marex@denx.de>
 <20120713082249.GF32184@pengutronix.de>
 <20120715081715.GA2429@S2100-06.ap.freescale.net>
 <20120721124406.GA9946@pengutronix.de>
Message-ID: <20120728080245.GA2128@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 21, 2012 at 02:44:06PM +0200, Wolfram Sang wrote:
> Yet, if I know the compatible property for the mxs I2C driver, and also
> know the CPU type (be it MX23 or MX28), I can deduce from that a lot of
> information, including DMA channel. That is fix. Why encode it?
> 
The driver shouldn't know the CPU type but just the IP type/version.
We can definitely have "fsl,imx23-i2c" and "fsl,imx28-i2c" compatible
strings for iMX23 and iMX28 respectively if the I2C controller on these
two SoC differs on the IP inside aspects.  But we shouldn't do that
for IO region, interrupt number, DMA channel such differences at SoC
integration level.

-- 
Regards,
Shawn
