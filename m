From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 11 Jul 2016 14:50:06 -0700
Subject: [PATCH 0/3] Fixes for RPM SMD regulator voltage ranges
Message-ID: <20160711215009.4519-1-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The voltage ranges listed in the RPM SMD regulator driver
aren't correct. This series makes the voltage range tables
match what the hardware supports. That fixes a problem
where pm8941 l24 fails to be set at 3.075V when the hardware
really supports it.

Stephen Boyd (3):
  regulator: qcom_smd: Fix voltage ranges for pm8x41
  regulator: qcom_smd: Fix voltage ranges for pma8084 ftsmps and pldo
  regulator: qcom_smd: Avoid overlapping linear voltage ranges

 drivers/regulator/qcom_smd-regulator.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
