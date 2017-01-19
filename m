From: code@mmayer.net (Markus Mayer)
Date: Wed, 18 Jan 2017 16:29:31 -0800
Subject: [PATCH v5 0/2] cpufreq: brcmstb-cpufreq: CPUfreq driver for older
 Broadcom STB SoCs
Message-ID: <20170119002933.7529-1-code@mmayer.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Mayer <mmayer@broadcom.com>

This CPUfreq driver provides basic frequency scaling for older Broadcom
STB SoCs that do not use AVS firmware with DVFS support. There is no
support for voltage scaling.

v4 of this patch can be found at: https://patchwork.kernel.org/patch/9482357/

Changes since v4:
  - Simplified (and hopefully clarified) binding document
  - No code changes

v3 of this patch can be found at: https://lkml.org/lkml/2016/11/22/747

Changes since v3:
  - added binding document
  - got rid of calls to __clk_lookup(), using devm_clk_get() instead
  - re-worked clock lookup code a bit, along with switching to devm_clk_get()
  - get_frequencies() became a void function, removing the need for some
    error checking
  - fixed CONFIG_ARM_BRCM_AVS_CPUFREQ typo
  - fixed MODULE_DEVICE_TABLE declaration

Markus Mayer (2):
  dt-bindings: brcm: clocks: add binding for brcmstb-cpu-clk-div
  cpufreq: brcmstb-cpufreq: CPUfreq driver for older Broadcom STB SoCs

 .../bindings/clock/brcm,brcmstb-cpu-clk-div.txt    |  27 ++
 MAINTAINERS                                        |   1 +
 drivers/cpufreq/Kconfig.arm                        |  12 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/brcmstb-cpufreq.c                  | 377 +++++++++++++++++++++
 5 files changed, 418 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/brcm,brcmstb-cpu-clk-div.txt
 create mode 100644 drivers/cpufreq/brcmstb-cpufreq.c

-- 
2.7.4
