From: olof@lixom.net (Olof Johansson)
Date: Mon, 21 Nov 2016 15:34:50 -0800
Subject: [GIT PULL] Allwinner DT changes for 4.10
In-Reply-To: <20161121222209.ipqft65zcqsfsu2n@lukather>
References: <20161115204122.x3vnb3bkny5esdya@lukather>
 <20161119002316.GN8882@localhost>
 <20161121132712.43b5eld2qthi6664@lukather>
 <CAOesGMg=OQDtKkb4Mut4M1zAwM5CX3=YHxS7equO=Nx2a1tv1Q@mail.gmail.com>
 <20161121222209.ipqft65zcqsfsu2n@lukather>
Message-ID: <CAOesGMh3uph=eU6XhHHn+OYUvGx0hXYGAAbFT0LPKUeah5bggA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2016 at 2:22 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Mon, Nov 21, 2016 at 08:28:09AM -0800, Olof Johansson wrote:
>> HI,
>>
>> On Mon, Nov 21, 2016 at 5:27 AM, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>> > Hi Olof,
>> >
>> > On Fri, Nov 18, 2016 at 04:23:16PM -0800, Olof Johansson wrote:
>> >> Hi,
>> >>
>> >> On Tue, Nov 15, 2016 at 09:41:22PM +0100, Maxime Ripard wrote:
>> >> > Hi Arnd, Olof,
>> >> >
>> >> > Here is our pull request for the next merge window.
>> >> >
>> >> > Thanks!
>> >> > Maxime
>> >> >
>> >> > The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
>> >> >
>> >> >   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
>> >> >
>> >> > are available in the git repository at:
>> >> >
>> >> >   https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-dt-for-4.10
>> >> >
>> >> > for you to fetch changes up to e39a30cf736144814b0bddb3fff28fbbc2a8be0f:
>> >> >
>> >> >   ARM: sunxi: Add the missing clocks to the pinctrl nodes (2016-11-15 18:49:47 +0100)
>> >> >
>> >> > ----------------------------------------------------------------
>> >> > Allwinner DT additions for 4.10
>> >> >
>> >> > The usual bunch of DT additions, but most notably:
>> >> >   - A31 DRM driver
>> >> >   - A31 audio codec
>> >> >   - WiFi for the A80-Based boards and the CHIP
>> >> >   - Support for the NextThing Co CHIP Pro (the first board with NAND
>> >> >     enabled)
>> >> >   - New boards: NanoPi M1,
>> >> >
>> >> [...]
>> >>
>> >> > Maxime Ripard (16):
>> >> >       ARM: sun5i: a13-olinuxino: Enable VGA bridge
>> >> >       ARM: gr8: Add the UART3
>> >> >       ARM: gr8: Fix typo in the i2s mclk pin group
>> >> >       ARM: gr8: Add missing pwm channel 1 pin
>> >> >       ARM: gr8: Add UART2 pins
>> >> >       ARM: gr8: Add UART3 pins
>> >> >       ARM: gr8: Add CHIP Pro support
>> >> >       ARM: sun5i: chip: Enable Wi-Fi SDIO chip
>> >> >       ARM: sun5i: Rename A10s pins
>> >> >       ARM: sun5i: Add SPI2 pins
>> >> >       ARM: sun5i: Add RGB 565 LCD pins
>> >> >       ARM: sun5i: chip: Add optional buses
>> >> >       ARM: gr8: evb: Enable SPDIF
>> >> >       ARM: gr8: evb: Add i2s codec
>> >> >       ARM: sun8i: sina33: Enable USB gadget
>> >> >       ARM: sunxi: Add the missing clocks to the pinctrl nodes
>> >> >
>> >> [...]
>> >>
>> >> >  arch/arm/boot/dts/Makefile                         |   1 +
>> >> >  arch/arm/boot/dts/ntc-gr8-chip-pro.dts             | 266 +++++++++++++++++++++
>> >> >  arch/arm/boot/dts/ntc-gr8-evb.dts                  |  33 +++
>> >> >  arch/arm/boot/dts/ntc-gr8.dtsi                     |  47 +++-
>> >> >  arch/arm/boot/dts/sun4i-a10.dtsi                   |   3 +-
>> >>
>> >> NTC isn't the SoC manufacturer, and we try to keep the prefixes down to
>> >> manufacturer to keep the namespace a little more manageable, even if
>> >> we never got subdirectories setup as on arm64.
>> >>
>> >> I think this should probably be sun4i-a10-gr8 or sun4i-r8-gr8 as prefix?
>> >
>> > The users really expect a SoC from Nextthing, it's always been
>> > marketed that way, the marking on the SoC also says so, etc. The fact
>> > that it's been a design in cooperation with Allwinner, and that the
>> > design is based on some earlier family is an implementation detail,
>> > and I'd really like not for it to have the sun5i prefix, it's just
>> > confusing.
>>
>> I don't care so much about what's printed on the top of the package, I
>> care a lot more about what's on the insides. We've got a long
>> tradition of not renaming things randomly when companies get acquired
>> or renames themselves, and I think that same spirit is applicable
>> here.
>
> Yet, we called the imx23 and imx28 that way while it was really a
> sigmatel design. And I'm pretty sure there's other examples too.

Had Sigmatel had a whole bunch of SoCs in-tree we might have had
discussions about that as well.

>> Calling it an SoC is inaccurate as well, it's really a
>> system-in-package. It's just a new way to integrate an SoC into a
>> module to build boards out of. Compare to Octavo OSD335x, for example.
>>
>> System-in-package solutions are going to get more and more common, and
>> it's going to become really chaotic if we expect to use the prefix of
>> the company custom-ordering the package for each and every one of
>> them.
>
> This is indeed a SIP, but one with a custom SoC (or whatever the !RAM
> part in a SIP is called) that was designed by Allwinner *and* Next
> Thing Co., unlike the OSD335x that has a standard AM335x SoC in it.

Even NTC's marketing material says it's an Allwinner R8, at
https://getchip.com/pages/chippro: "Powered by a chip you can actually
buy. R8 SoC + 256MB DDR3. 1 package. 1 price. $6 in any quantity."

This is really quite similar to the situation with SoM manufacturers
such as Toradex, who integrate SoC, memory and some I/O on a module
that you then build your product around. The only difference is the
level it's integrated at. We've chosen to slice our naming across SoC
family lines, not who makes the substrate that the SoC is mounted to.

>> > And the ntc prefix has been asked for during the reviews...
>>
>> Having a link to that requeset/email would be helpful if you try to
>> use it as an argument.
>
> Yeah, it turns out it was off list... so it's a pretty weak one :)

:)


-Olof
