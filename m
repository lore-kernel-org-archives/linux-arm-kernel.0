From: robh+dt@kernel.org (Rob Herring)
Date: Thu, 19 Apr 2018 20:06:52 -0500
Subject: [PATCH v6] ARM: dts: tpc: Device tree description of the iMX6Q
 TPC board
In-Reply-To: <20180419143240.3717-1-lukma@denx.de>
References: <20180405070939.22245-1-lukma@denx.de>
 <20180419143240.3717-1-lukma@denx.de>
Message-ID: <CAL_Jsq+TCaWZOuS-wKTFtxFShZcSj=Zg12f1NonN3DL-4hHWSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2018 at 9:32 AM, Lukasz Majewski <lukma@denx.de> wrote:
> This commit adds device tree description of Kieback & Peter GmbH
> iMX6Q TPC board.
>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
>
> ---
> Changes for v6:
> - Add space between // and SPDX
> - Replace 'disp0' with 'display'
> - Replace 'rtc: ds1307 at 32' with 'ds1307: rtc at 32'
> - Replace 'codec: audio-codec at a' with 'sgtl5000: audio-codec at a'
> - Move &can[12] nodes extension to proper position to be alphabetically sorted
>
> Changes for v5:
> - Use 'interpolation-steps' to fill the brightness level table
> - Remove not needed status = "okay" properties
> - Replace goodix_ts -> touchscreen
> - Replace sgtl5000 -> audio-codec
>
> This patch depends on PWM backlight intepolation work:
> https://patchwork.kernel.org/patch/10330775/
> https://patchwork.kernel.org/patch/10330777/
>
> Changes for v4:
> - Remove not needed bus-format-override = "rgb565";
>   property
>
> Changes for v3:
> - Provide proper compatible for RTC DTS node
> - Remove wrong comment style for beeper
> - Add proper SPDX entries for DTS files
> - Add vendor prefix to a separate patch
>
> Changes for v2:
> - SPDX license identifiers used
> - Separate regulators
> - Proper beeper driver
> - Use of the lcd panel (with compatible) instead of timings provided in
>   device tree
> - Add IRQ types (like IRQ_TYPE_EDGE_FALLING) and GPIO active levels (like
>   GPIO_ACTIVE_HIGH)
> - Remove not needed nodes
> - Make W=1 dtbs compilation with no errors
> ---
>  arch/arm/boot/dts/Makefile         |   1 +
>  arch/arm/boot/dts/imx6q-kp-tpc.dts |  22 ++
>  arch/arm/boot/dts/imx6q-kp.dtsi    | 432 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 455 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6q-kp-tpc.dts
>  create mode 100644 arch/arm/boot/dts/imx6q-kp.dtsi

Reviewed-by: Rob Herring <robh@kernel.org>
