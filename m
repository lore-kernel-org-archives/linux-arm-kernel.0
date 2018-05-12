From: collinsd@codeaurora.org (David Collins)
Date: Fri, 11 May 2018 18:46:45 -0700
Subject: [PATCH 0/2] regulator: of: add device tree property for allowed modes
Message-ID: <cover.1526088289.git.collinsd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is currently no accepted way to configure constraints->valid_modes_mask
for regulators defined in device tree.  This patch series defines a new
common regulator device tree property, regulator-allowed-modes, which can be
used to specify the set of modes that the regulator is allowed to use.
It also implements parsing for this new property inside of the
of_get_regulation_constraints() function.

David Collins (2):
  regulator: of: add property for allowed modes specification
  regulator: of: add support for allowed modes configuration

 .../devicetree/bindings/regulator/regulator.txt    |  5 ++++
 drivers/regulator/of_regulator.c                   | 29 +++++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
