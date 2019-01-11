Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639FDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:01:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FA3720872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WDwbSDZI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="K4N1N4jP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA3720872
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OzKSr1GxM553M+NH/dg+fNOLpJ50Eq1w/TQCMue9bT8=; b=WDwbSDZIH5kwXG
	S0GKe9aZZxQwPoyttF3ZpoRpK/gdqrNRWfwH14WCO1NArsgADkR3NHCDftsXIF/Oj2UpnKRzPCdW6
	Zt/kvdxZcmPpqRvimljMSDXLq3UkRi8a4ibQ+GJdX4O4dM/pwM/3135/YzJ/ChjabJJstCK14vmQQ
	0cYIKNBLU7ohjvdpLGYafGJBtfrVDF43Zp1xu1SoFcwUVOZWEkGFM90q4HUMAdAesinJumtmWCZpR
	5VRz4VJtuQnyCH4lwb7g4RD0MAU2sybhLFzp4xIIYFceWr52Aob4Erv0lQhFBg7wP2B/taMDBVwTn
	vRpEEIdpMFm5TudeemyA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghtcy-0005Nf-Ut; Fri, 11 Jan 2019 10:01:24 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghtcj-00058z-AL
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 10:01:15 +0000
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0BA18Jq055904;
 Fri, 11 Jan 2019 04:01:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1547200868;
 bh=hR7aBYiYLXUXdct3RfBW8Jva6fSLcv83qdouzD6o9as=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=K4N1N4jP0TerRIm1wgc3eNXiFBi2YEQT98S7uhQ3TFNaC7ji5Vqx5zwNRk/sqMB/G
 buLjCNzd7L+UUakrvfWlh2mdPln3QofHVX8xVY0XOelk202HXyY8SKBwUuVI/kKw8+
 PbbjjRTvZWhV1DYcBSvZpKkRzQja6fvoOKqCndZE=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0BA180C038148
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 11 Jan 2019 04:01:08 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 11
 Jan 2019 04:01:07 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 11 Jan 2019 04:01:07 -0600
Received: from localhost.localdomain (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0BA12Xa015629;
 Fri, 11 Jan 2019 04:01:05 -0600
From: Roger Quadros <rogerq@ti.com>
To: <t-kristo@ti.com>
Subject: [PATCH 1/3] arm64: dts: ti: am654: Add Main System Control Module node
Date: Fri, 11 Jan 2019 12:00:59 +0200
Message-ID: <1547200861-17795-2-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547200861-17795-1-git-send-email-rogerq@ti.com>
References: <1547200861-17795-1-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_020109_392755_86FC2AC6 
X-CRM114-Status: GOOD (  12.81  )
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
Cc: nm@ti.com, devicetree@vger.kernel.org, vigneshr@ti.com, nsekhar@ti.com,
 linux-kernel@vger.kernel.org, Jyri Sarha <jsarha@ti.com>,
 linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Jyri Sarha <jsarha@ti.com>

Main System control module support is added to the device tree to allow
driver to access to their control module registers.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 272cf8f..8b55108 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -191,4 +191,12 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
+
+	scm_conf: scm_conf@100000 {
+		compatible = "syscon", "simple-mfd";
+		reg = <0 0x00100000 0 0x1c000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x00100000 0x1c000>;
+	};
 };
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
