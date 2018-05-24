From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 24 May 2018 10:54:27 +0200
Subject: [PATCH v3] arm64: allwinner: a64: Add Amarula A64-Relic initial
 support
In-Reply-To: <CAMty3ZC-N-6WzYg+kYd2+V3wbQdQmvU706Nog_Urd_EUaWnQjQ@mail.gmail.com>
References: <20180522132228.6564-1-jagan@amarulasolutions.com>
 <20180522143044.pgwawojiwnk2lzxb@flea>
 <CAMty3ZD3JT-ToGAUHN_uj7uVK-jkyAwfEdTBCmJSj34bACFpYQ@mail.gmail.com>
 <20180523081830.4ly6sj34reabbttn@flea>
 <CAMty3ZC-N-6WzYg+kYd2+V3wbQdQmvU706Nog_Urd_EUaWnQjQ@mail.gmail.com>
Message-ID: <20180524085427.xs6yzhpa42zop6e5@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 23, 2018 at 03:57:05PM +0530, Jagan Teki wrote:
> On Wed, May 23, 2018 at 1:48 PM, Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> > On Wed, May 23, 2018 at 11:44:56AM +0530, Jagan Teki wrote:
> >> On Tue, May 22, 2018 at 8:00 PM, Maxime Ripard
> >> <maxime.ripard@bootlin.com> wrote:
> >> > On Tue, May 22, 2018 at 06:52:28PM +0530, Jagan Teki wrote:
> >> >> Amarula A64-Relic is Allwinner A64 based IoT device, which support
> >> >> - Allwinner A64 Cortex-A53
> >> >> - Mali-400MP2 GPU
> >> >> - AXP803 PMIC
> >> >> - 1GB DDR3 RAM
> >> >> - 8GB eMMC
> >> >> - AP6330 Wifi/BLE
> >> >> - MIPI-DSI
> >> >> - CSI: OV5640 sensor
> >> >> - USB OTG
> >> >
> >> > You claim that this is doing OTG...
> >> >
> >> > [..]
> >> >
> >> >> +&usb_otg {
> >> >> +     dr_mode = "peripheral";
> >> >> +     status = "okay";
> >> >> +};
> >> >
> >> > ... and yet you're setting it as peripheral...
> >>
> >> Though it claims OTG, board doesn't have any USB ports to operate(not
> >> even Mini-AB) the only way to use the board as peripheral to transfer
> >> images from host.
> >
> > I'm not sure what you mean here. If there's no USB connector, why do
> > you even enable it?
> 
> I'm saying there is no host port on board. Board has connector
> header[1] comes with few pins includes USB D+, D-, ID, VBUS, GROUND,
> UART0 TX, RX etc. we have to connect wires to these pins to make
> pluggable USB to host pc. and here USB pins used for transferring data
> from host pc to target board like in peripheral mode.

I'm still unsure how it's relevant. If the wire is plugged on your
board's header, is there anything that prevents using it as a host
assuming you have a proper connector on the other end of your wire?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180524/65f20e5f/attachment.sig>
