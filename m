From: mporter@linaro.org (Matt Porter)
Date: Tue, 4 Feb 2014 09:34:09 -0500
Subject: [PATCH 0/6] BCM59056 PMU regulator support
In-Reply-To: <20140204134043.GG13529@lee--X1>
References: <1391516352-32359-1-git-send-email-mporter@linaro.org>
 <20140204134043.GG13529@lee--X1>
Message-ID: <20140204143409.GB4627@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 01:40:43PM +0000, Lee Jones wrote:
> > The BCM59056 is a multi-function power management unit used with the
> > BCM281xx family of SoCs. This series adds an MFD and voltage regulator
> > driver to support the BCM59056. The bcm28155-ap DT support is updated
> > to enable use of regulators on the otg and sdhci peripherals.
> > 
> > Matt Porter (6):
> >   i2c: bcm-kona: register with subsys_initcall
> >   regulator: add bcm59056 pmu DT binding
> >   mfd: add bcm59056 pmu driver
> >   regulator: add bcm59056 regulator driver
> >   ARM: configs: bcm_defconfig: enable bcm59056 regulator support
> >   ARM: dts: add bcm59056 pmu support and enable for bcm28155-ap
> > 
> >  .../devicetree/bindings/regulator/bcm59056.txt     |  37 ++
> >  arch/arm/boot/dts/bcm28155-ap.dts                  |  41 ++
> >  arch/arm/boot/dts/bcm59056.dtsi                    | 158 ++++++++
> >  arch/arm/configs/bcm_defconfig                     |   7 +
> >  drivers/i2c/busses/i2c-bcm-kona.c                  |  14 +-
> >  drivers/mfd/Kconfig                                |   8 +
> >  drivers/mfd/Makefile                               |   1 +
> >  drivers/mfd/bcm59056.c                             | 119 ++++++
> >  drivers/regulator/Kconfig                          |   8 +
> >  drivers/regulator/Makefile                         |   1 +
> >  drivers/regulator/bcm59056-regulator.c             | 445 +++++++++++++++++++++
> >  include/linux/mfd/bcm59056.h                       |  35 ++
> >  12 files changed, 873 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/devicetree/bindings/regulator/bcm59056.txt
> >  create mode 100644 arch/arm/boot/dts/bcm59056.dtsi
> >  create mode 100644 drivers/mfd/bcm59056.c
> >  create mode 100644 drivers/regulator/bcm59056-regulator.c
> >  create mode 100644 include/linux/mfd/bcm59056.h
> 
> FYI: Mark's email address is not correct. Not sure where you pulled
> this one up from, but he doesn't have access to it anymore.

Thanks, I already updated (it was a stale .mutt/aliases entry here) it
after the bounces.

-Matt
