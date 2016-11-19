From: olof@lixom.net (Olof Johansson)
Date: Fri, 18 Nov 2016 16:23:16 -0800
Subject: [GIT PULL] Allwinner DT changes for 4.10
In-Reply-To: <20161115204122.x3vnb3bkny5esdya@lukather>
References: <20161115204122.x3vnb3bkny5esdya@lukather>
Message-ID: <20161119002316.GN8882@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 15, 2016 at 09:41:22PM +0100, Maxime Ripard wrote:
> Hi Arnd, Olof,
> 
> Here is our pull request for the next merge window.
> 
> Thanks!
> Maxime
> 
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-dt-for-4.10
> 
> for you to fetch changes up to e39a30cf736144814b0bddb3fff28fbbc2a8be0f:
> 
>   ARM: sunxi: Add the missing clocks to the pinctrl nodes (2016-11-15 18:49:47 +0100)
> 
> ----------------------------------------------------------------
> Allwinner DT additions for 4.10
> 
> The usual bunch of DT additions, but most notably:
>   - A31 DRM driver
>   - A31 audio codec
>   - WiFi for the A80-Based boards and the CHIP
>   - Support for the NextThing Co CHIP Pro (the first board with NAND
>     enabled)
>   - New boards: NanoPi M1,
> 
[...]

> Maxime Ripard (16):
>       ARM: sun5i: a13-olinuxino: Enable VGA bridge
>       ARM: gr8: Add the UART3
>       ARM: gr8: Fix typo in the i2s mclk pin group
>       ARM: gr8: Add missing pwm channel 1 pin
>       ARM: gr8: Add UART2 pins
>       ARM: gr8: Add UART3 pins
>       ARM: gr8: Add CHIP Pro support
>       ARM: sun5i: chip: Enable Wi-Fi SDIO chip
>       ARM: sun5i: Rename A10s pins
>       ARM: sun5i: Add SPI2 pins
>       ARM: sun5i: Add RGB 565 LCD pins
>       ARM: sun5i: chip: Add optional buses
>       ARM: gr8: evb: Enable SPDIF
>       ARM: gr8: evb: Add i2s codec
>       ARM: sun8i: sina33: Enable USB gadget
>       ARM: sunxi: Add the missing clocks to the pinctrl nodes
> 
[...]

>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/ntc-gr8-chip-pro.dts             | 266 +++++++++++++++++++++
>  arch/arm/boot/dts/ntc-gr8-evb.dts                  |  33 +++
>  arch/arm/boot/dts/ntc-gr8.dtsi                     |  47 +++-
>  arch/arm/boot/dts/sun4i-a10.dtsi                   |   3 +-

NTC isn't the SoC manufacturer, and we try to keep the prefixes down to
manufacturer to keep the namespace a little more manageable, even if
we never got subdirectories setup as on arm64.

I think this should probably be sun4i-a10-gr8 or sun4i-r8-gr8 as prefix?


-Olof
