From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 15 Oct 2012 13:01:44 -0400
Subject: [PATCH 0/4] Add DT support for Network Space v2 and parents
In-Reply-To: <1350315295-14567-1-git-send-email-simon.guinot@sequanux.org>
References: <1350315295-14567-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <20121015170144.GG20922@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Simon,

On Mon, Oct 15, 2012 at 05:34:51PM +0200, Simon Guinot wrote:
> This patch series provides DT support for LaCie NAS Network Space v2 and
> parents. This includes the following machines:
>  - Internet Space v2
>  - Network Space v2
>  - Network Space Max v2
>  - Network Space Lite v2
>  - Network Space Mini v2
> 
> Note that the three first boards are already supported by the Linux
> kernel via an "old-fashion" board setup. The two lasts (Lite and Mini)
> are new boards.

Have you checked building support for the old and new in one kernel?  On
a quick check, it looks okay, but I only checked that ns2_init() wasn't
the _init function for the legacy board files.

> Also note that the first patch of the series is related with the LED
> subsystem. It adds device tree binding to the driver leds-ns2.
> 
> Simon Guinot (4):
>   leds: leds-ns2: add device tree binding
>   ARM: kirkwood: DT board setup for Network Space v2 and parents
>   ARM: kirkwood: DT board setup for Network Space Lite v2
>   ARM: kirkwood: DT board setup for Network Space Mini v2

I'm pretty sure this isn't the first version of this patch series ;-)
No need to resend, but could you attach a version number and changelog?

thx,

Jason.

> 
>  .../devicetree/bindings/gpio/leds-ns2.txt          |   26 ++++++
>  arch/arm/boot/dts/Makefile                         |    5 ++
>  arch/arm/boot/dts/kirkwood-is2.dts                 |   30 +++++++
>  arch/arm/boot/dts/kirkwood-ns2-common.dtsi         |   63 ++++++++++++++
>  arch/arm/boot/dts/kirkwood-ns2.dts                 |   30 +++++++
>  arch/arm/boot/dts/kirkwood-ns2lite.dts             |   30 +++++++
>  arch/arm/boot/dts/kirkwood-ns2max.dts              |   49 +++++++++++
>  arch/arm/boot/dts/kirkwood-ns2mini.dts             |   49 +++++++++++
>  arch/arm/mach-kirkwood/Kconfig                     |   36 ++++++++
>  arch/arm/mach-kirkwood/Makefile                    |    5 ++
>  arch/arm/mach-kirkwood/board-dt.c                  |   12 +++
>  arch/arm/mach-kirkwood/board-ns2.c                 |   87 ++++++++++++++++++++
>  arch/arm/mach-kirkwood/common.h                    |   10 +++
>  drivers/leds/Kconfig                               |    4 +-
>  drivers/leds/leds-ns2.c                            |   84 ++++++++++++++++++-
>  15 files changed, 516 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/gpio/leds-ns2.txt
>  create mode 100644 arch/arm/boot/dts/kirkwood-is2.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-ns2-common.dtsi
>  create mode 100644 arch/arm/boot/dts/kirkwood-ns2.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-ns2lite.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-ns2max.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-ns2mini.dts
>  create mode 100644 arch/arm/mach-kirkwood/board-ns2.c
> 
> -- 
> 1.7.10
> 
