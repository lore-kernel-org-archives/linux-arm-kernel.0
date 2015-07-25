From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sat, 25 Jul 2015 16:54:36 +0200
Subject: [PATCH v2 0/3] Add DT support for netxbig LEDs
In-Reply-To: <1434628373-11834-1-git-send-email-simon.guinot@sequanux.org>
References: <1434628373-11834-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <55B3A32C.1010305@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon, Bryan, Richard,

On 18/06/2015 13:52, Simon Guinot wrote:
> Hello,
> 
> This patch series adds DT support for the LEDs found on the Kirkwood-based
> LaCie boards 2Big and 5Big Network v2.

I saw that some led related patch on kirkwood based board have been merged.
What is the status of this series?

I still have the patch 2 and 3 in my inbox waiting for being applied.

Thanks,

Gregory


> 
> Changes since v1:
> - Check timer mode value retrieved from DT.
> - In netxbig_leds_get_of_pdata, don't use unsigned long variables to get
>   timer delay values from DT with function of_property_read_u32_index.
>   Instead, use a temporary u32 variable. This allows to silence a static
>   checker warning.
> - Make timer property optional in the binding documentation. It is now
>   aligned with the driver code.
> 
> Simon
> 
> Simon Guinot (3):
>   leds: netxbig: add device tree binding
>   ARM: Kirkwood: add LED DT entries for netxbig boards
>   ARM: mvebu: remove static LED setup for netxbig boards
> 
>  .../devicetree/bindings/gpio/netxbig-gpio-ext.txt  |  22 ++
>  .../devicetree/bindings/leds/leds-netxbig.txt      |  92 ++++++++
>  arch/arm/boot/dts/kirkwood-net5big.dts             |  60 +++++
>  arch/arm/boot/dts/kirkwood-netxbig.dtsi            |  80 +++++++
>  arch/arm/mach-mvebu/Kconfig                        |   7 -
>  arch/arm/mach-mvebu/Makefile                       |   1 -
>  arch/arm/mach-mvebu/board.h                        |  21 --
>  arch/arm/mach-mvebu/kirkwood.c                     |   4 -
>  arch/arm/mach-mvebu/netxbig.c                      | 191 ----------------
>  drivers/leds/leds-netxbig.c                        | 250 +++++++++++++++++++--
>  include/dt-bindings/leds/leds-netxbig.h            |  18 ++
>  11 files changed, 501 insertions(+), 245 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/gpio/netxbig-gpio-ext.txt
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-netxbig.txt
>  delete mode 100644 arch/arm/mach-mvebu/board.h
>  delete mode 100644 arch/arm/mach-mvebu/netxbig.c
>  create mode 100644 include/dt-bindings/leds/leds-netxbig.h
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
