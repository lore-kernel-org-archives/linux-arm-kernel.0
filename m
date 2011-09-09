From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 9 Sep 2011 19:04:34 +0800
Subject: [PATCH REPOST 2/2] i2c-imx: add device tree probe support
In-Reply-To: <20110909071845.GI28816@pengutronix.de>
References: <1315465775-31335-1-git-send-email-shawn.guo@linaro.org>
	<1315465775-31335-3-git-send-email-shawn.guo@linaro.org>
	<4E69A0AE.1060004@gmail.com>
	<20110909071845.GI28816@pengutronix.de>
Message-ID: <20110909110433.GH31581@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 09, 2011 at 09:18:45AM +0200, Uwe Kleine-K?nig wrote:
> Hello Rob,
> 
> On Fri, Sep 09, 2011 at 12:14:22AM -0500, Rob Herring wrote:
> > > +i2c at 83fc4000 { /* I2C2 on i.MX51 */
> > > +	compatible = "fsl,imx51-i2c", "fsl,imx1-i2c";
> > > +	reg = <0x83fc4000 0x4000>;
> > > +	interrupts = <63>;
> > > +};
> > > +
> > > +i2c at 70038000 { /* HS-I2C on i.MX51 */
> > 
> > The mainline driver doesn't support the HS-I2C block does it?
> > 
> > The high speed and "old" i2c blocks on MX51 are basically different
> > blocks, so the compatible property should be different.
> I stumbled about that recently, too and found in
> arch/arm/plat-mxc/devices/platform-imx-i2c.c that the third device
> description for imx51 is a normal "imx-i2c" one using
> MX51_HSI2C_DMA_BASE_ADDR. So I concluded it's different but compatible.
> 
> board-mx51_babbage.c uses imx51_add_hsi2c but doesn't add a bus
> description. So It might not attract attention if the driver doesn't
> match the device.
> 
Aha, I was confused by the platform codes.  Will drop HSI2C.

Thanks for catching this, Rob.

-- 
Regards,
Shawn
