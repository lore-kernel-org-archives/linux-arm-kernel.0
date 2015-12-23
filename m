From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 23 Dec 2015 10:27:34 +0800
Subject: [PATCH V3] ARM: dts: imx6q-icore-rqs: Add Engicam IMX6 Q7
 initial support
In-Reply-To: <20151216181159.GC20121@panicking>
References: <1447673895.3144.16.camel@pengutronix.de>
 <20151116114127.GB10464@panicking>
 <1447674695.3144.21.camel@pengutronix.de>
 <20151116115421.GC10464@panicking> <20151116172318.GA513@panicking>
 <1447752697.3144.47.camel@pengutronix.de>
 <20151118151030.GA11558@panicking> <20151211083512.GB11252@tiger>
 <20151214084456.GA4305@panicking>
 <20151216181159.GC20121@panicking>
Message-ID: <20151223022707.GG26290@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 16, 2015 at 07:12:05PM +0100, Michael Trimarchi wrote:
> > > > +	imx6qdl-icore-rqs {
> > > > +
> > > 
> > > With commit 5fcdf6a7ed95 (pinctrl: imx: Allow parsing DT without function
> > > nodes) in place, we can now save this container.
> > > 
> 
> If I save this I can not register usb. Group is not found
> 
> [    2.768476] imx6q-pinctrl 20e0000.iomuxc: unable to find group for node usdhc1grp-1
> [    2.768844] imx6q-pinctrl 20e0000.iomuxc: unable to find group for node usdhc1grp-1
> [    2.768932] sdhci-esdhc-imx: probe of 2190000.usdhc failed with error -22
> [    2.768994] imx6q-pinctrl 20e0000.iomuxc: unable to find group for node usdhc3grp-2
> [    2.769240] imx6q-pinctrl 20e0000.iomuxc: unable to find group for node usdhc3grp-2
> [    2.769322] sdhci-esdhc-imx: probe of 2198000.usdhc failed with error -22
> [    2.769381] imx6q-pinctrl 20e0000.iomuxc: unable to find group for node usdhc4grp-1
> [    2.769621] imx6q-pinctrl 20e0000.iomuxc: unable to find group for node usdhc4grp-1
> [    2.769701] sdhci-esdhc-imx: probe of 219c000.usdhc failed with error -22

Sorry.  I just found that to get this work on imx6q board we need to
clean up the ipu2/ipu2grp-1 group.  I just send a patch doing that with
you on copy.  Let me know if it works for you.

Shawn
