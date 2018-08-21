From: nhillery@codeaurora.org (Nathan Hillery)
Date: Tue, 21 Aug 2018 17:44:57 -0400
Subject: [RFC, V5,
 0/4] arm_pmu: acpi: variant support and QCOM Falkor extensions
Message-ID: <1534887901-24734-1-git-send-email-nhillery@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is a complete re-design of V1 of the QCOM Falkor extensions [1],
it introduces a probe table based on the HID of a device nested under the CPU
device to allow variant detection and arm_pmu customization.

The first patch adds an additional section at the end of each ACPI probe table.
This allows probe tables to be sentinel-delimited and better accommodate some
APIs that require such tables.

The second patch adds the PMUv3 ACPI probe table and plumbing to allow drivers
to plug into the ACPI PMUv3 probe sequence.

The third patch adds the PC capture extension applicable to Falkor and Saphira
CPUs. This shows how an extension that uses sampling events hooks. A similar
approach can be used to add RBB support and populate the sample branch stack
from it.

The fourth patch adds the matrix-based events extension applicable to Falkor
only.

If this found to be a reasonable extension approach other patches will be
added to the series to build on the base QCOM extensions.

[1] https://lkml.org/lkml/2017/3/1/540

Changes since V4:
- Address V4 comments, to keep all extension attributes in config2

Changes since V3:
- Add PC capture support as first extension. Add matrix-based events on top.

Changes since V2:
- Address V2 comments, which resulted in removing all uses of the PMU lock.

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
