From: lho@apm.com (Loc Ho)
Date: Tue, 19 Jan 2016 17:46:49 -0700
Subject: [PATCH v2 0/3] edac: xgene: Add missing SoC register bus error
 handling and fix CE promotes to UE
Message-ID: <1453250812-15097-1-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing register bus error handling for SoC and fix an checking
condition for CE error promotes to UE. DT binding and documentation are
also updated.

v2:
* Make the register bus resource optional
* Update DT binding accordinlgy

---
Loc Ho (3):
  Documentation: Update the APM X-Gene SoC EDAC DTS binding for missing
    RB
  edac: xgene: Add missing SoC register bus error handling and fix CE
    promotes to UE
  arm64: Update the APM X-Gene EDAC node with the RB register resource

 .../devicetree/bindings/edac/apm-xgene-edac.txt    |   12 ++++
 arch/arm64/boot/dts/apm/apm-storm.dtsi             |    6 ++
 drivers/edac/xgene_edac.c                          |   70 +++++++++++++++++++-
 3 files changed, 87 insertions(+), 1 deletions(-)
