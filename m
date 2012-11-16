From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 16 Nov 2012 09:19:47 -0500
Subject: [PATCH v2 0/3] GPIO driver to turn power off
In-Reply-To: <1352821485-10032-1-git-send-email-andrew@lunn.ch>
References: <1352821485-10032-1-git-send-email-andrew@lunn.ch>
Message-ID: <20121116141947.GN22106@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 13, 2012 at 04:44:42PM +0100, Andrew Lunn wrote:
> A few of the Kirkwood systems use a GPIO line to turn the power off on
> shutdown. They request the GPIO line in the board setup code,
> optionally setting it as an output and driving it inactive. They then
> register a function for pm_power_off. At the end of the shutdown, this
> function is called. The GPIO line is configured as an output, if not
> already so, and then driven active. In order to cover the use case of
> edges rather then levels, triggering power off, the GPIO line is then
> toggled active and later inactive. This should allow the driver to be
> used by PXA which also has boards using the same scheme.
> 
> The driver code was initially developed by Jamie Lentin and extended
> to cover the PXA case by Andrew Lunn.
> 
> v1 -> v2: Moved to drivers/power/reset
> 
> Andrew Lunn (2):
>   ARM: Kirkwood: Convert DNSKW to use gpio-poweroff.
>   ARM: Kirkwood: Convert IB62x0 to use gpio-poweroff.
> 
> Jamie Lentin (1):
>   power: Add simple poweroff-gpio driver
> 
>  .../devicetree/bindings/gpio/gpio-poweroff.txt     |   22 ++++
>  arch/arm/boot/dts/kirkwood-dnskw.dtsi              |    5 +
>  arch/arm/boot/dts/kirkwood-ib62x0.dts              |    6 +
>  arch/arm/mach-kirkwood/Kconfig                     |    4 +
>  arch/arm/mach-kirkwood/board-dnskw.c               |   12 --
>  arch/arm/mach-kirkwood/board-ib62x0.c              |   13 --
>  drivers/power/Kconfig                              |    3 +
>  drivers/power/Makefile                             |    1 +
>  drivers/power/reset/Kconfig                        |   15 +++
>  drivers/power/reset/Makefile                       |    1 +
>  drivers/power/reset/gpio-poweroff.c                |  129 ++++++++++++++++++++
>  11 files changed, 186 insertions(+), 25 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-poweroff.txt
>  create mode 100644 drivers/power/reset/Kconfig
>  create mode 100644 drivers/power/reset/Makefile
>  create mode 100644 drivers/power/reset/gpio-poweroff.c

Anton,

Is it ok if we take this through the arm-soc tree with your Ack?

thx,

Jason.
