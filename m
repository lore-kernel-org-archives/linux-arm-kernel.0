From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Wed, 30 Sep 2015 15:25:48 +0800
Subject: [PATCH v2 0/2] Add support to make output voltage determined by
 VSET2[] bits
Message-ID: <1443597950-27849-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch is to add support to make the output voltage of ACT8865
DC/DC regulator determined by VSET2[] bits. The DT property
"active-semi,vsel-high" is used to specify the VSEL pin at high
on the board. When the VSEL pin is high, output voltage is programmed
by VSET2[] bits.

Changes in v2:
 - fix missed argument of macro "ACT88xx_REG" for act8865_alt_regulators
   structure variable.
 - set variable "voltage_select" initial value to avoid compile warning.

Wenyou Yang (2):
  regulator: act8865: support output voltage by VSET2[] bits
  regulator: act8865: add DT binding for property
    "active-semi,vsel-high"

 .../bindings/regulator/act8865-regulator.txt       |    3 +++
 drivers/regulator/act8865-regulator.c              |   24 ++++++++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

-- 
1.7.9.5
