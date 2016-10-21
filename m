From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 21 Oct 2016 10:51:11 +0200
Subject: [PATCH v2 0/6] DT: Fix spelling of standard properties
Message-ID: <1477039877-20227-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi all,

This patch series fixes misspellings of various standard DT properties
in DT binding documentation, DTS files, and error messages.
While most of these are harmless, some of them may cause hard-to-debug
failures.

Changes compared to v2:
  - Dropped patches that have been applied already,
  - Add Rob Herring's Acked-by,
  - Split off "[PATCH v2 4/6] ASoC: davinci-mcbsp: DT fix
    s/interrupts-names/interrupt-names/" from the unrelated "[PATCH 06/14]
    dmaengine: bcm2835: DT spelling s/interrupts-names/interrupt-names/",
  - Add new patch "[PATCH v2 3/6] arm64: dts: lg1313: DT fix
    s/#interrupts-cells/#interrupt-cells/".

Please apply where appropriate.

Thanks!

P.S. I used the following to detect misspellings:

    words="(address|clock|cooling|dma|gpio|index|interrupt|mbox|msi|nvmem|phy|phys|power-domain|pwm|reset|size|sleep|sound-dai|thermal-sensor)"

    git grep -Ew "${words}s-names"
    git grep -E "[^-]\<${words}-name\>[^-]"
    git grep -Ew "#${words}s-cells"             # false positive phys-cells
    git grep -E "#${words}-cell\>[^-]"

    git grep -w adress-cells
    git grep -Ew "interrupts-(map|parent)"

Geert Uytterhoeven (6):
  ARM: dts: STiH407: DT fix s/interrupts-names/interrupt-names/
  arm64: dts: lg1312: DT fix s/#interrupts-cells/#interrupt-cells/
  arm64: dts: lg1313: DT fix s/#interrupts-cells/#interrupt-cells/
  ASoC: davinci-mcbsp: DT fix s/interrupts-names/interrupt-names/
  dt: booting-without-of: DT fix s/#interrupt-cell/#interrupt-cells/
  powerpc: dts: acadia: DT fix s/#interrupts-parent/#interrupt-parent/

 Documentation/devicetree/bindings/sound/davinci-mcbsp.txt | 2 +-
 Documentation/devicetree/booting-without-of.txt           | 2 +-
 arch/arm/boot/dts/stih407-pinctrl.dtsi                    | 2 +-
 arch/arm64/boot/dts/lg/lg1312.dtsi                        | 2 +-
 arch/arm64/boot/dts/lg/lg1313.dtsi                        | 2 +-
 arch/powerpc/boot/dts/acadia.dts                          | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
