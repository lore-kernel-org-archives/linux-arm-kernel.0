From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 25 Jul 2013 11:37:17 +0800
Subject: Enabling USBH1 on mx53qsb
In-Reply-To: <CAOMZO5DB5Pxv50Yp2xUtp+yoJq6O+r=ZrGfJvsFNf1gcVOQUEA@mail.gmail.com>
References: <CAOMZO5CAdxzn-3Xc2DZDYEXwsEznRrcqPbCbTDc5ieBkQkA8=g@mail.gmail.com>
 <20130725031315.GA4489@nchen-desktop>
 <CAOMZO5DB5Pxv50Yp2xUtp+yoJq6O+r=ZrGfJvsFNf1gcVOQUEA@mail.gmail.com>
Message-ID: <20130725033716.GB4489@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 12:28:15AM -0300, Fabio Estevam wrote:
> Hi Peter,
> 
> On Thu, Jul 25, 2013 at 12:13 AM, Peter Chen <peter.chen@freescale.com> wrote:
> 
> > Would you enable CONFIG_USB_DEBUG to see where is the problem?
> 
> This is what I get:
> 
> ci_hdrc ci_hdrc.0: ChipIdea HDRC found, lpm: 0; cap: f5780100 op: f5780140
> ci_hdrc ci_hdrc.0: doesn't support gadget
> ci_hdrc ci_hdrc.0: EHCI Host Controller
> ci_hdrc ci_hdrc.0: new USB bus registered, assigned bus number 1
> ci_hdrc ci_hdrc.0: USB 2.0 started, EHCI 1.00
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 1 port detected
> ci_hdrc ci_hdrc.1: ChipIdea HDRC found, lpm: 0; cap: f5780300 op: f5780340
> ci_hdrc ci_hdrc.1: doesn't support gadget
> ci_hdrc ci_hdrc.1: EHCI Host Controller
> ci_hdrc ci_hdrc.1: new USB bus registered, assigned bus number 2
> ci_hdrc ci_hdrc.1: USB 2.0 started, EHCI 1.00
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 1 port detected
> 
> >
> >>
> >> However, if I access USBH1 within U-boot prior to launching the
> >> kernel, then I am able to use USBH1 in the kernel succesfully.
> >
> > access host 1 at u-boot, what do you mean, only register access
> > or let host 1 work?
> 
> This is what I do in U-boot:
> 
> MX53LOCO U-Boot > usb reset
> (Re)start USB...
> USB0:   USB EHCI 1.00
> scanning bus 0 for devices... 2 USB Device(s) found
>        scanning usb for storage devices... 1 Storage Device(s) found
>        scanning usb for ethernet devices... 0 Ethernet Device(s) found
> MX53LOCO U-Boot > run bootcmd
> 
> Then kernel is launched and I can use USBH1 succesfully.

seems u-boot already support mx53.

Can you measure the host 1 vbus pin? The vbus should be 5v to let
the host works normal.

-- 

Best Regards,
Peter Chen
