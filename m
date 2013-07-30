From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 30 Jul 2013 22:10:06 +0200
Subject: [PATCH 08/10] ARM: sun7i: DT: Add UART muxing options to the DTSI
In-Reply-To: <51F80EE9.30801@cogentembedded.com>
References: <1375196394-21138-1-git-send-email-maxime.ripard@free-electrons.com>
 <1375196394-21138-9-git-send-email-maxime.ripard@free-electrons.com>
 <51F80EE9.30801@cogentembedded.com>
Message-ID: <20130730201006.GD12562@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Tue, Jul 30, 2013 at 11:07:21PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 07/30/2013 06:59 PM, Maxime Ripard wrote:
> 
> >The UARTs on the A20 can be muxed to several pins. Add a few options to
> >the DTSI so that we can start using them in the boards' DT.
> 
> >Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> >---
> >  arch/arm/boot/dts/sun7i-a20.dtsi | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> 
> >diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> >index 704fca9..9f45e8d 100644
> >--- a/arch/arm/boot/dts/sun7i-a20.dtsi
> >+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> >@@ -70,6 +70,27 @@
> >  			#address-cells = <1>;
> >  			#size-cells = <0>;
> >  			#gpio-cells = <3>;
> >+
> >+			uart0_pins_a: uart0 at 0 {
> 
>    Why have address part of the node name if there's not "reg" property?

It allows to easily differentiate distinct pin groups for the same IP.

A second group of pin that can be muxed to uart0 would be defined as
uart0_pins_b: uart0 at 1.

I could have used any other construct, like uart0-0 and uart0-1, I just
find that it fits more in the usual DT constructs.

> And the preferred node name is "serial", not "uart", according to
> the ePAPR spec (http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf).

But only for actual serial driver right? This is a pinctrl group
declaration.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130730/10421948/attachment.sig>
