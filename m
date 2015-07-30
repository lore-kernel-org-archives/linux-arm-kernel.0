From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 30 Jul 2015 11:57:27 +0200
Subject: [PATCH v5 0/2] arm64: Add basic support for Marvell Berlin4CT SoC
In-Reply-To: <1438248922-2919-1-git-send-email-jszhang@marvell.com>
References: <1438248922-2919-1-git-send-email-jszhang@marvell.com>
Message-ID: <55B9F507.8090706@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/30/2015 11:35 AM, Jisheng Zhang wrote:
> Marvell Berlin4CT is a SoC based on 64bit ARMv8 architecture. It contains
> quad CA53 cores.
>
> This SoC shares many HW IP with BG2Q and other berlin series. This patchset
> was tested on Berlin4CT DMP board, and boot to shell ok.
>
> Since v4:
>   - rebased on the latest next tree

Jisheng,

some git basics, so you get a better idea of the merge process:

Please do not base your patches on linux-next. It is not a stable branch
I can refer to. Also, if there was any dependency with another feature
that your patches require, you should mention that dependency by
pointing out either a floating patch set or even better a _stable_
topic branch of the feature that will be added in the same cycle you
expect your patches to be merged.

AFAIKS, there is no dependency at all so please just base them on -rc1
(No need to resend, I can take care of it).

Anyway, I am fine with the series and it has been out for a while now.
I pick it up, let is set on linux-next for a while and send out a
topic PR at the end of the week.

Thanks!

Sebastian

>   - adopt Sebastian suggestions such as: move osc out of "/soc" node, use
>     "Marvell BG4CT DMP board" as model, etc.
>   - use correct memory size for BG4CT DMP. The total DDR size is 2GB, we start
>     from 0x01000000, so the avaiable linux memory should be 0x7f000000.
>
> Since v3:
>   - remove bootargs. follow the same behavior as other arm64 SoCs.
>
> Since v2:
>   - remove the memreserve which isn't removed by mistake
>   - add earlycon to enable earlyconsole, inspired by Sudeep
>
> Since v1:
>   - remove "earlyprintk" bootargs which doesn't work on arm64
>   - fix GICC_DIR size as pointed out by Mark
>   - define memory start address instead of memory reservation as suggested by Mark
>   - add interrupt-affinity to pmu node as pointed out by Sudeep
>
> Jisheng Zhang (2):
>    arm64: dts: Add dts files for Marvell Berlin4CT SoC
>    arm64: Enable Marvell Berlin SoC family in Kconfig and defconfig
>
>   arch/arm64/Kconfig.platforms                  |   6 +
>   arch/arm64/boot/dts/Makefile                  |   1 +
>   arch/arm64/boot/dts/marvell/Makefile          |   5 +
>   arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts |  66 +++++++++++
>   arch/arm64/boot/dts/marvell/berlin4ct.dtsi    | 164 ++++++++++++++++++++++++++
>   arch/arm64/configs/defconfig                  |   1 +
>   6 files changed, 243 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/marvell/Makefile
>   create mode 100644 arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts
>   create mode 100644 arch/arm64/boot/dts/marvell/berlin4ct.dtsi
>
