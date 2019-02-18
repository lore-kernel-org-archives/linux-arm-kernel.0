Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D06C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:36:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8553721736
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VouRJgyF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Nbxphg+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8553721736
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LRhLxk3I8JMiR/v2/gl6tNjdEmDVuTzXOWB5jS1yw4k=; b=VouRJgyFtehp6g
	xLLnn6g4OqzFSGXXey52m6nAlBW4i6gMaoRbzGWxBIE/g51/4UI9IUdsAMtCbEZnrpCciTIjZUM5I
	rxCOE6RYHmR7Y/YKb2ep2yxMvTdDDdKEBBo11/0apCvmgp8uSw1FwBmMFHSchsE2rMuubc7DbDTki
	ui+jwa1XCPEUPXgWQllJWSMxIYNV2jiBQOgUohVTCBQVKj1YeQXemKPafqqvfnmlqpuI7WPR4IAdm
	DmdHCMgcCEn5GKrtaFmD0iUVG1zP0vo4WCxvnL0YjdbiRXeJtxqbzQh2r+6okqgTs6+ZVTkLLhxA9
	ukLuht1tvPEClodBzBsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvk2A-0007tQ-4A; Mon, 18 Feb 2019 14:36:38 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvk1n-0007UZ-PI
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 14:36:18 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1IEaBNe033713;
 Mon, 18 Feb 2019 08:36:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550500571;
 bh=71ad6NV5r4gK+glhhefF5UsV6TojoM15BZIc0koOcyE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Nbxphg+MdwTFdFkxwPsuCVY5o3kaEKTS+Vk7pv58ZCGkG9EH+YxS0JXY+QFBHT8z8
 cTi81FPDH+kJOqk4cgjoEzcUQTJrwORK5IPt273at8C/C+wkXDBiwHLlr8FWNj0M9m
 nw+KkEgBu5/XOxfX0AKyGYWkualZ3MS+GAztBjzc=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1IEaAMU056722
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 18 Feb 2019 08:36:11 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 18
 Feb 2019 08:36:10 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 18 Feb 2019 08:36:10 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1IEa1ds009865;
 Mon, 18 Feb 2019 08:36:07 -0600
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
To: <tony@atomide.com>
Subject: [PATCH 2/2] ARM: dts: am335x-evm: Fix PHY mode for ethernet
Date: Mon, 18 Feb 2019 16:36:29 +0200
Message-ID: <20190218143629.28392-3-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218143629.28392-1-peter.ujfalusi@ti.com>
References: <20190218143629.28392-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_063616_051569_1F6D6585 
X-CRM114-Status: GOOD (  16.62  )
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
Cc: devicetree@vger.kernel.org, grygorii.strashko@ti.com,
 marc.w.gonzalez@free.fr, netdev@vger.kernel.org, nsekhar@ti.com,
 vkoul@kernel.org, f.fainelli@gmail.com, bcousson@baylibre.com,
 niklas.cassel@linaro.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The PHY must add both tx and rx delay and not only on the tx clock.
The board uses AR8031_AL1A PHY where the rx delay is enabled by default,
the tx dealy is disabled.

The reason why rgmii-txid worked because the rx delay was not disabled by
the driver so essentially we ended up with rgmii-id PHY mode.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index b67f5fee1469..dce5be5df97b 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -729,7 +729,7 @@
 
 &cpsw_emac0 {
 	phy-handle = <&ethphy0>;
-	phy-mode = "rgmii-txid";
+	phy-mode = "rgmii-id";
 };
 
 &tscadc {
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
