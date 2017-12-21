From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Dec 2017 16:20:45 +0100
Subject: [GIT PULL] Renesas ARM Based SoC DT Updates for v4.16
In-Reply-To: <cover.1512555546.git.horms+renesas@verge.net.au>
References: <cover.1512555546.git.horms+renesas@verge.net.au>
Message-ID: <CAK8P3a2TAs8U1W0v8amgtpZg+z3VS6fC6rce20uN1tAjQYdZnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 6, 2017 at 11:22 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
>
> Please consider these Renesas ARM based SoC DT updates for v4.16.
>
>
> The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:
>
>   Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)
>
> are available in the git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-for-v4.16
>
> for you to fetch changes up to 7f32eddb81ecc06131a643babe2d0f961fbd7f08:
>
>   ARM: dts: alt: Convert to named i2c-gpio bindings (2017-12-04 09:34:53 +0100)
>
> ----------------------------------------------------------------
> Renesas ARM Based SoC DT Updates for v4.16
>
> * Convert to named i2c-gpio bindings
>
>   Geert Uytterhoeven says "Commits 7d29f509d2cfd807 ("dt-bindings: i2c:
>   i2c-gpio: Add support for named gpios") and 05c74778858d7d99 ("i2c: gpio:
>   Add support for named gpios in DT") introduced named i2c-gpio DT
>   bindings, and deprecated the more error-prone unnamed variant.
>
>   This patch series switches all Renesas boards to the new bindings, and
>   adds the missing GPIO_OPEN_DRAIN I/O flags, which were implicitly
>   assumed before..."
>
>   ...  Note that after this series is applied, the i2c-gpio buses are no
>   longer detected when booting new DTBs on old (v4.14 and older) kernels,
>   which should not be an issue.  Booting old DTBs on new kernels is not
>   affected."
>
> * Update DTS for CMT DT binding rework
>
>   Geert Uytterhoeven says "This patch series updates the CMT device nodes
>   in the various Renesas DTS files sh_cmt clocksource driver for the recent
>   DT binding rework that was merged in v4.14-rc1 and v4.15-rc1..."
>
> * Add SMP support to r8a7794 (R-Car E2) SoC
>
>   Sergei Shtylyov says "Add the device tree node for the Advanced Power
>   Management Unit (APMU).  Use the "enable-method" prop to  point out that
>   the APMU should be used for the SMP support."
>
> * Correct primary compatible value for eeprom
>   on r7s72100 (RZ/A1H) genmai and r8a7791 (R-Car M2-W) koelsh boards
>
>   Geert Uytterhoeven says "The Renesas part numbers of the two-wire serial
>   interface EEPROMs do not follow the 24Cxx pattern, but the R1EX24xxx
>   pattern.
>
>   Hence change the primary compatible values to the appropriate variant of
>   "renesas,r1ex24xxx", like is already done on Gose.""
>
> * Move cec_clock to root node on r8a7791 (R-Car M2-W) koelsh board
>   r8a7791 (R-Car M2-W) koelsh board
>
> * Use R-Car SDHI and Ether Gen1 and 2 fallback compat strings
>
>   Use recently posted R-Car SDHI and Ether Gen 1 and 2 fallback
>   compat strings in the DT of Renesas ARM based SoCs.
>
> * Add IIC cores to dtsi of r8a7745 (RZ/G1E) SoC
>
> * Rework DT architecture for r8a7745 (RZ/G1E) iW-RainboW-G22D development
>   platform and add serial support.
>
>   Fabrizio Castro says "... define a new DT architecture for the
>   iW-RainboW-G22D SODIMM Development Platform to include the configuration
>   with the HDMI daughter board and to define the serial interfaces."
>
> * Add USB function support to
>   r8a7745 (RZ/G1E) iW-RainboW-G22D development platform
>
> * Add PCIEC and ttySC3 support to r8a7743 (RZ/G1M) iW-RainboW-G20M-Qseven SoM
>
> * Add VIN support to r8a7743 (RZ/G1M) and r8a7745 (RZ/G1E) SoCs
>
> * Add CAN and HDMI support to r8a7743 (RZ/G1M) iW-RainboW-G20D-Qseven and
>   r8a7745 (RZ/G1E) iW-RainboW-G22D development platforms

Pulled into next/dt, thanks for the detailed description!

        Arnd
