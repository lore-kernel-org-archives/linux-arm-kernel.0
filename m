Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555E3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:46:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16CEC21850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RVYKYvs9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="t5v/oqTP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16CEC21850
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2mQ5c4Of5l6e7lg09xdevUNHiFAZ+xVXRmYUexwve5c=; b=RVYKYvs9Sl/dvX
	eotHvgQFy0c9LPxEIWG2Chp4pkO5dPB8ODPlrYbknXncH6YOlnWKaViB8avPgb7rYO8Y4ynWlLeyN
	DzoQRaWIqM/dMFRIwNbaTleZcj89fIa4scT9SKMqH0a4T5pKU+oHmCAzntB7blbVQkt4P9Nf/fAkV
	62wbVAH1nxbdfNYqAar+fJKqNsnMf7HUroc+YHqhMIPZknr/Difk1JArAZ+3YcGJz0zpIIas54w0S
	dMvUSrwhZSBZwu0jPdLLpjzMnIxyocuzWofpL0vOOKQFpYq5EPbCmqEiuijyRVMqEJgJ3tMYIU3l0
	euhN5nbUroGLJnqH4IqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZaIa-00014i-DT; Wed, 19 Dec 2018 11:46:00 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZaIV-00010c-3O
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 11:45:57 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBJBjlMm103982;
 Wed, 19 Dec 2018 05:45:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1545219947;
 bh=FT8vmqAs6IRlmx+c+T3AdN+h1ix4Rc2XFjv+OlTJ/qk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=t5v/oqTPQIn9L8GEqGC7M44i0Fh3ghamhiyz/XcSG5YiX/axfoHQSRb0upfchEBBU
 f3cA453ckZr7Dr7GXS9xtf8VdXcGt2JWrQP16LS8JqeU4jJ4SI7tt+8LcCJZRUuddv
 b9N3UjVq/K6xB2rjxblLTyKR0xTrs7hUw3Sc6yyE=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBJBjljk008694
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 19 Dec 2018 05:45:47 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 19
 Dec 2018 05:45:47 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 19 Dec 2018 05:45:46 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBJBjfoe011774;
 Wed, 19 Dec 2018 05:45:46 -0600
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
To: <nsekhar@ti.com>
Subject: [PATCH v2 3/5] ARM: dts: da850-lcdk: Correct the audio codec
 regulators
Date: Wed, 19 Dec 2018 13:47:25 +0200
Message-ID: <20181219114727.6865-4-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181219114727.6865-1-peter.ujfalusi@ti.com>
References: <20181219114727.6865-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_034555_223461_F7435980 
X-CRM114-Status: GOOD (  16.79  )
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
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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
