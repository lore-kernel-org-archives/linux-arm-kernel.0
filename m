From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Sep 2015 21:33:57 +0100
Subject: [PATCH v2 1/9] ARM: dts: imx6dql-nitrogen6x: add touchscreen
 support
In-Reply-To: <1441723760.3241.26.camel@pengutronix.de>
References: <1441645069-27263-1-git-send-email-gary.bisson@boundarydevices.com>
 <1441722886-22798-1-git-send-email-gary.bisson@boundarydevices.com>
 <1441722886-22798-2-git-send-email-gary.bisson@boundarydevices.com>
 <1441723760.3241.26.camel@pengutronix.de>
Message-ID: <20150908203357.GD21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 08, 2015 at 04:49:20PM +0200, Philipp Zabel wrote:
> Am Dienstag, den 08.09.2015, 16:34 +0200 schrieb Gary Bisson:
> > This patch adds the different touchscreens that can be connected using
> > the displays available for this board.
> > http://boundarydevices.com/product-category/displays/
> > 
> > Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
> > ---
> >  arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
> > index ad16dce..24b667d 100644
> > --- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
> > +++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
> > @@ -284,6 +284,22 @@
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&pinctrl_i2c3>;
> >  	status = "okay";
> > +
> > +	egalax_ts at 04 {
> 
> I'd prefer to use generic names for the nodes, such as "touchscreen at 04",
> and "touchscreen at 38" below.

ePAPR actually says that the node name should be the general class of
the device, and recommending that it should be generic:

2.2.1.1 Node Name Requirements
...
The node-name shall start with a lower or uppercase character and should
describe the general class of device.

2.2.2 Generic Names Recommendation
The name of a node should be somewhat generic, reflecting the function of
the device and not its precise programming model. If appropriate, the name
should be one of the following choices: ...

It would be nice if more bindings followed this.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
