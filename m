From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 06 Dec 2016 23:16:44 +0800
Subject: [PATCH v2 2/3] ARM: dts: sunxi: add support for Orange Pi Zero
 board
In-Reply-To: <20161206080056.23jpd4e7eeuhuyiq@lukather>
References: <20161205120021.0GBGtAl4@smtp3m.mail.yandex.net>
 <20161205094023.mtymfvpmca4x3ohh@lukather>
 <17819681480935706@web24g.yandex.ru>
 <20161206080056.23jpd4e7eeuhuyiq@lukather>
Message-ID: <289751481037404@web27m.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



06.12.2016, 16:01, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> On Mon, Dec 05, 2016 at 07:01:46PM +0800, Icenowy Zheng wrote:
>> ?05.12.2016, 17:40, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
>> ?> On Mon, Dec 05, 2016 at 04:59:44PM +0800, Icenowy Zheng wrote:
>> ?>> ?2016?12?5? 16:52? Maxime Ripard <maxime.ripard@free-electrons.com>???
>> ?>> ?>
>> ?>> ?> On Fri, Dec 02, 2016 at 10:22:30PM +0800, Icenowy Zheng wrote:
>> ?>> ?> >
>> ?>> ?> >
>> ?>> ?> > 01.12.2016, 17:36, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
>> ?>> ?> > > On Mon, Nov 28, 2016 at 12:29:07AM +0000, Andr? Przywara wrote:
>> ?>> ?> > >> ?> Something more interesting happened.
>> ?>> ?> > >> ?>
>> ?>> ?> > >> ?> Xunlong made a add-on board for Orange Pi Zero, which exposes the
>> ?>> ?> > >> ?> two USB Controllers exported at expansion bus as USB Type-A
>> ?>> ?> > >> ?> connectors.
>> ?>> ?> > >> ?>
>> ?>> ?> > >> ?> Also it exposes a analog A/V jack and a microphone.
>> ?>> ?> > >> ?>
>> ?>> ?> > >> ?> Should I enable {e,o}hci{2.3} in the device tree?
>> ?>> ?> > >>
>> ?>> ?> > >> ?Actually we should do this regardless of this extension board. The USB
>> ?>> ?> > >> ?pins are not multiplexed and are exposed on user accessible pins (just
>> ?>> ?> > >> ?not soldered, but that's a detail), so I think they qualify for DT
>> ?>> ?> > >> ?enablement. And even if a user can't use them, it doesn't hurt to have
>> ?>> ?> > >> ?them (since they are not multiplexed).
>> ?>> ?> > >
>> ?>> ?> > > My main concern about this is that we'll leave regulators enabled by
>> ?>> ?> > > default, for a minority of users. And that minority will prevent to do
>> ?>> ?> > > a proper power management when the times come since we'll have to keep
>> ?>> ?> > > that behaviour forever.
>> ?>> ?> >
>> ?>> ?> > I think these users can add a 'fdt set /xxx/xxx status "disabled" ' .
>> ?>> ?>
>> ?>> ?> You can't ask that from the majority of users. These users will take
>> ?>> ?> debian or fedora, install it, and expect everything to work
>> ?>> ?> properly. I would make the opposite argument actually. If someone is
>> ?>> ?> knowledgeable enough to solder the USB pins a connector, then (s)he'll
>> ?>> ?> be able to make that u-boot call.
>> ?>>
>> ?>> ?Now (s)he do not need soldering.
>> ?>>
>> ?>> ?(S)he needs only paying $1.99 more to Xunlong to get the expansion
>> ?>> ?board, and insert it on the OPi Zero.
>> ?>
>> ?> Which is going to require an overlay anyway, so we could have the USB
>> ?> bits in there too.
>>
>> ?If so, I think the [PATCH -next v3 2/2] is ready to be merged ;-)
>
> I meant enabling the USB in the overlay, you enabled it in the base DT.

I enabled only usb1 in the base DT.

The USBs on the expansion board is usb2/3, and usb1 is an onboard USB connector.

It should of course be enabled ;-)

And to mention: this usb's Vbus is also directly connected to DCIN.

(There's no regulator at 5.0V on orange pi Zero)

>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
