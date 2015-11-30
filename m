From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 30 Nov 2015 19:55:28 +0100
Subject: [linux-sunxi] Re: [PATCH] ARM: dts: sun7i: Add dts file for the
 lamobo-r1 board
In-Reply-To: <565423E1.5090200@redhat.com>
References: <1448046713-13579-1-git-send-email-hdegoede@redhat.com>
 <20151122195925.GR32142@lukather> <5652CE10.1020808@redhat.com>
 <20151124072012.GD32142@lukather> <565423E1.5090200@redhat.com>
Message-ID: <20151130185528.GC3664@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2015 at 09:46:25AM +0100, Hans de Goede wrote:
> >>>>+&i2c0 {
> >>>>+	pinctrl-names = "default";
> >>>>+	pinctrl-0 = <&i2c0_pins_a>;
> >>>>+	status = "okay";
> >>>>+
> >>>>+	axp209: pmic at 34 {
> >>>>+		reg = <0x34>;
> >>>>+		interrupt-parent = <&nmi_intc>;
> >>>>+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> >>>>+	};
> >>>>+};
> >>>>+
> >>>>+&i2c2 {
> >>>>+	pinctrl-names = "default";
> >>>>+	pinctrl-0 = <&i2c2_pins_a>;
> >>>>+	status = "okay";
> >>>>+};
> >>>
> >>>What is connected on i2c2?
> >>
> >>The Lamobo-R1 has a gpio header idententical to the one found
> >>on the Banana Pi, i2c2 is routed to pins there.
> >
> >So it's just a generic header with the pins left as is, and it's up to
> >the user to plug something on it?
> >
> >The policy we had so far for this was to not enforce anything for
> >these pins, and leave to the user the choice to to do whatever he
> >wanted.
> 
> I'm not aware of such a policy and I actually believe that the policy
> sofar has been to go with the function as which the pins are marked
> in vendor documentation.
> 
> Looking at just SBC-s we're enabling at least 1 extra (unused other
> then for a header) i2c controller on:
> 
> arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> arch/arm/boot/dts/sun4i-a10-itead-iteaduino-plus.dts
> arch/arm/boot/dts/sun4i-a10-marsboard.dts
> arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
> arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
> arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
> arch/arm/boot/dts/sun5i-a13-olinuxino.dts
> arch/arm/boot/dts/sun7i-a20-bananapi.dts
> arch/arm/boot/dts/sun7i-a20-bananapro.dts
> arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
> arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> 
> And spi on:
> 
> arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> arch/arm/boot/dts/sun4i-a10-itead-iteaduino-plus.dts
> arch/arm/boot/dts/sun4i-a10-marsboard.dts
> arch/arm/boot/dts/sun7i-a20-bananapi.dts
> arch/arm/boot/dts/sun7i-a20-bananapro.dts
> arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> 
> And note how the official documentation labels
> the pins as sda / scl resp. miso/mosi:
> 
> http://www.bananapi.com/index.php/component/content/article?id=24
> 
> (you need to scroll down a bit)

Hmmm, I've been pretty bad at this, haven't I ? :)

> As said this board is using the same header as found
> on the banana pi and for the pi we are configuring
> these pins as i2c / spi and looking at how I see
> people use the raspberry pi at my local hackerspace
> this is also what people want most of the time.

What I'm more concerned about is people that will not want that. By
putting this into our DT, they will never be able to use their pin
without any way out of this apart from patching the DT itself.

But yeah, ok.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151130/d42c2a04/attachment.sig>
