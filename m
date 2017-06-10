From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 10 Jun 2017 22:28:31 +0200
Subject: [linux-sunxi] Re: [PATCH v2] arm64: allwinner: a64: Add initial
 NanoPi A64 support
In-Reply-To: <3b4dda48-c403-88c4-5c89-63753f508d76@arm.com>
References: <1497012052-14027-1-git-send-email-jteki@openedev.com>
 <1497012052-14027-2-git-send-email-jteki@openedev.com>
 <20170609145141.aknbsis25vmy3rj6@flea.home>
 <3049841d-36f0-a761-fbed-57971462697c@openedev.com>
 <3b4dda48-c403-88c4-5c89-63753f508d76@arm.com>
Message-ID: <20170610202831.usdhtuqc4uqxojmr@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 09, 2017 at 04:36:09PM +0100, Andre Przywara wrote:
> Hi,
> 
> On 09/06/17 16:26, Jagan Teki wrote:
> > On Friday 09 June 2017 08:21 PM, Maxime Ripard wrote:
> >> Hi Jagan,
> >>
> >> On Fri, Jun 09, 2017 at 12:40:52PM +0000, Jagan Teki wrote:
> >>> +&i2c1 {
> >>> +    pinctrl-names = "default";
> >>> +    pinctrl-0 = <&i2c1_pins>;
> >>> +    status = "okay";
> >>> +};
> >>> +
> >>> +&i2c1_pins {
> >>> +    bias-pull-up;
> >>> +};
> >>
> >> What is connected on that bus?
> > 
> > i2c1 connected with gpio/i2s
> 
> Those are the I2C pins connected to the headers. We have them in the
> other A64 DTs as well (Pine64, BananaPi).

We've always had the policy of not enabling anything outside of the
board has been there from the very start, arm64 or not.

> If that is not the right approach, we should discuss this and keep it
> consistent at least across the A64 boards.

If some boards slipped through, then that would be on me I guess,
but it's (unfortunate) exceptions.

If you want to ease that for the users, you can have that node with
the pinctrl nodes pre-set, but leave it disabled. We have that on a
number of boards already.

> >>> +&uart1 {
> >>> +    pinctrl-names = "default";
> >>> +    pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
> >>> +    status = "okay";
> >>> +};
> >>
> >> And on that UART?
> > 
> > uart1 for SDIO (Wifi connector, with RTS/CTS), this along with mmc1
> 
> To be precise, UART1 (with h/w handshake) is connected to the Bluetooth
> part of the WiFi/BT chip, which is soldered on that board. Regardless of
> the actual *WiFi* support state BT should work already - at least it did
> when I tried this a few months ago on the Pine64 (although this involved
> some userland heavy lifting).
> Not sure what the approach here is in regard to the power supply and
> wake-up GPIOs, shall they be described in this node as well or is that
> up for userspace to control?

There's probably more to it though. Most BT chips require regulators
and clocks to be enabled. Ideally, this would even be a full DT node
for the bluetooth chip.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170610/50069cd4/attachment.sig>
