From: pawel.mikolaj.chmiel@gmail.com (=?UTF-8?q?Pawe=C5=82=20Chmiel?=)
Date: Tue, 31 Jul 2018 17:18:08 +0200
Subject: [PATCH v3 0/3] Input: atmel_mxt_ts: Add support for optional
 regulators
Message-ID: <1533050291-11502-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds optional regulator support to atmel_mxt_ts.
First patch adds regulators to driver.
Second patch ensures that device is ready for communication.
Third patch updates documentation.

Changes from v2:
  - Add reviewed-by to one patch
  - Move code for enabling regulators into separate method,
    to make code more readable.
  - Add wait code, to ensure that device is ready for communication.

Changes from v1:
  - Enable regulators only if reset_gpio is present.
  - Switch from devm_regulator_get_optional to devm_regulator_get.

Pawe? Chmiel (3):
  Input: atmel_mxt_ts: Add support for  optional regulators.
  Input: atmel_mxt_ts: Wait for device be ready for communication
  Input: atmel_mxt_ts: Document optional voltage regulators

 .../devicetree/bindings/input/atmel,maxtouch.txt   |  8 +++
 drivers/input/touchscreen/atmel_mxt_ts.c           | 76 ++++++++++++++++++++--
 2 files changed, 78 insertions(+), 6 deletions(-)

-- 
2.7.4
