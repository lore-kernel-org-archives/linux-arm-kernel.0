From: dianders@chromium.org (Douglas Anderson)
Date: Tue, 10 Jul 2018 15:01:59 -0700
Subject: [PATCH 0/3] arm64: dts: sdm845: Add RPMh-regulators and usb
Message-ID: <20180710220202.116404-1-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This series adds device tree nodes for the RPMh regulators and USB.  These
patches are based on patches in various downstream kernels from Manu Gautam
and David Collins.

This series was tested on SDM845-MTP (with no-AC firmware) atop Andy Gross's
current "for-next" branch with some patches picked from list:

1. clk: qcom: clk-rpmh: Add QCOM RPMh clock driver
   https://patchwork.kernel.org/patch/10388151/
2. regulator: add QCOM RPMh regulator driver
   https://patchwork.kernel.org/patch/10483369/
3. nvmem: Don't let a NULL cell_id for nvmem_cell_get() crash us
   https://patchwork.kernel.org/patch/10401993/

I also needed a few patches that haven't yet posted to-list to keep things
from crashing at boot (these patches weren't needed when using Coreboot as
the BIOS):

1. arm64: dts: sdm845: Enable smmu support
   https://chromium.googlesource.com/chromiumos/third_party/kernel/+/8046f638b4
2. HACK: iommu/arm-smmu: make a mismatch in CBs and CB interrupts non-fatal
   https://chromium.googlesource.com/chromiumos/third_party/kernel/+/8c0b634f48

Given the above caveats these three patches are probably not quite ready for
landing, but I wanted to at least get them out there to start the review
process.


Douglas Anderson (2):
  arm64: dts: qcom: sdm845-mtp: Add RPMh VRM/XOB regulators
  arm64: dts: qcom: sdm845-mtp: Add nodes for USB

Manu Gautam (1):
  arm64: dts: qcom: sdm845: Add USB-related nodes

 arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 507 ++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi    | 189 +++++++++
 2 files changed, 696 insertions(+)

-- 
2.18.0.203.gfac676dfb9-goog
