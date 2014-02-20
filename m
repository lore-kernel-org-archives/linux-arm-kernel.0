From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 20 Feb 2014 12:07:50 +0100
Subject: [PATCH v2 0/2] regulator: core: Fix ops->enable/disable usage
Message-ID: <1392894472-11956-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These two patches replace all ops->enable/disable by
_regulator_do_disable/enable function calls. These wrappers also handle gpio
regulators.

v2 enables all regulators with delays and I added a patch to fix all direct
disable calls.

Regards,

Markus


Markus Pargmann (2):
  regulator: core: Replace direct ops->enable usage
  regulator: core: Replace direct ops->disable usage

 drivers/regulator/core.c | 44 +++++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

-- 
1.8.5.3
