From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Oct 2017 23:43:38 +0200
Subject: [GIT PULL] Renesas ARM Based SoC DT Updates for v4.15
In-Reply-To: <cover.1506683482.git.horms+renesas@verge.net.au>
References: <cover.1506683482.git.horms+renesas@verge.net.au>
Message-ID: <CAK8P3a28v3ebPCY+bwQC3GgD_PsVuz+Y+xMtDX8xjYZX6T9KYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 29, 2017 at 1:53 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> ----------------------------------------------------------------
> Renesas ARM Based SoC DT Updates for v4.15
>
> * r7s72100 (RZ/A1) Peach board
>   - Add pin groups for SCIF2 serial debug interface and Ethernet
>     This avoids relying on bootloader settings
>   - Support control of LED1 using gpio-leds
>
> * r8a7743 (RZ/G1M) and r8a7745 (RZ/G1E) SoCs
>   - Add MSIOF[012] support and define aliases for spi[0123]
>
> * r8a7743 (RZ/G1M) SoC
>   - Add I2C and IIC core nodes
>
> * r8a7743 (RZ/G1M) iW-RainboW-G20D-Qseven development platform
>    - Enable SDHI1 SD controller supporting high-speed and SDR50 transfers
>    - Add chosen node to allow correct selection of serial console
>      and the kernel command line
>    - Enable RTC support
>    - Enable USB2.0 host support
>      This includes enabling USB PHY and internal PCI
>
> * r8a7743 (RZ/G1M) iW-RainboW-G20M-Qseven and
>   r8a7745 (RZ/G1E) iW-RainboW-G22M-SM SoMs
>    - Enable Add SPI NOR support
>      This devices is used to boot up the system to the SoM DT
>
> * r8a7743 (RZ/G1M) iW-RainboW-G20M-Qseven SoM
>   - Enable SDHI0 SD controller supporting high-speed transfers
>
> * r8a7745 (RZ/G1E) iW-RainboW-G22D development platform
>   - Add pnctl support for scif4
>     This avoids reling on boot loader settings
>   - Add EtherAVB support
>
> * r8a7745 (RZ/G1E) iW-RainboW-G22M-SM SoM
>   - Add basic SoM support
>   - Enable MMCIF eMMC support
>   - Enable RTC support
>   - Enable SDHI1 SD controller supporting high-speed transfers
>
> * r8a779[0-4] R-Car Gen2 SoCs
>   - Add reset control properties
>     Geert Uytterhoeven says:
>
>     This patch series describes the reset topology on all R-Car Gen2 Socs,
>     like was done before for R-Car Gen3 and RZ/G1.
>
>     Resets usually match the corresponding module clocks.  Exceptions are:
>       - The audio module has resets for the Serial Sound Interfaces only,
>       - The display module has only a single reset for all DU channels, but
>         adding reset properties for the display is postponed upon request
>         from Laurent.
>
>    - Convert to new CPG/MSSR bindings
>      Geert Uytterhoven says:
>
>      Currently Renesas R-Car Gen2 SoCs use the common clk-rcar-gen2,
>      clk-mstp, and clk-div6 drivers, which depend on most clocks being
>      described in DT.  Especially the module (MSTP) clocks are cumbersome
>      and error prone, due to 3 arrays (clocks, clock-indices, and
>      clock-output-names) to be kept in sync. In addition, the clk-mstp
>      driver cannot be extended easily to also support module resets, which
>      are provided by the same hardware module.
>
>      Hence when developing support for R-Car Gen3 SoCs, another approach
>      was chosen, which led to the CPG/MSSR driver core, and SoC-specific
>      subdrivers (initially for R-Car Gen3, but later also for RZ/G1).
>
>      This series converts the various R-Car Gen2 DTSes to migrate to the
>      new CPG/MSSR drivers that were added in v4.13-rc1.
>
> * r8a779[0,1,3,4] R-Car Gen2 SoCs
>   - Stop grouping clocks under a "clocks" subnode
>     Geert Uytterhoeven says:
>
>     The current practice is to not group clocks under a "clocks" subnode,
>     but just put them together with the other on-SoC devices.
>
>     Hence this patch series implements this for the various R-Car Gen2
>     DTSes that still need this (r8a7792.dtsi is OK).
>
> * r8a7794 (E2) Alt board
>   - Correct inverted sense of SD wip pins

Pulled into next/dt, thanks!

        Arnd
