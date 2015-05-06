From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 06 May 2015 15:06:29 +0200
Subject: [PATCH v2 0/5] Add proper support for Compulab CM-A510/SBC-A510
In-Reply-To: <1430770130-7833-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1430770130-7833-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <554A11D5.9060407@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

On 04/05/2015 22:08, Sebastian Hesselbarth wrote:
> This is v2 of the patch set to improve current mainline support for
> the Compulab CM-A510 System-on-Module (SoM) and its default Compulab
> SBC-A510 base board.
> 
> Compared to v1 [1] there have been the overall changes:
> - Drop i2c-mux-pinctrl rework as Wolfram Sang raised concerns with
>   respect to OF_DYNAMIC. Instead we add i2c-mux-pinctrl node by
>   default and wait until corresponding driver respects disabled
>   sub-bus nodes. This will add 3 additional i2c busses to all
>   Dove based boards, but no functional change with respect to
>   i2c-0.
> - Split patches dealing with arch/arm/boot/dts/Makefile to route
>   them though arm-soc directly.
> 
> Other patches of v1 have already been taken by MVEBU SoC maintainers
> as fixes.
> 
> Patches are based on v4.1-rc1 and are intended for v4.2. All patches
> contain appropriate Acked-by's from related maintainers. Patches 3
> and 5 should go thought arm-soc directly, the rest can go though
> mvebu tree.

Usually even the change of the arch/arm/boot/dts/Makefile go to
arm-soc through mvebu. For patch 5 it makes sens because if the series
is spited then the Makefile could be merged before the new file
to build.

So unless, Arnd or Olof really want to pick the patches 3 and 5 I will
apply the patches 2 to 5 on mvebu/dt.

Arnd, Olof, do you agree?

Thanks,

Gregory



> 
> Sebastian
> 
> [1] http://thread.gmane.org/gmane.linux.drivers.devicetree/110324
> 
> Sebastian Hesselbarth (5):
>   devicetree: vendor-prefixes: Add CompuLab to known vendors
>   ARM: dts: dove: Add internal i2c multiplexer node
>   ARM: dts: dove: Remove Compulab CM-A510 from Makefile
>   ARM: dts: dove: Add proper support for Compulab CM-A510/SBC-A510
>   ARM: dts: dove: Add Compulab SBC-A510 to Makefile
> 
>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>  arch/arm/boot/dts/Makefile                         |   4 +-
>  arch/arm/boot/dts/dove-cm-a510.dts                 |  38 ----
>  arch/arm/boot/dts/dove-cm-a510.dtsi                | 195 +++++++++++++++++++++
>  arch/arm/boot/dts/dove-sbc-a510.dts                | 182 +++++++++++++++++++
>  arch/arm/boot/dts/dove.dtsi                        |  40 ++++-
>  6 files changed, 418 insertions(+), 42 deletions(-)
>  delete mode 100644 arch/arm/boot/dts/dove-cm-a510.dts
>  create mode 100644 arch/arm/boot/dts/dove-cm-a510.dtsi
>  create mode 100644 arch/arm/boot/dts/dove-sbc-a510.dts
> 
> ---
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Gabriel Dobato <dobatog@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
