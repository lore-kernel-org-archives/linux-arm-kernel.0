From: kgene@kernel.org (kgene at kernel.org)
Date: Fri, 10 Jan 2014 17:30:26 +0900
Subject: [PATCH v4 0/7] ARM: S3C24XX: Convert s3c2416 and s3c2443 to common
 clock framework
In-Reply-To: <201312101614.29781.heiko@sntech.de>
References: <201312101614.29781.heiko@sntech.de>
Message-ID: <093901cf0dde$36601100$a3203300$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko St?bner wrote:
> 
> Next try, this time with less time between submissions.
> 
> Tested on both non-dt and dt s3c2416.
> 
> Changes since v3:
> - address comments from Tomasz Figa (binding documentation, etc)
> - prevent conflicts with unconverted s3c24xx socs
> Changes since v2
> - address comments from Tomasz Figa
> - use new pll registration mechanism
> - use fixed-rate clocks for xti etc
> 
> Heiko Stuebner (7):
>   clk: samsung: add pll_6552 variant for s3c2416
>   clk: samsung: add plls used by the s3c2443
>   dt-bindings: add binding for clock-controller of s3c2443 and following
>   clk: samsung: add clock-driver for s3c2416, s3c2443 and s3c2450
>   ARM: S3C24XX: prevent conflicts between ccf and non-ccf s3c24xx-socs
>   ARM: dt: add clock data for s3c2416
>   ARM: S3C24XX: Convert s3c2416 and s3c2443 to common clock framework
> 
>  .../bindings/clock/samsung,s3c2443-clock.txt       |   56 ++
>  arch/arm/boot/dts/s3c2416-smdk2416.dts             |   13 +
>  arch/arm/boot/dts/s3c2416.dtsi                     |   42 ++
>  arch/arm/mach-s3c24xx/Kconfig                      |   18 +-
>  arch/arm/mach-s3c24xx/Makefile                     |    5 +-
>  arch/arm/mach-s3c24xx/clock-s3c2416.c              |  171 -----
>  arch/arm/mach-s3c24xx/clock-s3c2443.c              |  212 ------
>  arch/arm/mach-s3c24xx/common-s3c2443.c             |  675 -------------------
> -
>  arch/arm/mach-s3c24xx/common.c                     |   18 +-
>  arch/arm/mach-s3c24xx/common.h                     |    6 +
>  arch/arm/mach-s3c24xx/mach-s3c2416-dt.c            |   39 +-
>  arch/arm/mach-s3c24xx/mach-smdk2416.c              |    9 +-
>  arch/arm/mach-s3c24xx/mach-smdk2443.c              |    9 +-
>  drivers/clk/samsung/Makefile                       |    1 +
>  drivers/clk/samsung/clk-pll.c                      |   84 ++-
>  drivers/clk/samsung/clk-pll.h                      |    3 +
>  drivers/clk/samsung/clk-s3c2443.c                  |  417 ++++++++++++
>  include/dt-bindings/clock/samsung,s3c2443-clock.h  |   92 +++
>  18 files changed, 756 insertions(+), 1114 deletions(-)
>  create mode 100644
> Documentation/devicetree/bindings/clock/samsung,s3c2443-clock.txt
>  delete mode 100644 arch/arm/mach-s3c24xx/clock-s3c2416.c
>  delete mode 100644 arch/arm/mach-s3c24xx/clock-s3c2443.c
>  delete mode 100644 arch/arm/mach-s3c24xx/common-s3c2443.c
>  create mode 100644 drivers/clk/samsung/clk-s3c2443.c
>  create mode 100644 include/dt-bindings/clock/samsung,s3c2443-clock.h
> 
> --
> 1.7.10.4

Heiko,
Looks nice to me and I'm going to send this series to clk tree for v3.14.

Mike,
This series got you and Tomasz's ack for 3.14. Since major change is for clk stuff and there is no dependency with samsung tree, I'd like to send pull-request for this series to you for v3.14 tonight. If any problems, please kindly let me know.

Thanks,
Kukjin
