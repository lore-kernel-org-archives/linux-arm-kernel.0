From: tyler.baker@linaro.org (Tyler Baker)
Date: Thu, 5 Feb 2015 10:46:31 -0800
Subject: [PATCH 0/3] arm64,hi6220: Enable Hisilicon Hi6220 SoC
In-Reply-To: <1423128277-10297-1-git-send-email-bintian.wang@huawei.com>
References: <1423128277-10297-1-git-send-email-bintian.wang@huawei.com>
Message-ID: <CANMBJr685FzZzQ660Z1aNJX+Kzkw1OqM6RJAviARbL+5a=MJ2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bintian,

On 5 February 2015 at 01:24, Bintian Wang <bintian.wang@huawei.com> wrote:
> Hello,
>
> Hi6220 is one mobile solution of Hisilicon, this patchset contains
> initial support for Hi6220 SoC and HiKey development board, which
> is based on ARM Cortex A53 architecture. Initial support is minimal
> and includes just the arch configuration, clock driver, device tree
> configuration.
>
> Many peripheral drivers will be submitted later.
>
> Any comments will be appreciated!
>
> Thanks,
>
> Bintian Wang (3):
>   arm64: Enable Hisilicon ARMv8 SoC family in Kconfig and defconfig
>   clk: hi6220: Clock driver support for Hisilicon hi6220 SoC
>   arm64: dts: Add dts files for Hisilicon Hi6220 SoC

Thanks for posting these! I've applied this series on top of
next-20150204, however there was some fuzz that needed to be cleaned
up on 3/3 [1]. I've confirmed the platform is booting to a basic user
space without issue.

Tested-by: Tyler Baker <tyler.baker@linaro.org>

>
>  .../bindings/arm/hisilicon/hisilicon.txt           |   33 +++
>  .../devicetree/bindings/clock/hi6220-clock.txt     |   30 +++
>  arch/arm64/Kconfig                                 |    6 +
>  arch/arm64/boot/dts/Makefile                       |    1 +
>  arch/arm64/boot/dts/hisilicon/Makefile             |    5 +
>  arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts     |   31 +++
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi          |  204 ++++++++++++++
>  arch/arm64/configs/defconfig                       |    1 +
>  drivers/clk/Kconfig                                |    2 +
>  drivers/clk/Makefile                               |    4 +-
>  drivers/clk/hisilicon/Kconfig                      |    5 +
>  drivers/clk/hisilicon/Makefile                     |    1 +
>  drivers/clk/hisilicon/clk-hi6220.c                 |  284 ++++++++++++++++++++
>  drivers/clk/hisilicon/clk.c                        |   29 ++
>  drivers/clk/hisilicon/clk.h                        |   17 ++
>  drivers/clk/hisilicon/clkdivider-hi6220.c          |  273 +++++++++++++++++++
>  include/dt-bindings/clock/hi6220-clock.h           |  172 ++++++++++++
>  17 files changed, 1095 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/hi6220-clock.txt
>  create mode 100644 arch/arm64/boot/dts/hisilicon/Makefile
>  create mode 100644 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
>  create mode 100644 arch/arm64/boot/dts/hisilicon/hi6220.dtsi
>  create mode 100644 drivers/clk/hisilicon/Kconfig
>  create mode 100644 drivers/clk/hisilicon/clk-hi6220.c
>  create mode 100644 drivers/clk/hisilicon/clkdivider-hi6220.c
>  create mode 100644 include/dt-bindings/clock/hi6220-clock.h
>
> --
> 1.7.9.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Cheers,

Tyler

[1] https://git.linaro.org/people/tyler.baker/linux.git/commitdiff/e9ab7b08e844009c66ba5ecf946d4b3e23551f73?hp=fcfe654f30cf75c847f69b2965c6b9e4d01c5b08
