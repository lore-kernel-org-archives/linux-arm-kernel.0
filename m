Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72913C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:08:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 446E2214AE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p3mO8sqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 446E2214AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eDeJFM0yCgpcuic/FHx9kyo+2w8ADbHCp0S4cTva1vA=; b=p3mO8sqKfmoFL8
	hR98qIlO8YsX1l/ZQznaMe8xvxw6htMxwb1K0MHI/vqls7169XfDIO+VFV2BZ4dmv3MTYu68BdqMe
	n1x7JZo4kC5Hcz4KtcCPhl+RlP3K/AWYXrtwifZgbbdGkBFSzHKk2j1TCuDOjvXaPs91DJFQ8JfzX
	3rSJkVMLSXT8phxc3zYPsU8LDdA9WY1CBAnC0qlzeZz/TbWokPTnx5J6A03vYMV7lH4JFYp++6CwM
	buwuM/5O641Gl3N+tcSefUaFUp3NwrCLQ3rUBRKhIH1RZFwDgnl8bVGo3+JtWOPVKSMiT8ANhvwWj
	CEUoOVbV2YrLIxmcU9WQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggRpx-0006j2-N2; Mon, 07 Jan 2019 10:08:49 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggRpM-0006Ch-8p
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 10:08:17 +0000
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x07A4mRI019386; Mon, 7 Jan 2019 11:07:59 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2ptt11qy11-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Mon, 07 Jan 2019 11:07:59 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B246E3A;
 Mon,  7 Jan 2019 10:07:58 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8831D2A00;
 Mon,  7 Jan 2019 10:07:58 +0000 (GMT)
Received: from localhost (10.75.127.45) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2;
 Mon, 7 Jan 2019 11:07:57 +0100
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <lee.jones@linaro.org>, <alexandre.torgue@st.com>
Subject: [RESEND PATCH v2 2/3] mfd: syscon: Add optional clock support
Date: Mon, 7 Jan 2019 11:07:44 +0100
Message-ID: <1546855665-26218-3-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546855665-26218-1-git-send-email-fabrice.gasnier@st.com>
References: <1546855665-26218-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-07_04:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_020814_969530_0E0D9E18 
X-CRM114-Status: GOOD (  11.94  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, arnd@arndb.de,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 robh+dt@kernel.org, mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com,
 gabriel.fernandez@st.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Some system control registers need to be clocked, so the registers can
be accessed. Add an optional clock and attach it to regmap.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/mfd/syscon.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index b6d05cd..a0ba4ff 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -12,6 +12,7 @@
  * (at your option) any later version.
  */
 
+#include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/hwspinlock.h>
 #include <linux/io.h>
@@ -45,6 +46,7 @@ struct syscon {
 
 static struct syscon *of_syscon_register(struct device_node *np)
 {
+	struct clk *clk;
 	struct syscon *syscon;
 	struct regmap *regmap;
 	void __iomem *base;
@@ -119,6 +121,18 @@ static struct syscon *of_syscon_register(struct device_node *np)
 		goto err_regmap;
 	}
 
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		/* clock is optional */
+		if (ret != -ENOENT)
+			goto err_clk;
+	} else {
+		ret = regmap_mmio_attach_clk(regmap, clk);
+		if (ret)
+			goto err_attach;
+	}
+
 	syscon->regmap = regmap;
 	syscon->np = np;
 
@@ -128,6 +142,11 @@ static struct syscon *of_syscon_register(struct device_node *np)
 
 	return syscon;
 
+err_attach:
+	if (!IS_ERR(clk))
+		clk_put(clk);
+err_clk:
+	regmap_exit(regmap);
 err_regmap:
 	iounmap(base);
 err_map:
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
