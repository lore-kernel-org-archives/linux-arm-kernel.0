Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5556C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 19:21:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 912C32082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 19:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mvefJSjE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 912C32082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=W8Sl3QxVYFtQAnIlzhF2oxZFBiMvee9UyRNNcdIQlG0=; b=mvefJSjE0+58QN
	csvDye8KHWmxocjByh9949cLB1EB/L1eTBfJzYswxg2I80BY2Bk7KrNG6W792zUt6reFcvIlv6cGl
	uR4jjWbrgj7uCRveRolx4AUE9xZIUm8bmurf40hXOhMZRYVVsNNdFHqqhYhxygqYIQVeL7tUgTwmj
	+PBQlLeVmkZ0d3WPhJYmiO1OBxxclmmnLp3xbsVq+aojo8w+J1tlpFUkqesusj+zgYY/0hvHUKHhw
	0QPkYbA0D6fx0it/kyG8tNvskz5gymP+1d09Isn1a9OEifHPdn5QZcrqjrfEhcNYKmVPivddIbWHg
	Q/lARKDKTmeE0WKCn64A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTApO-0001U5-S5; Sat, 01 Dec 2018 19:21:22 +0000
Received: from mail5.windriver.com ([192.103.53.11] helo=mail5.wrs.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTApM-0001TQ-3s; Sat, 01 Dec 2018 19:21:21 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
 [147.11.189.40])
 by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id wB1JJh9V005396
 (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
 Sat, 1 Dec 2018 11:19:53 -0800
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Sat, 1 Dec 2018
 11:19:32 -0800
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 2/9] iommu/rockchip: Make it explicitly non-modular
Date: Sat, 1 Dec 2018 14:19:10 -0500
Message-ID: <1543691957-17608-3-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543691957-17608-1-git-send-email-paul.gortmaker@windriver.com>
References: <1543691957-17608-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181201_112120_176131_51B555C2 
X-CRM114-Status: GOOD (  15.84  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Simon Xue <xxm@rock-chips.com>, linux-rockchip@lists.infradead.org,
 Jeffy Chen <jeffy.chen@rock-chips.com>, linux-kernel@vger.kernel.org,
 Daniel Kurtz <djkurtz@chromium.org>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The Kconfig currently controlling compilation of this code is:

drivers/iommu/Kconfig:config ROCKCHIP_IOMMU
drivers/iommu/Kconfig:  bool "Rockchip IOMMU Support"

...meaning that it currently is not being built as a module by anyone.

The bind/unbind/remove was already explicitly disabled in commit
98b72b94def9 ("iommu/rockchip: Prohibit unbind and remove").

Lets remove the remaining traces of  modular infrastructure, so that
when reading the driver there is no doubt it is builtin-only.

Since module_init was not in use by this code, the init ordering
remains unchanged with this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
was (or is now) contained at the top of the file in the comments.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Simon Xue <xxm@rock-chips.com>
Cc: Daniel Kurtz <djkurtz@chromium.org>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Acked-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/iommu/rockchip-iommu.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index ad3e2b97469e..c9ba9f377f63 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1,4 +1,9 @@
 /*
+ * IOMMU API for Rockchip
+ *
+ * Module Authors:	Simon Xue <xxm@rock-chips.com>
+ *			Daniel Kurtz <djkurtz@chromium.org>
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -17,7 +22,7 @@
 #include <linux/iopoll.h>
 #include <linux/list.h>
 #include <linux/mm.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/of.h>
 #include <linux/of_iommu.h>
 #include <linux/of_platform.h>
@@ -1281,7 +1286,6 @@ static const struct of_device_id rk_iommu_dt_ids[] = {
 	{ .compatible = "rockchip,iommu" },
 	{ /* sentinel */ }
 };
-MODULE_DEVICE_TABLE(of, rk_iommu_dt_ids);
 
 static struct platform_driver rk_iommu_driver = {
 	.probe = rk_iommu_probe,
@@ -1299,8 +1303,3 @@ static int __init rk_iommu_init(void)
 	return platform_driver_register(&rk_iommu_driver);
 }
 subsys_initcall(rk_iommu_init);
-
-MODULE_DESCRIPTION("IOMMU API for Rockchip");
-MODULE_AUTHOR("Simon Xue <xxm@rock-chips.com> and Daniel Kurtz <djkurtz@chromium.org>");
-MODULE_ALIAS("platform:rockchip-iommu");
-MODULE_LICENSE("GPL v2");
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
