From: hzpeterchen@gmail.com (Peter Chen)
Date: Mon, 18 Jul 2016 10:55:07 +0800
Subject: [PATCH v2 3/6] binding-doc: usb: usb-device: add optional
 properties for power sequence
In-Reply-To: <20160716223158.GB8984@rob-hp-laptop>
References: <1468375610-18625-1-git-send-email-peter.chen@nxp.com>
 <1468375610-18625-4-git-send-email-peter.chen@nxp.com>
 <20160716223158.GB8984@rob-hp-laptop>
Message-ID: <20160718025507.GC31293@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 16, 2016 at 05:31:59PM -0500, Rob Herring wrote:
> On Wed, Jul 13, 2016 at 10:06:47AM +0800, Peter Chen wrote:
> > Add optional properties for power sequence.
> > 
> > Signed-off-by: Peter Chen <peter.chen@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/usb/usb-device.txt | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/usb-device.txt b/Documentation/devicetree/bindings/usb/usb-device.txt
> > index 1c35e7b..0ccaadf 100644
> > --- a/Documentation/devicetree/bindings/usb/usb-device.txt
> > +++ b/Documentation/devicetree/bindings/usb/usb-device.txt
> > @@ -13,6 +13,10 @@ Required properties:
> >  - reg: the port number which this device is connecting to, the range
> >    is 1-31.
> >  
> > +Optional properties:
> > +power sequence properties, see
> > +Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt for detail
> > +
> >  Example:
> >  
> >  &usb1 {
> > @@ -24,5 +28,10 @@ Example:
> >  	hub: genesys at 1 {
> >  		compatible = "usb5e3,608";
> >  		reg = <1>;
> > +
> > +		power-sequence;
> > +		clocks = <&clks IMX6SX_CLK_CKO>;
> > +		reset-gpios = <&gpio4 5 GPIO_ACTIVE_LOW>; /* hub reset pin */
> > +		reset-duration-us = <10>;
> 
> These belong in the binding doc for the hub.
> 

There is no dedicated binding doc for USB hub, we only have this binding
doc for hard-wired USB devices.

-- 

Best Regards,
Peter Chen
