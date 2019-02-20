Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E8DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:27:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0150720880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BDMgS1hc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UPbq++Dz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0150720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cDBoEs3bqy1MQmcQaUTNyV9sjGgvmgo2JyQ4RkLuNpk=; b=BDMgS1hcVF9dcU
	lPCuHzf2b9FiNjk6kcpzFlLuW87OY4aG8nDoIfKF4oJjSKsaGgmG3NwivBydpfOFDR5/jWg/npBKM
	4IB10m+gnYw1kBbUvotOeoavyATc1DzW/aoUkqdnFIOlenKa07SqUcV1GjFZQJ3CtUTZl//8VspFW
	1IqSnaXPLP4qoJYOs3xh5xbMtoFuqXLU7qRYbys6CVgIab6tqTRKN6S7IPOBsotkv21jH4HFnw60X
	qd/5gKlC5kdgRCsyvKU98/xQvA+90wwLOvqj6oKIwGsCHdVnPz1zajMzW3/k8ZwUMe6FouXJbqzbe
	sbHy82dwJXnKU73osSfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwTmK-0001J0-Sv; Wed, 20 Feb 2019 15:27:20 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwTlC-0008Hi-Q9
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 15:26:13 +0000
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1KFQ7P3127287;
 Wed, 20 Feb 2019 09:26:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550676367;
 bh=ZFTu1cJyEVVxnhkDc9dv5bVTCgTlym42DjxwxaOL2Fg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=UPbq++DzvRcg8D1oGK5QsVVe5YKVOcEX1VOS2aG7hZcfvlBuugiWz8W196ZEC1DsG
 9i5cyJsB+Av8liaReXVyaAofNa+awjNt4l0HecLH84Bf48X1x9239JRyjp5iye7AOn
 8y/cNiPArrS/3Lr2lzjwxGCwo09AdvKoJKj2yLgg=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1KFQ75q115746
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 20 Feb 2019 09:26:07 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 20
 Feb 2019 09:26:07 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 20 Feb 2019 09:26:07 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1KFQ6tU009828;
 Wed, 20 Feb 2019 09:26:06 -0600
From: Grygorii Strashko <grygorii.strashko@ti.com>
To: "David S. Miller" <davem@davemloft.net>, Kishon Vijay Abraham I
 <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren
 <tony@atomide.com>
Subject: [PATCH 6/6] net: ethernet: ti: cpsw: deprecate cpsw-phy-sel driver
Date: Wed, 20 Feb 2019 17:25:19 +0200
Message-ID: <1550676319-6440-7-git-send-email-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550676319-6440-1-git-send-email-grygorii.strashko@ti.com>
References: <1550676319-6440-1-git-send-email-grygorii.strashko@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_072610_957457_344CEF38 
X-CRM114-Status: GOOD (  14.79  )
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
Cc: devicetree@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>,
 netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Deprecate cpsw-phy-sel driver as it's been replaced with new
TI phy-gmii-sel PHY driver.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/Kconfig | 6 +++---
 drivers/net/ethernet/ti/cpsw.h  | 6 ++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index bb126be1eb72..8b21b40a9fe5 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -49,10 +49,11 @@ config TI_DAVINCI_CPDMA
 	  will be called davinci_cpdma.  This is recommended.
 
 config TI_CPSW_PHY_SEL
-	bool
+	bool "TI CPSW Phy mode Selection (DEPRECATED)"
+	default n
 	---help---
 	  This driver supports configuring of the phy mode connected to
-	  the CPSW.
+	  the CPSW. DEPRECATED: use PHY_TI_GMII_SEL.
 
 config TI_CPSW_ALE
 	tristate "TI CPSW ALE Support"
@@ -64,7 +65,6 @@ config TI_CPSW
 	depends on ARCH_DAVINCI || ARCH_OMAP2PLUS || COMPILE_TEST
 	select TI_DAVINCI_CPDMA
 	select TI_DAVINCI_MDIO
-	select TI_CPSW_PHY_SEL
 	select TI_CPSW_ALE
 	select MFD_SYSCON
 	select REGMAP
diff --git a/drivers/net/ethernet/ti/cpsw.h b/drivers/net/ethernet/ti/cpsw.h
index cf111db3dc27..907e05fc22e4 100644
--- a/drivers/net/ethernet/ti/cpsw.h
+++ b/drivers/net/ethernet/ti/cpsw.h
@@ -21,7 +21,13 @@
 			 ((mac)[2] << 16) | ((mac)[3] << 24))
 #define mac_lo(mac)	(((mac)[4] << 0) | ((mac)[5] << 8))
 
+#if IS_ENABLED(CONFIG_TI_CPSW_PHY_SEL)
 void cpsw_phy_sel(struct device *dev, phy_interface_t phy_mode, int slave);
+#else
+static inline
+void cpsw_phy_sel(struct device *dev, phy_interface_t phy_mode, int slave)
+{}
+#endif
 int ti_cm_get_macid(struct device *dev, int slave, u8 *mac_addr);
 
 #endif /* __CPSW_H__ */
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
