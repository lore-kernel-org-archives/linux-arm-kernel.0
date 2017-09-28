From: volodymyr_babchuk@epam.com (Volodymyr Babchuk)
Date: Thu, 28 Sep 2017 21:04:07 +0300
Subject: [PATCH v1 10/14] tee: optee: store OP-TEE capabilities in private data
In-Reply-To: <1506621851-6929-1-git-send-email-volodymyr_babchuk@epam.com>
References: <1506621851-6929-1-git-send-email-volodymyr_babchuk@epam.com>
Message-ID: <1506621851-6929-11-git-send-email-volodymyr_babchuk@epam.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Volodymyr Babchuk <vlad.babchuk@gmail.com>

Those capabilities will be used in subsequent patches.

Signed-off-by: Volodymyr Babchuk <vlad.babchuk@gmail.com>
---
 drivers/tee/optee/core.c          | 1 +
 drivers/tee/optee/optee_private.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 9883592..8e012ea 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -553,6 +553,7 @@ static struct optee *optee_probe(struct device_node *np)
 	}
 
 	optee->invoke_fn = invoke_fn;
+	optee->sec_caps = sec_caps;
 
 	teedev = tee_device_alloc(&optee_desc, NULL, pool, optee);
 	if (IS_ERR(teedev)) {
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index dfe1158..fc534d7 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -96,6 +96,8 @@ struct optee_supp {
  * @supp:		supplicant synchronization struct for RPC to supplicant
  * @pool:		shared memory pool
  * @memremaped_shm	virtual address of memory in shared memory pool
+ * @sec_caps:		secure world capabilities defined by
+ *			OPTEE_SMC_SEC_CAP_* in optee_smc.h
  */
 struct optee {
 	struct tee_device *supp_teedev;
@@ -106,6 +108,7 @@ struct optee {
 	struct optee_supp supp;
 	struct tee_shm_pool *pool;
 	void *memremaped_shm;
+	u32 sec_caps;
 };
 
 struct optee_session {
-- 
2.7.4
