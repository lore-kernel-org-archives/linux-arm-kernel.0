From: yoshihiro.shimoda.uh@renesas.com (Yoshihiro Shimoda)
Date: Mon, 1 Feb 2016 11:17:30 +0000
Subject: [PATCH] ARM: dts: porter: add MAX3355 support
In-Reply-To: <56ABD066.7020804@cogentembedded.com>
References: <1674850.BZpGW9kEud@wasted.cogentembedded.com>
 <4506196.xOgpYRO52t@wasted.cogentembedded.com>
 <SG2PR06MB0919D09C1146EAC0681EE109D8DA0@SG2PR06MB0919.apcprd06.prod.outlook.com>
 <56ABCB69.1070800@cogentembedded.com> <56ABD066.7020804@cogentembedded.com>
Message-ID: <SG2PR06MB0919361DC5805AE3F5B74041D8DE0@SG2PR06MB0919.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> From: Sergei Shtylyov
> Sent: Saturday, January 30, 2016 5:50 AM
> 
> On 01/29/2016 11:28 PM, Sergei Shtylyov wrote:
> 
> >>> From: linux-renesas-soc-owner at vger.kernel.org
> >>> [mailto:linux-renesas-soc-owner at vger.kernel.org] On Behalf Of Sergei
> >>> Shtylyov
> >>> Sent: Wednesday, January 27, 2016 7:14 AM
> >>>
> >>> Now that Maxim Integrated MAX3355 'extcon' driver and device tree bindings
> >>> are upstream along with the 'extcon' hook  in the Renesas USBHS driver, we
> >>> can add  MAX3355 device node to  the Porter device tree and properly refer
> >>> to it from the USBHS node instead of using  "renesas,enable-gpio" property
> >>> which only allowed checking the USB ID pin  at the driver probe time;  now
> >>> this  pin's  state can be monitored dynamically!
> >>>
> >>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >>
> >> I tested this patch on Porter, but interrupt of "usb-otg" didn't happened
> >> even if I connected/disconnected a usb convert cable (usb micro-ab to A).
> >> Remarks: I confirmed that the usb convert cable worked correctly on other
> >> board.
> >
> >     I guess I have the same cable
> 
>     No, I have mini-AB connector here and hence my cable is mini-AB to A.

I checked Porter specification and then I found 2 specifications exist...
 Porter "B" : mini AB connecter and Max3355 is on the board.
 Porter "C" : micro AB connect and Max3355 is not on the board. (Select host/peripheral by a jumper.)

I guess that your current target is "B".
If so, I think this patch is acceptable.

Best regards,
Yoshihiro Shimoda

> > and IRQs do happen for me when I connect and
> > disconnect it (as it should be).
> 
> >> Best regards,
> >> Yoshihiro Shimoda
> 
> MBR, Sergei
