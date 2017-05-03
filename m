From: guillaume.tucker@collabora.com (Guillaume Tucker)
Date: Wed,  3 May 2017 10:56:24 +0100
Subject: [PATCH v5 0/5] Add ARM Mali Midgard device tree bindings and gpu node
 for rk3288
Message-ID: <cover.1493804968.git.guillaume.tucker@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM Mali Midgard GPU kernel driver is only available
out-of-tree and is not going to be merged in its current form.
However, it would be useful to have its device tree bindings
merged.  In particular, this would enable distributions to create
working driver packages (dkms...) without having to patch the
kernel.

The bindings for the earlier Mali Utgard GPU family have already
been merged, so this is essentially the same scenario but for
newer GPUs (Mali-T604 ~ Mali-T880).

This series of patches first imports the bindings from the latest
driver release with some clean-up then adds a gpu node for the
rk3288 SoC.  This was successfully tested on Radxa Rock2 Square,
Firefly, Veyron Minnie and Jerry boards using Mali kernel driver
r16p0 and r12p0 user-space binary.


Changes since v1:
- enabled gpu on rk3288-veyron boards

Changes since v2:
- removed "clk-names" property and "clk_mali" name
- converted values of "interrupt-names" property to
  lower-case: "job", "mmu" and "gpu"
- replaced dt compatible strings with list of all Midgard GPU variants and
  optional vendors
- cleaned up gpu node example

Changes since v3:
- add "rockchip,rk3288-mali" vendor compatible string
- move gpu node at the right location in rk3288.dtsi
- use operating-points-v2 in documentation and rk3288.dtsi

Changes since v4:
- removed wildcards (mali-t60x, -t62x)
- vendor compatible strings are not optional any more
- example updated accordingly, based on rk3288


Enric Balletbo i Serra (1):
  ARM: dts: rockchip: enable ARM Mali GPU on rk3288-veyron

Guillaume Tucker (4):
  dt-bindings: gpu: add bindings for the ARM Mali Midgard GPU
  ARM: dts: rockchip: add ARM Mali GPU node for rk3288
  ARM: dts: rockchip: enable ARM Mali GPU on rk3288-rock2-som
  ARM: dts: rockchip: enable ARM Mali GPU on rk3288-firefly

 .../devicetree/bindings/gpu/arm,mali-midgard.txt   | 86 ++++++++++++++++++++++
 arch/arm/boot/dts/rk3288-firefly.dtsi              |  5 ++
 arch/arm/boot/dts/rk3288-rock2-som.dtsi            |  5 ++
 arch/arm/boot/dts/rk3288-veyron.dtsi               |  5 ++
 arch/arm/boot/dts/rk3288.dtsi                      | 43 +++++++++++
 5 files changed, 144 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt

--
2.11.0
