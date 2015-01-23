From: kgene@kernel.org (Kukjin Kim)
Date: Fri, 23 Jan 2015 16:56:32 +0900
Subject: [PATCH v9 0/7] devfreq: Add devfreq-event class to provide raw
 data for devfreq device
In-Reply-To: <1421737809-4010-1-git-send-email-cw00.choi@samsung.com>
References: <1421737809-4010-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <0dd401d036e2$1a4431d0$4ecc9570$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chanwoo Choi wrote:
> 
Hi,

> This patchset add new devfreq_event class to provide raw data to determine
> current utilization of device  which is used for devfreq governor.
> 
Yes, would be nice to use common framework something like the devfreq_event you created :)

> The following description explains the feature of two kind of devfreq class:
> - devfreq class (existing)
>  : devfreq consumer device use raw data from devfreq_event device for
>    determining proper current system state and change voltage/frequency
>    dynamically using various governors.
> - devfreq_event class (new)
>  : Provide measured raw data to devfreq device for governor

[...]

> Chanwoo Choi (7):
>   devfreq: event: Add new devfreq_event class to provide basic data for devfreq governor
>   devfreq: event: Add exynos-ppmu devfreq-event driver
>   devfreq: event: Add documentation for exynos-ppmu devfreq-event driver
>   ARM: dts: Add PPMU dt node for Exynos3250 SoC
>   ARM: dts: Add PPMU dt node for Exynos4 SoCs
>   ARM: dts: exynos: Add PPMU node for Exynos3250-based Rinato/Monk board
>   ARM: dts: exynos: Add PPMU node for Exynos4412-based TRATS2 board
> 
>  .../bindings/devfreq/event/exynos-ppmu.txt         | 110 +++++
>  arch/arm/boot/dts/exynos3250-monk.dts              |  40 ++
>  arch/arm/boot/dts/exynos3250-rinato.dts            |  40 ++
>  arch/arm/boot/dts/exynos3250.dtsi                  |  74 +++
>  arch/arm/boot/dts/exynos4.dtsi                     | 108 +++++
>  arch/arm/boot/dts/exynos4210.dtsi                  |   8 +
>  arch/arm/boot/dts/exynos4412-trats2.dts            |  40 ++
>  drivers/devfreq/Kconfig                            |   2 +
>  drivers/devfreq/Makefile                           |   6 +-
>  drivers/devfreq/devfreq-event.c                    | 498 +++++++++++++++++++++
>  drivers/devfreq/event/Kconfig                      |  25 ++
>  drivers/devfreq/event/Makefile                     |   2 +
>  drivers/devfreq/event/exynos-ppmu.c                | 374 ++++++++++++++++
>  drivers/devfreq/event/exynos-ppmu.h                |  93 ++++
>  include/linux/devfreq-event.h                      | 196 ++++++++
>  15 files changed, 1615 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
>  create mode 100644 drivers/devfreq/devfreq-event.c
>  create mode 100644 drivers/devfreq/event/Kconfig
>  create mode 100644 drivers/devfreq/event/Makefile
>  create mode 100644 drivers/devfreq/event/exynos-ppmu.c
>  create mode 100644 drivers/devfreq/event/exynos-ppmu.h
>  create mode 100644 include/linux/devfreq-event.h
> 
> --

Looks good to me.

Myungjoo, shall I take DT changes in this series into Samsung tree?

4/7 ARM: dts: Add PPMU dt node for Exynos3250 SoC
5/7 ARM: dts: Add PPMU dt node for Exynos4 SoCs
6/7 ARM: dts: exynos: Add PPMU node for Exynos3250-based Rinato/Monk board
7/7 ARM: dts: exynos: Add PPMU node for Exynos4412-based TRATS2 board

Thanks,
Kukjin
