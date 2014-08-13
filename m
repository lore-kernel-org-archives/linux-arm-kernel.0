From: fkan@apm.com (Feng Kan)
Date: Wed, 13 Aug 2014 11:32:08 -0700
Subject: [PATCH Resend v2 0/2] arm64: Add PMU node for APM X-Gene Storm SoC
Message-ID: <1407954730-9768-1-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds PMU node for APM X-Gene's Potenza CPU.
Potenza CPU PMU is compatible with ARMv8-PMUv3.

I am resending this patch since the original author has left the company and
I am taking over for the work. There is no change to the original patch.

Just a comment on the dependency on the second part of the patch. Though I
agree that without the GIC patch, perf utility does not function correctly on
our current platform. However, it also requires the correct bootloader to be
installed to perform the correct actions. This does not break Linux, which
lead me to remove the statement in the previous attempt. I have since put
back the statement and hope that the maintainer would provide some guidance
on if the patch would be postponed because the dependancy.

Feng Kan (2):
  dt-bindings: Add Potenza PMU binding
  arm64: dts: Add PMU node for APM X-Gene Storm SOC

 Documentation/devicetree/bindings/arm/pmu.txt | 1 +
 arch/arm64/boot/dts/apm-storm.dtsi            | 5 +++++
 2 files changed, 6 insertions(+)

-- 
1.9.1
