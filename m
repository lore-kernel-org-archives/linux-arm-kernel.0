From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Dec 2017 16:21:57 +0100
Subject: [GIT PULL] Renesas ARM64 Based SoC DT Updates for v4.16
In-Reply-To: <cover.1512640145.git.horms+renesas@verge.net.au>
References: <cover.1512640145.git.horms+renesas@verge.net.au>
Message-ID: <CAK8P3a1v+GEegk3TVfFWV8D3Pm6UoArxwWSszOLbF6+qH6wRpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 7, 2017 at 10:53 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
>
> ----------------------------------------------------------------
> Renesas ARM64 Based SoC DT Updates for v4.16
>
> * Use r8a77970 (V3M) CPG core clock and SYSC power domain macros
>
>   These may be used in place of numeric constants now that they
>   are present in Linus's tree.
>
> * Add r8a77970 (V3M) Starter Kit board support
>
>   This includes basic support to bring up the board with a serial
>   console and EtherAVB support
>
> * Add IPMMU nodes and connections to on-chip devices
>   on r8a7795 (H3), r8a7796 (M3-W), r8a77970 (V3M) and r8a77995 (D3) SoCs
>
>   Simon Horman says "With these patches applied a white list enabled IPMMU
>   driver may be used to check silicon revision and then enable IPMMU in the
>   known working cases."
>
> * Enable DMA for SCIF2 on r8a77995 (D2) SoC
>
> * Increase the number of GPIO bank 1 ports to 29 on r8a7795 (H3) SoC
>
>   This adds support for the GP-1-28 port pin of the r8a7795 (H3) ES2.0 SoC
>
> * Add support for CAN to r8a77995 (D3) SoC
>
>   Ulrich Hecht says "This is a by-the-datasheet implementation, with the
>   datasheet missing some bits, namely the pin map.  I filled in the gaps...
>   by deducing the information from pin numbers already in the PFC driver,
>   so careful scrutiny is advised."
>
> * Add support for SDHI to r8a77995 (D3) SoC
>
> * Add SoC name to file header of r8a7795 (H3) and r8a7796 (M3-W)
>   Salvator-X and Salvator-XS board files
>
>   Geert Uytterhoeven says "With the proliferation of Salvator-X and
>   Salvator-XS boards carrying different R-Car Gen3 SoCs variants, several
>   DTS files ended up having the same file headers.
>
>   Add the SoC names to the file headers to avoid confusion."
>
> * Add device note for ROHM BD9571MWV PMIC to
>   r8a7795 (H3) and r8a7796 (M3-W) Salvator-X and Salvator-XS boards.
>
>   Geert Uytterhoeven says "This was based on the example in the DT binding
>   documentation, but using IRQ0 instead of a GPIO interrupt, as that
>   matches the schematics, and because INTC-EX is a simpler block."
>
> * Enable USB2.0 channel 0 on r8a77970 (V3M) ULCB Kingfisher board
>
>   Vladimir Barinov says "The dedicated USB0_PWEN pin is used to control
>   CN13 VBUS source from U43 power supply.  MAX3355 can also provide VBUS,
>   hence it should be disabled via OTG_OFFVBUSn node coming from gpio
>   expander TCA9539.  Set MAX3355 enabled using OTG_EXTLPn node to be able
>   to read OTG ID of CN13."
>
> * Add support for r8a7795 (M3-W) Salvator-XS board
>
>   Geert Uytterhoeven says "This patch series adds support for the version
>   of the Salvator-XS development board equipped with an R-Car M3-W SiP.
>
>   The DT was based on work for the Salvator-X and -XS boards with M3-W
>   resp. H3 SiPs."
>
> * Add watchdog timer support to r8a77970 (V3M) eagle board
>
>   Geert Uytterhoven says "This allows to use the watchdog timer to reset
>   the board, until PSCI is enhanced to include such functionality."
>
> * Use Use R-Car SDHI Gen3 fallback on r8a7795 (H3) and r8a7796 (M3-W) SoCs
>
> * Set driver type for MMC on r8a7795 (H3) and r8a7796 (M3-W) Salvator-X and
>   Salvator-XS boards.
>
>   Wolfram Sang says "These boards are known to have eMMC issues with the
>   default driver type.  Specify a working one."

Pulled into next/dt, thanks!

       Arnd
