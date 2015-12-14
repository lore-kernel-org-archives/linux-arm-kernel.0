From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 14 Dec 2015 21:11:32 +0100
Subject: [PATCH v2 2/3] ehci-platform: Add support for controllers with
 multiple reset lines
In-Reply-To: <566B15B7.40703@redhat.com>
References: <1449848520-27379-1-git-send-email-hdegoede@redhat.com>
 <1449848520-27379-2-git-send-email-hdegoede@redhat.com>
 <1449853984.3419.52.camel@pengutronix.de> <566B15B7.40703@redhat.com>
Message-ID: <1450123892.3407.86.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 11.12.2015, 19:28 +0100 schrieb Hans de Goede:
[...]
> >> diff --git a/Documentation/devicetree/bindings/usb/usb-ehci.txt b/Documentation/devicetree/bindings/usb/usb-ehci.txt
> >> index a12d601..0701812 100644
> >> --- a/Documentation/devicetree/bindings/usb/usb-ehci.txt
> >> +++ b/Documentation/devicetree/bindings/usb/usb-ehci.txt
> >> @@ -18,7 +18,7 @@ Optional properties:
> >>    - clocks : a list of phandle + clock specifier pairs
> >>    - phys : phandle + phy specifier pair
> >>    - phy-names : "usb"
> >> - - resets : phandle + reset specifier pair
> >> + - resets : a list of phandle + reset specifier pairs
> >
> > Are there documented names for these resets?
> 
> This binding is a generic ehci controller binding, so even if
> the names are documented for the allwinner SoC we should
> not use names, just like the binding is deliberately not
> using names for the clocks either to keep it generic, so
> that we can reuse the binding + driver with many different SoCs.

I know, I'm just interested in understanding why this is necessary ...

> > Is the companion you
> > mention the Port Control?
> 
> Sort of, with USB-2, USB-1 compatibility is handled via a mux on the
> datalines (controlled by the EHCI controller Port Control) which muxes
> the lines to an USB-1 controller (typically either UHCI or OHCI) when the
> device does not connect after USB-2 highspeed handshaking.
> 
> This USB-1 controller (or controller_S_ in some case since the
> USB-1 companions may have less root-ports per controller then the EHCI
> has root-ports) is called the companion controller.
> 
> The 2 controllers are supposed to be 100% independent but on the H3
> Allwinner has done something (not documented) which requires one to
> deassert reset on both before you can talk to either one.

... so thank you for the explanation.

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
