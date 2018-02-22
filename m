From: lkp@intel.com (kbuild test robot)
Date: Thu, 22 Feb 2018 15:01:11 +0800
Subject: [RFC PATCH] drivers/peci: peci_match_id() can be static
In-Reply-To: <20180221161606.32247-2-jae.hyun.yoo@linux.intel.com>
References: <20180221161606.32247-2-jae.hyun.yoo@linux.intel.com>
Message-ID: <20180222070111.GA22310@lkp-ne02>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Fixes: 99f5d2b99ecd ("drivers/peci: Add support for PECI bus driver core")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 peci-core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/peci/peci-core.c b/drivers/peci/peci-core.c
index d976c73..4709b8c 100644
--- a/drivers/peci/peci-core.c
+++ b/drivers/peci/peci-core.c
@@ -770,8 +770,8 @@ peci_of_match_device(const struct of_device_id *matches,
 }
 #endif
 
-const struct peci_device_id *peci_match_id(const struct peci_device_id *id,
-					   struct peci_client *client)
+static const struct peci_device_id *peci_match_id(const struct peci_device_id *id,
+						  struct peci_client *client)
 {
 	if (!(id && client))
 		return NULL;
