From: peron.clem@gmail.com (=?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?=)
Date: Tue, 10 Jul 2018 16:55:36 +0200
Subject: [PATCH v7 0/5] Reintroduce i.MX EPIT Timer
In-Reply-To: <20180611155001.3506-1-peron.clem@gmail.com>
References: <20180611155001.3506-1-peron.clem@gmail.com>
Message-ID: <CAJiuCcf3g2fzrR2_4mthjwKRcyZ8KVPX+EZ5_Uifh2E6TkzusQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Is there still some remark against merging this ?

Thanks,
Clement

On Mon, 11 Jun 2018 at 17:50, Cl?ment P?ron <peron.clem@gmail.com> wrote:
>
> From: Cl?ment Peron <clement.peron@devialet.com>
>
> As suggested in the commit message we have added the device tree support,
> proper bindings and we moved the driver into the correct folder.
>
> Moreover we made some changes like use of relaxed IO accesor,
> implement sched_clock, delay_timer and reduce the clockevents min_delta.
>
> Changes since v6:
> -fix indent
>
> Changes since v5:
> - change epit to timer in doc example
> - fix typo in imx6sl.dtsi
>
> Changes since v4:
> - removed ipg clk
> - change in dt epit to timer
> - add introduction in doc
> - add all compatibles in doc
> - update epit entry for other i.MX device-trees
>
> Changes since v3:
> - Clean Kconfig
> - Rename imx6q-epit to imx31-epit
> - Update doc and bindings
> - Indent and fix
>
> Changes since v2 (Thanks Fabio Estevam):
> - Removed unused ckil clock
> - Add out_iounmap
> - Check and handle if clk_prepare_enable failed
> - Fix comment typo
>
> Changes since v1 (Thanks Vladimir Zapolskiy):
> - Add OF dependency in Kconfig
> - Sort header
> - Use BIT macro
> - Remove useless comments
> - Fix incorrect indent
> - Fix memory leak
> - Add check and handle possible returned error
>
> Cl?ment Peron (2):
>   ARM: imx: remove inexistant EPIT timer init
>   dt-bindings: timer: add i.MX EPIT timer binding
>
> Colin Didier (3):
>   clk: imx6: add EPIT clock support
>   clocksource: add driver for i.MX EPIT timer
>   ARM: dts: imx: add missing compatible and clock properties for EPIT
>
>  .../devicetree/bindings/timer/fsl,imxepit.txt |  21 ++
>  arch/arm/boot/dts/imx25.dtsi                  |   8 +-
>  arch/arm/boot/dts/imx6qdl.dtsi                |  10 +-
>  arch/arm/boot/dts/imx6sl.dtsi                 |  10 +-
>  arch/arm/boot/dts/imx6sx.dtsi                 |  10 +-
>  arch/arm/boot/dts/imx6ul.dtsi                 |  10 +-
>  arch/arm/mach-imx/common.h                    |   1 -
>  drivers/clk/imx/clk-imx6q.c                   |   2 +
>  drivers/clocksource/Kconfig                   |  11 +
>  drivers/clocksource/Makefile                  |   1 +
>  drivers/clocksource/timer-imx-epit.c          | 265 ++++++++++++++++++
>  include/dt-bindings/clock/imx6qdl-clock.h     |   4 +-
>  12 files changed, 341 insertions(+), 12 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/timer/fsl,imxepit.txt
>  create mode 100644 drivers/clocksource/timer-imx-epit.c
>
> --
> 2.17.1
>
