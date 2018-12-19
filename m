Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E56C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:49:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00C5E2184A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RkM/5/si";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yF81ag7a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C5E2184A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+H1UcJh5F6Oih3doLKESnh2A/O1r6TUzvuShPkjigpc=; b=RkM/5/sii0Je7y
	cZ2LPrLq5S+qCUuiqz6RFmkeydrNtRSDUvyHI5AWtgjBHVRCBW6dr+UjkjIqRnYl3d8L+2rdUYxfm
	srMAzrAnZK5T/H/1QYovT5tTMlR34OnefRMVk5dMbaaCiApCcYa7LvtoD5tgCTLKbHH4U1wUNPwoe
	UGxvqiiaZxOAnW9b5D8WrljdTpzafmLPBK+Y0Zwu9zMZU0mL/tQ/M+ZpObr+g9TAelc2/vc4FyDo5
	ADrOuRa63zDw8RvTlsYwz3o2xPRElrD9kV/yW2KSuw8QHfb1Ount5ewraZ50s92hjIoej9S137Vgi
	mZ5f/0K++at5NLeUK6fw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZaM9-0003Dq-SE; Wed, 19 Dec 2018 11:49:41 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZaIV-0000xv-3P
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 11:45:57 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBJBjipV103951;
 Wed, 19 Dec 2018 05:45:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1545219944;
 bh=a290USImfl2H34AX+n1zCTJXPI09gyEpOUEA/xKqOhg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=yF81ag7aWZxL43wIeKLpbHzOdH/GgnwCPNqeIOsOpo/CS5RpYkUU44fl6o4WaYxvQ
 KDBRJwDECvCk/F/CyOkNlPIU/JqYp815apJW6eDePJhyQj0O5zS8XQoeVN4PmEJz4g
 RcKy+5Jw0QQWO9J4NFhIG5UkZYGKkcxajryIo6MY=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBJBji47117147
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 19 Dec 2018 05:45:44 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 19
 Dec 2018 05:45:44 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 19 Dec 2018 05:45:44 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBJBjfoc011774;
 Wed, 19 Dec 2018 05:45:43 -0600
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
To: <nsekhar@ti.com>
Subject: [PATCH v2 1/5] ARM: dts: da850-evm: Correct the audio codec regulators
Date: Wed, 19 Dec 2018 13:47:23 +0200
Message-ID: <20181219114727.6865-2-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181219114727.6865-1-peter.ujfalusi@ti.com>
References: <20181219114727.6865-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_034555_233976_3BABE0D5 
X-CRM114-Status: GOOD (  17.24  )
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
tlv320aic3x-codec 0-0018: Too high supply voltage(s) AVDD: 5000000, DVDD: 5000000

With the correct voltages the driver can select correct OCMV value to
reduce pop noise.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/da850-evm.dts | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index f9a5a8212c84..997bede2a48f 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -94,6 +94,28 @@
 		regulator-boot-on;
 	};
 
+	baseboard_3v3: fixedregulator-3v3 {
+		/* TPS73701DCQ */
+		compatible = "regulator-fixed";
+		regulator-name = "baseboard_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vbat>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	baseboard_1v8: fixedregulator-1v8 {
+		/* TPS73701DCQ */
+		compatible = "regulator-fixed";
+		regulator-name = "baseboard_1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vbat>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	backlight_lcd: backlight-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "lcd_backlight_pwr";
@@ -210,10 +232,9 @@
 
 		/* Regulators */
 		IOVDD-supply = <&vdcdc2_reg>;
-		/* Derived from VBAT: Baseboard 3.3V / 1.8V */
-		AVDD-supply = <&vbat>;
-		DRVDD-supply = <&vbat>;
-		DVDD-supply = <&vbat>;
+		AVDD-supply = <&baseboard_3v3>;
+		DRVDD-supply = <&baseboard_3v3>;
+		DVDD-supply = <&baseboard_1v8>;
 	};
 	tca6416: gpio@20 {
 		compatible = "ti,tca6416";
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
