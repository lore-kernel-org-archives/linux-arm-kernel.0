From: grinberg@compulab.co.il (Igor Grinberg)
Date: Sun, 29 Aug 2010 10:25:58 +0300
Subject: usb host port3 on pxa310?
In-Reply-To: <4C76C07B.1040809@gmail.com>
References: <loom.20100806T201947-76@post.gmane.org>,
	<201008080921466561614@gmail.com> <201008221620318595557@gmail.com>
	<4C721532.50905@compulab.co.il> <4C76C07B.1040809@gmail.com>
Message-ID: <4C7A0B86.2020900@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 On 08/26/10 22:28, David Hunter wrote:
> On 8/22/2010 11:29 PM, Igor Grinberg wrote:
> >   On 08/22/10 11:20, Chen Wenjie wrote:
> >> and I found the VCC voltage is only 3.0v, it is lower than 3.3v
> >> (in the spec). Is this a fatal issue?
> >
> > May be not fatal, but could bring issues...
> > I'd check the VBUS on that usb port and also the pull ups on DP/DM.
> > If those are not by the spec. then the chances of getting it work are poor.
>
> The host USB transceiver (ISP1105) should have external 15K pull-downs on both DP and DM. The device will have a pull-up on one signal to distinguish low speed vs. full speed.
>
> You didn't mention what USB device you're test with. Is it actually full speed as the kernel logs indicate?
>
> Do you mean VCC on ISP1105 is only 3.0V? That's the minimum, so it may still be functional. Hopefully the supply is adjustable.
>
> ISP1105 supports both single-ended and differential input modes, as selected by the ISP1105's MODE pin. Can you confirm the PXA310 is set for the right mode? That'll be (digging thru the Dev Man) the P3SS bits in the U2DP3CR register in the U2D (Yes, the USB 2.0 Device Controller must be configured to use the USB Host Port 3. Thanks, Intel.) There's other important settings there, can't think of them off the top of my head. If that doesn't help, I'll share some code when my PXA310 box comes back online.

cm-x300 uses PXA310 usb port 3 in host mode (the code is in mainline).
I've already mentioned the U2DP3CR register in one of my previous replies.
On cm-x300 we use 6-wire single ended transceiver (TUSB1105) and
the port works just fine without any special setup (the default values of
U2DP3CR are fine).
So there indeed could be a mismatch between the port configuration (U2DP3CR)
and the ISP1105's MODE pin wiring (although I think "grounded" is 6-wire s/e),
or the pull ups on DP/DM or VBUS or the VCC to the transceiver.

>
> -Dave
>

-- 
Regards,
Igor.
