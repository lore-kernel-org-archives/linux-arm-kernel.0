Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84699C43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:14:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F2E420868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MrkmPvpl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PRGIF0So"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F2E420868
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+xJ070XbGb+3UgvuEcHHleMuSQIyb9kTGa+vzpMdYuU=; b=MrkmPvplFF2slM
	riy6Q5VWHunvTjyN/YcQxBI9lVdtnjHPbUlAUhKf7BI7UpJqnH6gsCg8J8DzuaO2Ii6/bvry4gxqw
	a1CSqSkWBJ13qZuWKkoBAdTZgngWkOWKh1O8XNvCghUaT+TvwDR3MhBrzeeLTXPFYQppbFf+EIihA
	4b7QaVqF3uEsszqaSWjPGUBNjkMSFRPM7QcJpkMzNvVx5atPrQGk2aySEoLLl2SdjnHG4jUwP9YoK
	PY05TwgBbXzcbdWE9HeuuqnuM5XpVt0sI92PdD6R/pgoXddbtHeKUXycctqvlJyuEvpBPvLi3RyIx
	6SRdgQRtzEQDUUZAwnAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSOx4-0006sc-GC; Thu, 29 Nov 2018 16:14:06 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSOw2-0005q5-7g
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 16:13:06 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wATGCbTb100640;
 Thu, 29 Nov 2018 10:12:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1543507957;
 bh=0yRXmnEkROLYOSjml1UMGjpoq5LT5a/vpAZ8G2JIsUk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=PRGIF0SoKxahCjuiGRZqsZssO/bjNAZPAHdgmGXinIgB7Wtm9kOMqK+kQTWtvyfOP
 xXWlOrF4ecWr109aEin/VA+Z/1/HlLQeHvU5YeXHJRlHjfCZl/hJ2pIIU7ojbGZYsY
 ztJi0g01AtQe7LVgsVKs9f0LtgDprKBrjY25W5HU=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wATGCbk7025567
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 29 Nov 2018 10:12:37 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 29
 Nov 2018 10:12:36 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 29 Nov 2018 10:12:36 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wATGCQL5019470;
 Thu, 29 Nov 2018 10:12:33 -0600
From: Faiz Abbas <faiz_abbas@ti.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-mmc@vger.kernel.org>
Subject: [PATCH 2/3] dt-bindings: mmc: sdhci-of-arasan: Add deprecated message
 for am654
Date: Thu, 29 Nov 2018 21:45:12 +0530
Message-ID: <20181129161513.31734-3-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129161513.31734-1-faiz_abbas@ti.com>
References: <20181129161513.31734-1-faiz_abbas@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_081303_270003_7257103D 
X-CRM114-Status: GOOD (  12.58  )
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
Cc: mark.rutland@arm.com, ulf.hansson@linaro.org, adrian.hunter@intel.com,
 kishon@ti.com, robh+dt@kernel.org, faiz_abbas@ti.com, michal.simek@xilinx.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The "ti,am654-sdhci-5.1" binding has been moved to a new driver. Indicate
this by a deprecated message.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index e2effe17f05e..1edbb049cccb 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -16,6 +16,10 @@ Required Properties:
     - "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1": rk3399 eMMC PHY
       For this device it is strongly suggested to include arasan,soc-ctl-syscon.
     - "ti,am654-sdhci-5.1", "arasan,sdhci-5.1": TI AM654 MMC PHY
+	Note: This binding has been deprecated and moved to [5].
+
+  [5] Documentation/devicetree/bindings/mmc/sdhci-am654.txt
+
   - reg: From mmc bindings: Register location and length.
   - clocks: From clock bindings: Handles to clock inputs.
   - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
