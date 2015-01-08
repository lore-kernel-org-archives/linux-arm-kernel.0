From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 08 Jan 2015 15:56:00 +0100
Subject: [PATCH v3 0/7]
In-Reply-To: <1420727983-23922-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1420727983-23922-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <54AE9A80.6080100@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime, Andrew,

On 08/01/2015 15:39, Maxime Ripard wrote:
> Hi everyone,
> 
> This set of patches add the support for the Armada 385 AP board.
> 
> It also adds a few clean ups here and there, a few missing pin
> functions needed for the board, etc.

Maxime,

You forgot to write a topic for this email :)

Andrew,

If you want, in order to ease your job, I can send a series
including the patches from Maxime and my patches for this 2 new
Armada 38x boards: AP and GP.

But before this I really would like to have the answer from Nadav
to switch to the dual license GPL/X11.

Thanks,

Gregory


> 
> Maxime
> 
> Changes from v2:
>   - Removed the i2c1 bus that is not used
>   - Added comments for the i2c0 and the UARTs
>   - Removed the i2c clk-frequency property
>   - Fixed the SPI-NOR maximum frequency
>   - Fixed the phy nodes unit addresses
>   - Add the /chosen/stdout-path property
>   - Changed the filename to match the board compatible
> 
> Changes from v1:
>   - Removed USB3 support. This required some additional patches for
>     the phy and USB drivers that are not really related to this
>     serie. This will be submitted as a separate one.
>   - Removed earlyprintk from the default bootargs
>   - Removed two unneeded ranges
>   - Changed the phy pins node name to mdio
>   - Moved most of the pinctrl nodes to the DTSI
>   - Added a comment to mention why the phy reference clock is needed.
>   - Rebased on top of 3.19-rc1
> 
> Maxime Ripard (7):
>   ARM: mvebu: Rename DEBUG_LL to indicate UART index
>   ARM: mvebu: Add UART1 as DEBUG_LL possible target
>   ARM: mvebu: a38x: Fix node names
>   pinctrl: mvebu: a38x: Add UART1 muxing options
>   ARM: mvebu: A38x: Remove redundant pinctrl informations
>   ARM: mvebu: Add a number of pinctrl functions
>   ARM: mvebu: Add Armada 385 Access Point Development Board support
> 
>  arch/arm/Kconfig.debug                     |  35 +++++--
>  arch/arm/boot/dts/Makefile                 |   1 +
>  arch/arm/boot/dts/armada-380.dtsi          |   3 +-
>  arch/arm/boot/dts/armada-385-db-ap.dts     | 150 +++++++++++++++++++++++++++++
>  arch/arm/boot/dts/armada-385-db.dts        |   2 +-
>  arch/arm/boot/dts/armada-385-rd.dts        |   2 +-
>  arch/arm/boot/dts/armada-385.dtsi          |   3 +-
>  arch/arm/boot/dts/armada-38x.dtsi          |  44 ++++++++-
>  drivers/pinctrl/mvebu/pinctrl-armada-38x.c |   6 +-
>  9 files changed, 226 insertions(+), 20 deletions(-)
>  create mode 100644 arch/arm/boot/dts/armada-385-db-ap.dts
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
