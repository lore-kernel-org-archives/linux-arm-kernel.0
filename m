From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 20 Feb 2014 17:36:02 +0100
Subject: [PATCH v3 0/2] regulator: core: Fix ops->enable/disable usage
Message-ID: <1392914164-28596-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These two patches replace all ops->enable/disable by
_regulator_do_disable/enable function calls. These wrappers also handle gpio
regulators.

v3 adds a comment about the moved _notifier_call_chain() function calls and
removes a unused variable from the core driver in patch 2
(Replace direct ops->disable usage).

Regards,

Markus


Markus Pargmann (2):
  regulator: core: Replace direct ops->enable usage
  regulator: core: Replace direct ops->disable usage

 drivers/regulator/core.c | 46 +++++++++++++++++++---------------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

-- 
1.8.5.3
