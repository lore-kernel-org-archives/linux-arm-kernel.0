From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 17 Dec 2015 14:32:48 -0800
Subject: [PATCH v4 0/4] Raspberry Pi power domains
In-Reply-To: <1450312009-1791-1-git-send-email-eric@anholt.net> (Eric Anholt's
 message of "Wed, 16 Dec 2015 16:26:45 -0800")
References: <1450312009-1791-1-git-send-email-eric@anholt.net>
Message-ID: <7hh9jg7lkf.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric Anholt <eric@anholt.net> writes:

> Update from v3 to move the driver under drivers/soc.  I've placed it
> under drivers/soc/bcm since that's how the other drivers under
> drivers/soc are structured.

Thanks, I like it better under drivers/soc too.

Reviewed-by: Kevin Hilman <khilman@linaro.org>

Kevin

> Alexander Aring (3):
>   ARM: bcm2835: add rpi power domain driver
>   dt-bindings: add rpi power domain driver bindings
>   ARM: bcm2835: Add the Raspberry Pi power domain driver to the DT.
>
> Eric Anholt (1):
>   ARM: bcm2835: Define two new packets from the latest firmware.
>
>  .../bindings/soc/bcm/raspberrypi,bcm2835-power.txt |  47 ++++
>  arch/arm/boot/dts/bcm2835-rpi.dtsi                 |  11 +
>  arch/arm/boot/dts/bcm2835.dtsi                     |   2 +-
>  drivers/soc/Kconfig                                |   1 +
>  drivers/soc/Makefile                               |   1 +
>  drivers/soc/bcm/Kconfig                            |   9 +
>  drivers/soc/bcm/Makefile                           |   1 +
>  drivers/soc/bcm/raspberrypi-power.c                | 247 +++++++++++++++++++++
>  include/dt-bindings/soc/raspberrypi-power.h        |  41 ++++
>  include/soc/bcm2835/raspberrypi-firmware.h         |   2 +
>  10 files changed, 361 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/soc/bcm/raspberrypi,bcm2835-power.txt
>  create mode 100644 drivers/soc/bcm/Kconfig
>  create mode 100644 drivers/soc/bcm/Makefile
>  create mode 100644 drivers/soc/bcm/raspberrypi-power.c
>  create mode 100644 include/dt-bindings/soc/raspberrypi-power.h
