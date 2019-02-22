Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AE5C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:29:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14C4420700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rSBGasKf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14C4420700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sfWeLrPX9q4fH5mHWWz7oteUTP7Q+aXvbWD4DKL7bfQ=; b=rSBGasKfRqENds
	Cra9ByqFIaLI0087EtmTFoOAHaKZhlIW63pAjUtWzBvwsbFrrofHwKDsYlXUgmn2fvnS1pN8iE7ME
	JA8cl1o7XiZU8V3EGMFgBhdB4wFOKig7hO0Gso2cXc80AAoGp/iMpL7LhHhzbCE53SKMOi6w5klNI
	P7IygHp/HTx0VfFqJfCZMhz43jW9xhY8ldTg0xk+Ypd8RMomtiWDzC/VcosIEmkRqz3MwBlkKttTE
	ruzzCfsxcRfwdBD29jJjrAibgptwHQTkQWUuYMAje5Sqzpx+dwIBj8c+3dA8dbWu9CJlTOMzGYPrT
	53zjeVidzNkJCKnsd5xQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx6DB-0005li-3Y; Fri, 22 Feb 2019 08:29:37 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx6CH-0004jW-BC
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 08:28:44 +0000
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1M8LCTe006458; Fri, 22 Feb 2019 09:28:30 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2qr6x63prn-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Fri, 22 Feb 2019 09:28:30 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1DCE631;
 Fri, 22 Feb 2019 08:28:27 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id ED4BB28AB;
 Fri, 22 Feb 2019 08:28:26 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 22 Feb
 2019 09:28:26 +0100
Received: from localhost (10.201.23.166) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 22 Feb 2019 09:28:26
 +0100
From: Christophe Roullier <christophe.roullier@st.com>
To: <robh@kernel.org>, <davem@davemloft.net>, <joabreu@synopsys.com>,
 <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
 <alexandre.torgue@st.com>, <peppe.cavallaro@st.com>
Subject: [PATCH V2 1/8] net: ethernet: stmmac: manage Ethernet WoL for
 stm32mp157c.
Date: Fri, 22 Feb 2019 09:28:02 +0100
Message-ID: <1550824089-19961-2-git-send-email-christophe.roullier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550824089-19961-1-git-send-email-christophe.roullier@st.com>
References: <1550824089-19961-1-git-send-email-christophe.roullier@st.com>
MIME-Version: 1.0
X-Originating-IP: [10.201.23.166]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-22_06:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_002841_704902_1F2D42D7 
X-CRM114-Status: GOOD (  13.94  )
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

Add glue codes to support magic packet on stm32mp157c

Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c | 30 ++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index 7e2e79d..d1cf145 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -42,6 +42,7 @@ struct stm32_dwmac {
 	struct clk *clk_ethstp;
 	struct clk *syscfg_clk;
 	bool int_phyclk;	/* Clock from RCC to drive PHY */
+	int irq_pwr_wakeup;
 	u32 mode_reg;		/* MAC glue-logic mode register */
 	struct regmap *regmap;
 	u32 speed;
@@ -232,7 +233,9 @@ static int stm32_dwmac_parse_data(struct stm32_dwmac *dwmac,
 static int stm32mp1_parse_data(struct stm32_dwmac *dwmac,
 			       struct device *dev)
 {
+	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *np = dev->of_node;
+	int err = 0;
 
 	dwmac->int_phyclk = of_property_read_bool(np, "st,int-phyclk");
 
@@ -260,7 +263,26 @@ static int stm32mp1_parse_data(struct stm32_dwmac *dwmac,
 		return PTR_ERR(dwmac->syscfg_clk);
 	}
 
-	return 0;
+	/* Get IRQ information early to have an ability to ask for deferred
+	 * probe if needed before we went too far with resource allocation.
+	 */
+	dwmac->irq_pwr_wakeup = platform_get_irq_byname(pdev,
+							"stm32_pwr_wakeup");
+	if (!dwmac->int_phyclk && dwmac->irq_pwr_wakeup >= 0) {
+		err = device_init_wakeup(&pdev->dev, true);
+		if (err) {
+			dev_err(&pdev->dev, "Failed to init wake up irq\n");
+			return err;
+		}
+		err = dev_pm_set_dedicated_wake_irq(&pdev->dev,
+						    dwmac->irq_pwr_wakeup);
+		if (err) {
+			dev_err(&pdev->dev, "Failed to set wake up irq\n");
+			device_init_wakeup(&pdev->dev, false);
+		}
+		device_set_wakeup_enable(&pdev->dev, false);
+	}
+	return err;
 }
 
 static int stm32_dwmac_probe(struct platform_device *pdev)
@@ -326,9 +348,15 @@ static int stm32_dwmac_remove(struct platform_device *pdev)
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct stmmac_priv *priv = netdev_priv(ndev);
 	int ret = stmmac_dvr_remove(&pdev->dev);
+	struct stm32_dwmac *dwmac = priv->plat->bsp_priv;
 
 	stm32_dwmac_clk_disable(priv->plat->bsp_priv);
 
+	if (dwmac->irq_pwr_wakeup >= 0) {
+		dev_pm_clear_wake_irq(&pdev->dev);
+		device_init_wakeup(&pdev->dev, false);
+	}
+
 	return ret;
 }
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
