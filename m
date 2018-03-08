From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 8 Mar 2018 16:04:26 +0800
Subject: [PATCH] ARM: dts: imx6q: Add support for the DHCOM iMX6 SoM and
 PDK2
In-Reply-To: <f8263399-c9b9-4c76-b468-8eb49b172139@denx.de>
References: <20180224210429.18606-1-marex@denx.de>
 <20180228053432.GG3217@dragon>
 <f8263399-c9b9-4c76-b468-8eb49b172139@denx.de>
Message-ID: <20180308080425.GQ3217@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2018 at 06:46:01PM +0100, Marek Vasut wrote:
> On 02/28/2018 06:34 AM, Shawn Guo wrote:
> > On Sat, Feb 24, 2018 at 10:04:29PM +0100, Marek Vasut wrote:
> >> Add support for the DH i.MX6 Quad based SoM and a PDK2 evaluation board.
> >> The evaluation board features three serial ports, USB OTG, USB host with
> >> an USB hub, Fast or Gigabit ethernet, eMMC, uSD, SD, mSATA, analog audio,
> >> PCIe and HDMI video output.
> >>
> >> All of the aforementioned features are supported by this patch.
> >>
> >> Signed-off-by: Marek Vasut <marex@denx.de>
> >> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> >> Cc: Shawn Guo <shawnguo@kernel.org>
> 
> [...]
> 
> >> +	rtc at 56 {
> > 
> > The node name says it's a RTC ...
> > 
> >> +		compatible = "rv3029c2";
> > 
> > ... the compatible is defined in bindings/i2c/i2c-gpio.txt and should be
> > a I2C GPIO expander.  Confused.
> 
> Very quick git grep reveals
> drivers/rtc/rtc-rv3029c2.c

Oops.  The compatible is used in the example of i2c-gpio binding as an
I2C device on i2c-gpio bus.  Sorry.

Shawn
