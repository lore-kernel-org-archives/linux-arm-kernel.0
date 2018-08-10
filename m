From: dianders@chromium.org (Douglas Anderson)
Date: Fri, 10 Aug 2018 14:51:47 -0700
Subject: [PATCH 0/3] arm64: dts: sdm845: Add RPMh-regulators and usb
Message-ID: <20180810215150.82490-1-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This series adds device tree nodes for the RPMh regulators and USB.
These patches are based on patches in various downstream kernels from
Manu Gautam, David Collins, and Vivek Gautam.

This series was tested on SDM845-MTP (with no-AC firmware) atop Andy
Gross's current "for-next" branch at commit 76b9e7f947f1 ("Merge tag
'qcom-defconfig-for-4.19' into all-for-4.19") with some extra patches:

>From mainline:
- 87ed1405ef09 ("nvmem: Don't let a NULL cell_id for nvmem_cell_get() crash us")

>From clk-next:
- 9c7e47025a6b ("clk: qcom: clk-rpmh: Add QCOM RPMh clock driver")

>From regulator/for-next:
- 46fc033eba42 ("regulator: add QCOM RPMh regulator driver")
- 0db021f7a273 ("regulator: dt-bindings: add QCOM RPMh regulator bindings")

>From Will Deacon's tree (for-joerg/arm-smmu/updates):
- d1e20222d537 ("iommu/arm-smmu: Error out only if not enough context interrupts")

>From the mailing list (needs to be spun but works OK):
- dts: arm64/sdm845: Add node for arm,mmu-500
  https://lore.kernel.org/patchwork/patch/964814/

As you can see from the above all the dependencies except the addition
of the MMU node have landed so this series should be about ready to
land too.

If anyone would like to see the tree I used for test, it can be found
at:
  https://chromium.googlesource.com/chromiumos/third_party/kernel/+log/refs/sandbox/dianders/180810-agross-usbv2


Changes in v2:
- Use "0x784000" for qfprom rather than "0x780000" as per docs.
- Add calibration for 2nd USB port too
- LDO14 initial mode is LPM and shouldn't be always on (Vivek G)
- LDO25 should have min voltage of 3.3V

Douglas Anderson (2):
  arm64: dts: qcom: sdm845-mtp: Add RPMh VRM/XOB regulators
  arm64: dts: qcom: sdm845-mtp: Add nodes for USB

Manu Gautam (1):
  arm64: dts: qcom: sdm845: Add USB-related nodes

 arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 506 ++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi    | 196 +++++++++
 2 files changed, 702 insertions(+)

-- 
2.18.0.597.ga71716f1ad-goog
