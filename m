From: thomas.ab@samsung.com (Thomas Abraham)
Date: Thu, 29 May 2014 20:08:37 +0530
Subject: [PATCH v5 0/2] cpufreq: opp: Add device tree based lookup of boost
 mode frequency
Message-ID: <1401374319-4480-1-git-send-email-thomas.ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v5:
- Code improvements suggested by Viresh Kumar.

Changes since v4:
- Includes cleanup changes suggested by Viresh Kumar.

Changes since v3:
- Minor changes as suggested in the last version.

Changes since v2:
- Reworked based on the "PM / OPP: move cpufreq specific helpers out of OPP 
  layer" patch series posted by Nishanth Menon <n...@ti.com>.

Changes since v1:
- Boost mode frequencies are specfied as a set of frequencies instead of
  specifying them as OPPs. Thanks to Nishanth, Lukasz and Rob for the
  feedback.

Commit 6f19efc0 ("cpufreq: Add boost frequency support in core") adds
support for CPU boost mode for CPUfreq drivers. To use the new boost
mode, CPUfreq drivers have to specify the boost mode frequency and
voltage within the CPUfreq driver, which is the case for Exynos4x12
CPUfreq driver.

But for CPUfreq drivers which obtain the OPPs from cpus node, this
patch series adds support to specify boost mode frequencies in the
cpu device tree node. This requirement came up when Lukasz pointed
out the regression caused by the Exynos CPUfreq driver consolidation
patches.
