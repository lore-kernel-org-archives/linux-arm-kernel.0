From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 25 Nov 2015 14:27:35 -0800
Subject: [PATCH 0/2] qcom: Remove size elements from pmic reg properties
Message-ID: <1448490457-9799-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches remove the size elements from the pmic reg properties.
Technically they shouldn't be there because size-cells is 0 for the
parent node, but we've put them there so that MPP and gpio drivers
can figure out how many gpios there are.

So once the gpio and mpp drivers are fixed to count the irqs instead
of look at this reg property, we can apply this patch to remove the size
elements and be DT compliant. That would be a complicated cross-merge
between pinctrl and arm-soc trees though, so perhaps this series should
wait until the two trees meet in v4.5?

Stephen Boyd (2):
  ARM: dts: qcom: Remove size elements from pmic reg properties
  ARM64: dts: qcom: Remove size elements from pmic reg properties

 arch/arm/boot/dts/qcom-pm8841.dtsi   |  4 ++--
 arch/arm/boot/dts/qcom-pm8941.dtsi   | 22 +++++++++++-----------
 arch/arm64/boot/dts/qcom/pm8916.dtsi | 10 +++++-----
 3 files changed, 18 insertions(+), 18 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
