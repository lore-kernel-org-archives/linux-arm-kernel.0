From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 25 Aug 2016 10:03:34 +0200
Subject: [PATCH 2/2] ARM: dts: sun8i: enable UART1 for iNet D978 Rev2 board
In-Reply-To: <97321472108244@web8m.yandex.ru>
References: <20160823064451.25997-1-icenowy@aosc.xyz>
 <20160823064451.25997-3-icenowy@aosc.xyz>
 <20160824193600.GS8103@lukather> <43951472083107@web23m.yandex.ru>
 <CAGb2v66tFENk8QBw7D1+bwFN-zWaE2SGDrNyc-zdbJSRzENk4Q@mail.gmail.com>
 <97321472108244@web8m.yandex.ru>
Message-ID: <20160825080334.GD7776@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Aug 25, 2016 at 02:57:24PM +0800, Icenowy Zheng wrote:
> >>>> ??diff --git a/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts b/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts
> >>>> ??index 78823d8..3ac22d4 100644
> >>>> ??--- a/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts
> >>>> ??+++ b/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts
> >>>> ??@@ -48,6 +48,10 @@
> >>>> ???????????model = "INet-D978 Rev 02";
> >>>> ???????????compatible = "primux,inet-d978-rev2", "allwinner,sun8i-a33";
> >>>>
> >>>> ??+ aliases {
> >>>> ??+ serial1 = &uart1;
> >>>> ??+ };
> >>>> ??+
> >>>
> >>> ?Is there any other UART in the system?
> >>
> >> ?serial0 is defined in sun8i-reference-design-tablet.dtsi, as r_uart.
> >
> > If your board does not have r_uart pads, then the right thing to do
> > would be to disable it. You can then have uart1 as serial0.
> 
> I don't know it. The RX/TX is wired on PF2/PF4 on the board (UART0 muxed with
> MMC)

Then you don't support it and you need to disable it.

> But many codes will require a ttyS0 as console... So I think the
> bluetooth should be located at ttyS1...

Most of them would use /dev/console anyway. What do you have in mind?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160825/e59cd5f4/attachment.sig>
