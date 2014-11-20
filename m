From: joshc@codeaurora.org (Josh Cartwright)
Date: Thu, 20 Nov 2014 13:41:22 -0600
Subject: [PATCH 0/3] qcom_rpm: add support for IPQ8064 resources
Message-ID: <1416512485-7292-1-git-send-email-joshc@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IPQ8064 SoC has several Resource Power Manager (RPM) controlled resources:
four regulators (two SMB208s, each controlling two regulators) and two fabric
clocks for the Network Subsystem (NSS).  This patchset adds the appropriate
definitions for these resources, and extends the existing RPM regulator driver
to support the SMB208.

This patchset is based ontop of v7 of Bjorne Andersson's RPM patchset [1].

1: http://lkml.kernel.org/r/1411428329-23172-1-git-send-email-bjorn.andersson at sonymobile.com

Josh Cartwright (3):
  mfd: devicetree: qcom_rpm: document IPQ8064 resources
  mfd: qcom_rpm: add support for IPQ8064
  regulator: rpm: add support for RPM-controller SMB208

 Documentation/devicetree/bindings/mfd/qcom-rpm.txt |  6 +++-
 drivers/mfd/qcom_rpm.c                             | 41 ++++++++++++++++++++++
 drivers/regulator/qcom_rpm-regulator.c             | 19 ++++++++++
 include/dt-bindings/mfd/qcom-rpm.h                 |  6 ++++
 4 files changed, 71 insertions(+), 1 deletion(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
