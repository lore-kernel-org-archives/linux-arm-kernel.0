Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9F8C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:35:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0242820892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Uj+P6a6x";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="h1dBloT4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0242820892
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=940AiZkgCsHMTRDDYe8IyjC4n459+N8Xnba+PJQ5w/0=; b=Uj+P6a6x/ta/33
	5sOvYmi25+bni2a2ZTecV9ObnwA6cjSYZ4Y8SzZuRLzjONscg3g4mdrwiZ1kT5b4b4HigyVNPstUb
	OjB0iVaOz9/VW5FKIpXLn5/3CkAvqPIPOmf+MCPTG8Jg9L32sToi65G1hHar/hgvziKorUwS4UxYY
	KXtzsj7eEsmt1vIXmad2LvM8DOs+EDPLEGjasyH4VKZlzzONOL+hssXYg1uuO9d3AGmt1UimCeWQi
	zzB+30mViTVlRMnf16oK+LGJkngDwNJdv3FVtBKavxqMfIQCumpui9k4jtIcJlyG2XkG+/5ubie9m
	jztku9wFiivTpQl2co0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVCXl-000395-D7; Fri, 07 Dec 2018 09:35:33 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVCXC-0001Q4-Mf
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 09:35:30 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB79Yk0Y068412;
 Fri, 7 Dec 2018 03:34:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1544175286;
 bh=0uu4d1fl6OhSoVn5C1riTCMiDdjaCQIua6SRoTOrIhk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=h1dBloT4c/hUT3oeu7RjUIAGxn0JdbrHMVEvpWgveUMGAG0MPYA529WSCMWr1b71b
 JFIoWWj/sp7/lvCHujpepp6HP5nNO26+7eDuJpWSmwTJky75GE+TXU/ofTGb1DsPrt
 rHTrO2GAY/GUNviaKMDl2FBmqB7JFjOqcSkgMxHs=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB79Ykaa032495
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 7 Dec 2018 03:34:46 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 7
 Dec 2018 03:34:45 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 7 Dec 2018 03:34:45 -0600
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB79Ycw8011818;
 Fri, 7 Dec 2018 03:34:43 -0600
From: Vignesh R <vigneshr@ti.com>
To: Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 2/2] arm64: dts: ti: k3-am654-base-board: Enable ECAP PWM
Date: Fri, 7 Dec 2018 15:05:35 +0530
Message-ID: <20181207093535.5497-3-vigneshr@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181207093535.5497-1-vigneshr@ti.com>
References: <20181207093535.5497-1-vigneshr@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_013459_365452_A502806D 
X-CRM114-Status: GOOD (  12.47  )
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
Cc: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Vignesh R <vigneshr@ti.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Enable ECAP PWM which is used for LCD backlight.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index bd5a0069191d..49ec2c3f5ef1 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -76,6 +76,12 @@
 			AM65X_IOPAD(0x000c, PIN_INPUT, 0) /* (E21) I2C1_SDA */
 		>;
 	};
+
+	ecap0_pins_default: ecap0-pins-default {
+		pinctrl-single,pins = <
+			AM65X_IOPAD(0x0010, PIN_INPUT, 0) /* (D21) ECAP0_IN_APWM_OUT */
+		>;
+	};
 };
 
 &wkup_uart0 {
@@ -125,3 +131,8 @@
 	pinctrl-0 = <&main_i2c2_pins_default>;
 	clock-frequency = <400000>;
 };
+
+&ecap0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ecap0_pins_default>;
+};
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
