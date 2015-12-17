From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 17 Dec 2015 17:33:30 +0100
Subject: [PATCH v3 0/4] Raspberry Pi power domains
In-Reply-To: <1450215622-27394-1-git-send-email-eric@anholt.net>
References: <1450215622-27394-1-git-send-email-eric@anholt.net>
Message-ID: <CAPDyKFp=ykY4dFTxeq+et6z5ek-UYGnBOFG7Po0pSUL7jSYc8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 December 2015 at 22:40, Eric Anholt <eric@anholt.net> wrote:
> Since the pm_genpd_exit() patch is still going through review, and
> other drivers in the tree just ignore the error cases, Ulf offered to
> merge the series as a builtin driver not depending on that interface.
> We still avoid dangling pointer references, by just continuing with
> probing if of_genpd_add_provider_onecell() fails.  We can easily go
> back and update the driver when a pm_genpd_exit() lands.
>
> Alexander Aring (3):
>   ARM: bcm2835: add rpi power domain driver
>   dt-bindings: add rpi power domain driver bindings
>   ARM: bcm2835: Add the Raspberry Pi power domain driver to the DT.
>
> Eric Anholt (1):
>   ARM: bcm2835: Define two new packets from the latest firmware.
>
>  .../bindings/arm/bcm/raspberrypi,bcm2835-power.txt |  47 ++++
>  arch/arm/boot/dts/bcm2835-rpi.dtsi                 |  11 +
>  arch/arm/boot/dts/bcm2835.dtsi                     |   2 +-
>  arch/arm/mach-bcm/Kconfig                          |  10 +
>  arch/arm/mach-bcm/Makefile                         |   1 +
>  arch/arm/mach-bcm/raspberrypi-power.c              | 247 +++++++++++++++++++++
>  include/dt-bindings/arm/raspberrypi-power.h        |  41 ++++
>  include/soc/bcm2835/raspberrypi-firmware.h         |   2 +
>  8 files changed, 360 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-power.txt
>  create mode 100644 arch/arm/mach-bcm/raspberrypi-power.c
>  create mode 100644 include/dt-bindings/arm/raspberrypi-power.h
>
> --
> 2.6.2
>

Besides a nitpick for patch2, I would also reverse the order of patch3
and patch2. DT docs should go in before the actual parsing of the new
bindings/compatibles.

Anyway, for the hole series, you may add my:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
