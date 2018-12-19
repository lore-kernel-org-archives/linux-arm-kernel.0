Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523A0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:11:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2144B21871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TMAabSXB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="O1HlDlRZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2144B21871
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=2mQ5c4Of5l6e7lg09xdevUNHiFAZ+xVXRmYUexwve5c=; b=TMAabSXBtb3lrk
	/cbTYWXizFPaFeDkxZETRV2EoKES6wDfzVgAD9SEpWLNG07e9GXjn2gN/cnZgpmMRT/kL7q+PCBEF
	DttKqk3MTqhV/CEGPgREjET+KrHZzajXfvaiAqo2e4pHEA3EqKQiM4FN3n0bqm8TKdgRXRFJFJGrD
	d1ENpoPvwmlAQZ0IwyC6wZTk9re4k7cRuaddy9VR4bfEnyQZwEIHWHwo6YXbIVleUTMq+MocBwU9C
	PrISKcPnpA4djg+31qVG+x1vO7ToGcXF8/vdya3G02pyME4Qyfx80kc7lckC7Px4YuOTmOTjU4GVb
	6vKqU3+l8EERhB7yvI7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZYpN-0008Oe-2o; Wed, 19 Dec 2018 10:11:45 +0000
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZYpJ-0008NV-Md
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 10:11:43 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBJABMm2089599;
 Wed, 19 Dec 2018 04:11:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1545214282;
 bh=FT8vmqAs6IRlmx+c+T3AdN+h1ix4Rc2XFjv+OlTJ/qk=;
 h=From:To:CC:Subject:Date;
 b=O1HlDlRZqn/ZHXEo7J4zOc/6aOtXn829ETmLsjbajzMlFlbMdU6qrmgkWJTn4b+ZZ
 Y0ESaEmKYNR0pWzjNyhL5d32auc+Ta6m/d8+nKOMsu96wtVW+iQLk6Xja8bWvqr54R
 ehXt9Q4kHRTuW2DeCh5sqJ5w/qe75uZohF/9OaCE=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBJABM3m035617
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 19 Dec 2018 04:11:22 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 19
 Dec 2018 04:11:21 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 19 Dec 2018 04:11:21 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBJABJP3007197;
 Wed, 19 Dec 2018 04:11:20 -0600
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
To: <tony@atomide.com>, <linux@armlinux.org.uk>, <nsekhar@ti.com>
Subject: [PATCH] ARM: dts: da850-lcdk: Correct the audio codec regulators
Date: Wed, 19 Dec 2018 12:13:05 +0200
Message-ID: <20181219101305.20832-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_021141_836183_E273EDEB 
X-CRM114-Status: GOOD (  14.33  )
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
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, bcousson@baylibre.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add the board level fixed regulators for 3.3V and 1.8V which is used to
power - among other things - the tlv320aic3106 codec.

Apart from removing the following warning during boot:
tlv320aic3x-codec 0-0018: Invalid supply voltage(s) AVDD: -22, DVDD: -22

With the correct voltages the driver can select correct OCMV value to
reduce pop noise.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/da850-lcdk.dts | 36 ++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index 0177e3ed20fe..c196e37606c4 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -39,6 +39,36 @@
 		};
 	};
 
+	vcc_5vd: fixedregulator-vcc_5vd {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_5vd";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+	};
+
+	vcc_3v3d: fixedregulator-vcc_3v3d {
+		/* TPS650250 - VDCDC1 */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_3v3d";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_5vd>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vcc_1v8d: fixedregulator-vcc_1v8d {
+		/* TPS650250 - VDCDC2 */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_1v8d";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_5vd>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	sound {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "DA850/OMAP-L138 LCDK";
@@ -221,6 +251,12 @@
 		compatible = "ti,tlv320aic3106";
 		reg = <0x18>;
 		status = "okay";
+
+		/* Regulators */
+		IOVDD-supply = <&vcc_3v3d>;
+		AVDD-supply = <&vcc_3v3d>;
+		DRVDD-supply = <&vcc_3v3d>;
+		DVDD-supply = <&vcc_1v8d>;
 	};
 };
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
