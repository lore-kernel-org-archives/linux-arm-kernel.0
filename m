From: aleksandr.aleksandrov@emlid.com (Aleksandr Aleksandrov)
Date: Fri, 12 Oct 2018 12:35:23 +0300
Subject: [PATCH v3] arm64: new board - Emlid Neutis N5
In-Reply-To: <2d09d6c0-0404-589d-2c34-da846cff4fb8@suse.de>
References: <1538745949-13188-2-git-send-email-aleksandr.aleksandrov@emlid.com>
 <1539012044-29998-1-git-send-email-aleksandr.aleksandrov@emlid.com>
 <1539012044-29998-2-git-send-email-aleksandr.aleksandrov@emlid.com>
 <20181010144957.exrlupoph7ovsmdw@flea>
 <9398571539259289@myt4-929fb874f3f2.qloud-c.yandex.net>
 <2d09d6c0-0404-589d-2c34-da846cff4fb8@suse.de>
Message-ID: <20181012093523.GA29014@imagebutcher>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> >>     ?+/ {
> >>     ?+ model = "Emlid Neutis N5 Developer board";
> >>     ?+ compatible = "emlid,emlid-neutis-n5-devboard",
> >>     ?+ "emlid,emlid-neutis-n5",
> >>
> >> Do you need the two emlid there? What comes before the comma is the
> >> vendor, while what is after is the model.
> > ?
> > I think emlid-neutis-n5 module could be useful in the future, no need
> > this now.
> 
> You misunderstand: The point would be to use, e.g., "emlid,neutis-n5"
> instead of "emlid,emlid-neutis-n5" with duplicate "emlid,emlid-". It is
> orthogonal to having multiple compatible strings.

Oh, I agree. No need to duplicate "emlid". Thank you!

> >> ?+&uart1 {
> >> ?+ pinctrl-names = "default";
> >> ?+ pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
> >> ?+ status = "okay";
> >> ?+};
> >>
> >> I guess this is for bluetooth? Have you tested serdev drivers?
> >>
> > Yes, bluetooth is connected over uart1.
> > You mean if I have tested bluetooth stack via serial device?
> 
> Not quite, we're missing a child node within uart1 for a serdev driver.
> Is there no such driver yet for your Bluetooth chipset, or did you not
> yet check?

Got it. I haven't checked a serdev driver.

Maxim, the SoM can't be run without a motherboard. According to your last message
I don't change dts files, right?

Aleksandr 
