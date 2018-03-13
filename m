From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 13 Mar 2018 16:41:54 +0100
Subject: [PATCH 5/5] arm64: allwinner: a64: Add support for TERES I laptop
In-Reply-To: <E1evhmK-0000OI-Nw@stardust.g4.wien.funkfeuer.at>
References: <20180312161050.7647-1-harald@ccbib.org>
 <20180312161050.7647-6-harald@ccbib.org>
 <20180313084108.uh3ui5jwin2knvuu@flea>
 <E1evhmK-0000OI-Nw@stardust.g4.wien.funkfeuer.at>
Message-ID: <20180313154154.lnzomhknzfuv7gqy@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2018 at 12:07:36PM +0100, Harald Geyer wrote:
> >> +/ {
> >> +	model = "Olimex Teres I A64";
> > 
> > It's called the Teres-I, there's no need for the A64 here
> 
> Olimex said in the past they want the Teres to be very modular, with
> boards for different SoCs compatible with each other on the level of
> external pins. The PCBs we have right now are labled like
> TERES_PCB1-A64-MAIN, TERES-PCB2-IO, etc. - I wouldn't be surprised if
> they start selling TERES_PCB1-x86-MAIN to be put into your average Teres I,
> so I felt this naming was safer.
> 
> However I specifically CCed them on this series, so they can comment on
> issues such as this one...

Then maybe call it A64 Teres-I to be consistent with the compatible?

> >> +		compatible = "gpio-leds";
> >> +
> >> +		led_capslock: capslock {
> > 
> > Same thing here
> 
> I was kind of hoping I could use it to link the led to the keyboard,
> so that it goes on when the capslock key is pressed. But no such luck:
> 1) There seems to be no binding for external leds in the input subsystem.
> 2) The keyboard is a usb one and get enumerated automatically, so not DT
>    node by default.
> 
> I guess I can remove it, but then I guess labels for the leds might be
> helpful when further customizing the DT locally, so why not just keep them?

I'm not sure that would be useful either. I'd expect someone modifying
the DT locally that they would modify the DT directly, and you already
have the node there.

> >> +	reg_usb1_vbus: usb1-vbus {
> >> +		compatible = "regulator-fixed";
> >> +		regulator-name = "usb1-vbus";
> >> +		regulator-min-microvolt = <5000000>;
> >> +		regulator-max-microvolt = <5000000>;
> >> +		enable-active-high;
> >> +		gpio = <&r_pio 0 7 GPIO_ACTIVE_HIGH>; /* PL7 */
> >> +		status = "okay";
> > 
> > I guess this one has a parent regulator too?
> 
> Unless I failed to read the schematic correctly: No.
> The step-up converter providing 5V power for the usb1-vbus is connected
> directly to the IPS (intelligent power source) output of the PMIC and
> enabled directly by the 3.3V supply. So technically of course there is
> a parent regulator, but nothing we can control from software.

Ok

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180313/88dec0ca/attachment.sig>
