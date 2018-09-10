From: victor.chong@linaro.org (Victor Chong)
Date: Mon, 10 Sep 2018 17:57:28 +0900
Subject: Fwd: [PATCH] tee: optee: log message if dynamic shm is enabled
In-Reply-To: <CAHqM-Qgy7zPjrnNm0Xdyz_F_BYbSPgDfQrkv0tGv_rB1G7tSXg@mail.gmail.com>
References: <CAHqM-Qgy7zPjrnNm0Xdyz_F_BYbSPgDfQrkv0tGv_rB1G7tSXg@mail.gmail.com>
Message-ID: <CAHqM-QgH3d3Fz=P-_Gj_ZJODK1YOxT49G=qhzAnM=g2HAYqoow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suggested-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Victor Chong <victor.chong@linaro.org>
Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 drivers/tee/optee/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index e1aafe842d66..cca5c091e55a 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -631,6 +631,9 @@ static struct optee *optee_probe(struct device_node *np)

        optee_enable_shm_cache(optee);

+       if (optee->sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
+               pr_info("dynamic shared memory is enabled\n");
+
        pr_info("initialized driver\n");
        return optee;
 err:
--
2.17.1
