From: thomas.ab@samsung.com (Thomas Abraham)
Date: Fri, 30 May 2014 14:31:15 +0530
Subject: [PATCH v6 0/2] cpufreq: opp: Add device tree based lookup of boost
 mode frequency
Message-ID: <1401440477-4328-1-git-send-email-thomas.ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v5:
- Fixes for checkpatch warnings with --strict option as suggested by
  Nishanth Menon.

Changes since v4:
- Code improvements suggested by Viresh Kumar.

Changes since v3:
- Minor changes as suggested in the last version.

Changes since v2:
- Reworked based on the "PM / OPP: move cpufreq specific helpers out of OPP 
  layer" patch series posted by Nishanth Menon.

Changes since v1:
- Boost mode frequencies are specfied as a set of frequencies instead of
  specifying them as OPPs. Thanks to Nishanth, Lukasz and Rob for the
  feedback.

This series has been acked by authors and maintainers of the code
portions changed in this series. The new DT binding introduced in this
patch needs an ack from device tree binding maintainers as well.

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
