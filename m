From: Peter.Chen@freescale.com (Peter Chen)
Date: Wed, 26 Mar 2014 05:36:08 +0000
Subject: [PATCH 1/2] ARM: dts: imx51-babbage: Add USB Host1 support
In-Reply-To: <CAOMZO5Da9poOv8KqCsSxnjs4eZkVbRPCmnJCj-OX3ps8=+y+Ww@mail.gmail.com>
References: <1395750922-3244-1-git-send-email-festevam@gmail.com>
 <07405bf6fc4841d5b0d22c07c582acb9@BL2PR03MB226.namprd03.prod.outlook.com>
 <CAOMZO5Da9poOv8KqCsSxnjs4eZkVbRPCmnJCj-OX3ps8=+y+Ww@mail.gmail.com>
Message-ID: <26dd7d7d9b5f481588848b0fdd65fbbb@BL2PR03MB226.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


 
> 
> On Tue, Mar 25, 2014 at 11:00 PM, Peter Chen <Peter.Chen@freescale.com>
> wrote:
> 
> >> +
> >> +             usbphy1: usbphy at 1 {
> >> +                     compatible = "usb-nop-xceiv";
> >> +                     reg = <1>;
> >> +                     clocks = <&clks IMX5_CLK_USB_PHY_GATE>;
> >> +                     clock-names = "main_clk";
> >> +             };
> >>       };
> >>
> >
> > You are using usb nop phy driver (phy-generic.c) for ulpi phy, Are you
> > sure your phy doesn't need any configurations from viewport?
> 
> I am not sure I understood your comment.
> 
> This node is the same like we do on mx53 and other i.mx SoCs.
> 

For imx53, it can work since both usbotg and host 1 use utmi internal phy.
But for SoCs before than imx53 (including imx51), the host1 uses external
phy. At non-dt version, they should use ulpi phy driver.

Peter

> Both USB host and OTG are functional.
> 
> Could you please explain your concern?
> 
> Regards,
> 
> Fabio Estevam
> 
