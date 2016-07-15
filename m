From: hzpeterchen@gmail.com (Peter Chen)
Date: Fri, 15 Jul 2016 15:15:16 +0800
Subject: [PATCH v2 2/5] usb: DT binding documentation for qoriq usb 2.0
 controller
In-Reply-To: <HE1PR0401MB23319FBFD0D42D997A05AB34E3300@HE1PR0401MB2331.eurprd04.prod.outlook.com>
References: <1468038656-10345-1-git-send-email-rajesh.bhagat@nxp.com>
 <1468038656-10345-3-git-send-email-rajesh.bhagat@nxp.com>
 <20160711064845.GH31647@shlinux2>
 <HE1PR0401MB23319FBFD0D42D997A05AB34E3300@HE1PR0401MB2331.eurprd04.prod.outlook.com>
Message-ID: <20160715071516.GG817@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 12, 2016 at 03:59:14AM +0000, Rajesh Bhagat wrote:
> 
> 
> > -----Original Message-----
> > From: Peter Chen [mailto:hzpeterchen at gmail.com]
> > Sent: Monday, July 11, 2016 12:19 PM
> > To: Rajesh Bhagat <rajesh.bhagat@nxp.com>
> > Cc: linux-usb at vger.kernel.org; linux-kernel at vger.kernel.org;
> > devicetree at vger.kernel.org; Peter Chen <peter.chen@nxp.com>;
> > gregkh at linuxfoundation.org; kishon at ti.com; robh+dt at kernel.org;
> > shawnguo at kernel.org; linux-arm-kernel at lists.infradead.org
> > Subject: Re: [PATCH v2 2/5] usb: DT binding documentation for qoriq usb 2.0
> > controller
> > 
> > On Sat, Jul 09, 2016 at 10:00:53AM +0530, Rajesh Bhagat wrote:
> > > Describes the qoriq usb 2.0 controller driver binding, currently used
> > > for LS1021A and LS1012A platform.
> > >
> > > Signed-off-by: Rajesh Bhagat <rajesh.bhagat@nxp.com>
> > > ---
> > > Changes in v2:
> > >  - Adds DT binding documentation for qoriq usb 2.0 controller
> > >  - Changed the compatible string to fsl,ci-qoriq-usb2
> > >
> > >  .../devicetree/bindings/usb/ci-hdrc-qoriq.txt      | 34
> > ++++++++++++++++++++++
> > >  1 file changed, 34 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/usb/ci-hdrc-qoriq.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-qoriq.txt
> > > b/Documentation/devicetree/bindings/usb/ci-hdrc-qoriq.txt
> > > new file mode 100644
> > > index 0000000..8ad7306
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/usb/ci-hdrc-qoriq.txt
> > > @@ -0,0 +1,34 @@
> > > +* Freescale QorIQ SoC USB 2.0 Controllers
> > > +
> > > +Required properties:
> > > +- compatible: Should be "fsl,ci-qoriq-usb2"
> > > +  Wherever applicable, the IP version of the USB controller should
> > > +  also be mentioned (for eg. fsl,ci-qoriq-usb2-vX.Y).
> > > +  where, X.Y is IP version of USB controller.
> 
> Hello Peter, 
> 
> > 
> > Why you need to add IP version at compatible string?
> > Does it can't be read out from ID register of Identification Registers.
> > 
> 
> I agree. Will drop this controller version thing in DTS in v3.
> 
> > > +- reg: Should contain registers location and length
> > > +- interrupts: Should contain controller interrupt
> > > +- phy-names: from the *Generic PHY* bindings
> > > +- phys: from the *Generic PHY* bindings
> > > +- clocks: clock provider specifier
> > > +- clock-names: shall be "usb2-clock"
> > > +Refer to clk/clock-bindings.txt for generic clock consumer properties
> > > +
> > > +Recommended properties:
> > > +- dr_mode: One of "host" or "peripheral".
> > 
> > Do you support dual-role?
> > 
> 
> Yes. We do support  both host/peripheral mode. 
> 

I mean dual-role switch. If you support that, the dr_mode
should be "otg".

-- 

Best Regards,
Peter Chen
