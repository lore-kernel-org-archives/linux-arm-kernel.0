Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE8BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:48:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D36A222A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hicEabCe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D36A222A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PD8xlCVVpvm1yjdS8Jc+yNFCPrWc1sAdSTnIhtrc4Z0=; b=hicEabCe9kO5c0
	XF0mi2k4AJBfZ+6S/p+1l2n1Yde17Zo80Bxi2CYBFVqvCtAtAmoRODgKgsEI8LEcHCZx5ATTpwNmf
	u1Ghel0UMPEcqJVlEiYX97T7ZVPfSWfYsn0GgDFj7R1/vwgmK3b6oYlVl6ZOF25oOEFQOnP8VeFF8
	jDaxeyvrQByqJOltw9QLW5fOdOvJid0k+8Z5+7/MSLFzWz3UE6GUP5kcxi48HcjEwbFEVdN8jA0q9
	N20wffoyppAmIGFOVZUIF1aUE4Lbdx4XrfHJ5DgfUmsYmwsTH9zYpbw1PnnGhInWo/sqNCUvirAYs
	vr7X3dPqP82m7kC/A5Rg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guAoh-0002kM-Cm; Thu, 14 Feb 2019 06:48:15 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guAnS-0001Nj-A7
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 06:47:04 +0000
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1E6a4Qv025842; Thu, 14 Feb 2019 07:46:50 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2qmy1n94aj-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Thu, 14 Feb 2019 07:46:49 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 446B131;
 Thu, 14 Feb 2019 06:46:49 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 222EF2431;
 Thu, 14 Feb 2019 06:46:49 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 14 Feb
 2019 07:46:48 +0100
Received: from localhost (10.201.23.166) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 14 Feb 2019 07:46:48
 +0100
From: Christophe Roullier <christophe.roullier@st.com>
To: <robh@kernel.org>, <davem@davemloft.net>, <joabreu@synopsys.com>,
 <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
 <alexandre.torgue@st.com>, <peppe.cavallaro@st.com>
Subject: [PATCH 5/8] net: ethernet: stmmac: update to be compatible with MCU
 family (stm32f4, stm32h7)
Date: Thu, 14 Feb 2019 07:46:00 +0100
Message-ID: <1550126763-22669-6-git-send-email-christophe.roullier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550126763-22669-1-git-send-email-christophe.roullier@st.com>
References: <1550126763-22669-1-git-send-email-christophe.roullier@st.com>
MIME-Version: 1.0
X-Originating-IP: [10.201.23.166]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-14_04:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_224658_654238_FD3BF933 
X-CRM114-Status: GOOD (  15.18  )
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
Cc: devicetree@vger.kernel.org, andrew@lunn.ch, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 christophe.roullier@st.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Update glue codes to be compatible with MCU family.

Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c | 51 ++++++++++++++++++-----
 1 file changed, 41 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index cee59e8..20a2daa 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -6,7 +6,6 @@
  * License terms:  GNU General Public License (GPL), version 2
  *
  */
-
 #include <linux/clk.h>
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
@@ -119,12 +118,6 @@ static int stm32_dwmac_init(struct plat_stmmacenet_data *plat_dat)
 	struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
 	int ret;
 
-	if (dwmac->ops->set_mode) {
-		ret = dwmac->ops->set_mode(plat_dat);
-		if (ret)
-			return ret;
-	}
-
 	ret = clk_prepare_enable(dwmac->clk_tx);
 	if (ret)
 		return ret;
@@ -139,13 +132,26 @@ static int stm32_dwmac_init(struct plat_stmmacenet_data *plat_dat)
 
 	if (dwmac->ops->clk_prepare) {
 		ret = dwmac->ops->clk_prepare(dwmac, true);
+		if (ret)
+			goto err_clk_disable;
+	}
+
+	if (dwmac->ops->set_mode) {
+		ret = dwmac->ops->set_mode(plat_dat);
 		if (ret) {
-			clk_disable_unprepare(dwmac->clk_rx);
-			clk_disable_unprepare(dwmac->clk_tx);
+			if (dwmac->ops->clk_prepare)
+				dwmac->ops->clk_prepare(dwmac, false);
+			goto err_clk_disable;
 		}
 	}
 
 	return ret;
+
+err_clk_disable:
+	clk_disable_unprepare(dwmac->clk_rx);
+	clk_disable_unprepare(dwmac->clk_tx);
+
+	return ret;
 }
 
 static int stm32mp1_clk_prepare(struct stm32_dwmac *dwmac, bool prepare)
@@ -240,7 +246,19 @@ static int stm32mcu_set_mode(struct plat_stmmacenet_data *plat_dat)
 	}
 
 	return regmap_update_bits(dwmac->regmap, reg,
-				 dwmac->ops->syscfg_eth_mask, val);
+				 dwmac->ops->syscfg_eth_mask, val << 23);
+}
+
+static int stm32mcu_clk_prepare(struct stm32_dwmac *dwmac, bool prepare)
+{
+	int ret = 0;
+
+	if (prepare)
+		ret = clk_prepare_enable(dwmac->syscfg_clk);
+	else
+		clk_disable_unprepare(dwmac->syscfg_clk);
+
+	return ret;
 }
 
 static void stm32_dwmac_clk_disable(struct stm32_dwmac *dwmac)
@@ -347,6 +365,17 @@ static int stm32mp1_parse_data(struct stm32_dwmac *dwmac,
 	return err;
 }
 
+static int stm32mcu_parse_data(struct stm32_dwmac *dwmac,
+			       struct device *dev)
+{
+	/*  Clock for sysconfig */
+	dwmac->syscfg_clk = devm_clk_get(dev, "syscfg-clk");
+	if (IS_ERR(dwmac->syscfg_clk))
+		dev_warn(dev, "No syscfg clock provided...\n");
+
+	return 0;
+}
+
 static int stm32_dwmac_probe(struct platform_device *pdev)
 {
 	struct plat_stmmacenet_data *plat_dat;
@@ -493,7 +522,9 @@ static SIMPLE_DEV_PM_OPS(stm32_dwmac_pm_ops,
 
 static struct stm32_ops stm32mcu_dwmac_data = {
 	.set_mode = stm32mcu_set_mode,
+	.clk_prepare = stm32mcu_clk_prepare,
 	.suspend = stm32mcu_suspend,
+	.parse_data = stm32mcu_parse_data,
 	.syscfg_eth_mask = SYSCFG_MCU_ETH_MASK
 };
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
