From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 9 Sep 2014 08:34:46 +0100
Subject: [PATCH 2/3] phy: phy-stih407-usb: Add dt documentation for USB
 picophy found on stih407 SoC family
In-Reply-To: <540DCB91.7060702@ti.com>
References: <1409740079-16554-1-git-send-email-peter.griffin@linaro.org>
 <1409740079-16554-3-git-send-email-peter.griffin@linaro.org>
 <540DCB91.7060702@ti.com>
Message-ID: <20140909073446.GB7620@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

Thanks for reviewing :-)

> > +On STiH410, we have to use the DWC3 port#2 with a picoPHY to manage USB2
> > +devices. The USB2 Controller will use the ports #0 and #1.
> > +
> > +This is to document the DT parameters to be passed from the blob in that case.
> > +
> > +Required properties:
> > +- compatible		: should be "st,stih407-usb2-phy"
> 
> If STiH410 also uses the same driver then you should add a new compatibility
> value for it.

I will remove the reference to stih410 in V2, as currently it is not supported
upstream, and I'm not sure what ST's plans are regarding upstreaming it. If/
when it is upstreamed, we can add this and a compabible property back in.

<snip>
> > +
> > +usb2_picophy0: usbpicophy at 0 {
> usbpicophy at f8 since you have a reg property ;-)

will fix in V2

> 
> > +	compatible	= "st,stih407-usb2-phy";
> > +	reg		= <0xf8 0x04>,	/* syscfg 5062 */
> > +			  <0xf4 0x04>;	/* syscfg 5061 */
> > +	reg-names	= "param",
> > +			  "ctrl";
> > +			  #phy-cells = <0>;
> 
> alignment seems to have gone wrong here.

Will fix in v2

regards,

Peter.
