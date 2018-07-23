From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 23 Jul 2018 07:50:09 -0500
Subject: [GIT PULL] Amlogic 64-bit DT updates for v4.19, round 2
In-Reply-To: <20180721215422.vsd34udhkhs7lh3h@localhost> (Olof Johansson's
 message of "Sat, 21 Jul 2018 14:54:22 -0700")
References: <7hr2jx50q0.fsf@baylibre.com>
 <20180721215422.vsd34udhkhs7lh3h@localhost>
Message-ID: <7hk1pm3ym6.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson <olof@lixom.net> writes:

> On Fri, Jul 20, 2018 at 11:30:15AM -0500, Kevin Hilman wrote:
>> Olof, Arnd,
>> 
>> A second round of DT updates for Amlogic, directly on top of the redo of
>> the first one.
>> 
>> This includes a merge of a branch already queued in the clk tree because
>> of the dependency on clock headers used in the DT changes here..
>> 
>> Kevin
>> 
>> 
>> The following changes since commit 89803e8b26569bdf5798f8745a4c708bf9360ee6:
>> 
>>   ARM64: dts: meson-axg: add pdm pins (2018-07-20 08:18:37 -0700)
>> 
>> are available in the git repository at:
>> 
>>   https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt64-2
>> 
>> for you to fetch changes up to fcf775a1e6717b7157b1ea626028b7e039b3c989:
>> 
>>   Merge branch 'v4.19/dt64' into tmp/aml-rebuild (2018-07-20 09:05:11 -0700)
>> 
>> ----------------------------------------------------------------
>> Amlogic 64-bit DT changes for v4.19, round 2
>> - new SoC: S905W
>> - new boards: based on S905W: Amlogic P281, Oranth Tanix TX3 Mini
>> - AXG: add DT for new audio clock controller
>> 
>> ----------------------------------------------------------------
>
> Something happened to your diffstat here. It's also based on -rc5?

My branch is/was based on -rc1 but the dependency branch from the clock
tree is based on -rc5.  That made the diffstat include -rc5, which was
too noisy, so I removed it but then forgot to add the simplified
version.

Here it is.

Kevin


----------------------------------------------------------------
Jerome Brunet (3):
      dt-bindings: clock: add meson axg audio clock controller bindings
      clk: meson: expose GEN_CLK clkid
      ARM64: dts: meson-axg: add the audio clock controller

Kevin Hilman (3):
      Merge tag 'meson-clk-dt-for-v4.19' of https://github.com/BayLibre/clk-meson into v4.19/dt64-2
      Merge branch 'v4.19/dt64' into tmp/aml-rebuild
      Merge tag 'amlogic-dt64-2' into tmp/merge

Martin Blumenstingl (5):
      dt-bindings: add vendor prefix for Shenzhen Oranth Technology Co., Ltd.
      dt-bindings: arm: amlogic: Add support for GXL S905W and the P281 board
      dt-bindings: arm: amlogic: Add support for the Oranth Tanix TX3 Mini
      ARM64: dts: meson-gxl: add support for the S905W SoC and the P281 board
      ARM64: dts: meson-gxl: add support for the Oranth Tanix TX3 Mini

Yixun Lan (1):
      clk: meson-axg: add pcie and mipi clock bindings

 Documentation/devicetree/bindings/arm/amlogic.txt                  |  7 +++++++
 Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 Documentation/devicetree/bindings/vendor-prefixes.txt              |  1 +
 arch/arm64/boot/dts/amlogic/Makefile                               |  2 ++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi                         | 36 ++++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905w-p281.dts               | 22 ++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905w-tx3-mini.dts           | 22 ++++++++++++++++++++++
 include/dt-bindings/clock/axg-audio-clkc.h                         | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/dt-bindings/clock/axg-clkc.h                               |  4 ++++
 include/dt-bindings/clock/gxbb-clkc.h                              |  1 +
 10 files changed, 245 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905w-p281.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905w-tx3-mini.dts
 create mode 100644 include/dt-bindings/clock/axg-audio-clkc.h
