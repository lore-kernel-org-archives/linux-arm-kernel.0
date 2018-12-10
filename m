Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6696EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:41:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37E1020855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OXtggA09";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.com header.i=@fb.com header.b="YF3Q5GwI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37E1020855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=mxGg74ZATwH67qfU8KvtXf5nrfxT9rMiijx7BLnbI3A=; b=OXtggA093xlzGK
	QHNp7YbPPTCg2hr868e6Fril+s6lfaBiyCDd2HS53wUiEyfypgS3DoY6egXVsKqHiJfO/0b9WimEc
	NoRkUMemcE6Z6thbxyZcXbZCowpn0amFkaav//7fVMmtwMu2PKpC2tB1izssKT5c/K0o/w0gUY0iw
	VAJ8xVMwXlpI4d+fGd3cbdD55Jv6F4HTIi9N/qst3AnXf/UYIki/8RFonfvX1MkE6K/xEVgqNkSS7
	DQRsPzSObLQpp50vA0nNupOh3ukkWFs4Ca+nmqkxRrqiZvqI5B0Bnl+9+xPt8vaSWPPYBoxT3Snjj
	6uIEKyy2R0SqEh/of6RQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWUFK-0005Mh-AC; Mon, 10 Dec 2018 22:41:50 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]
 helo=mx0a-00082601.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWUFH-0005Lb-5L
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 22:41:48 +0000
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
 by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 wBAMb6cg025955
 for <linux-arm-kernel@lists.infradead.org>; Mon, 10 Dec 2018 14:41:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=dLElzSdHMTcAhV0wX0WRVUowNerbbcAl+7NItdgtBSM=;
 b=YF3Q5GwIJ0cZJe+sTvbOZ/E/OgibWAvxX6FgtUqsVVZQ6U3yDDXpyP9o7qFeBH8KNnY7
 trNP80lLNoAL7mxxjQCuaJ1KsigAlWDfGULu0wuE18EawSz61bsODF4b/9UE/W3g9GnO
 Ul6IpKGi8jzw9GSx4eZ/G5NDsESKCBfg2sI= 
Received: from mail.thefacebook.com ([199.201.64.23])
 by mx0b-00082601.pphosted.com with ESMTP id 2p9wbygy0a-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
 for <linux-arm-kernel@lists.infradead.org>; Mon, 10 Dec 2018 14:41:35 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Mon, 10 Dec 2018 14:41:32 -0800
Received: by devvm4117.prn2.facebook.com (Postfix, from userid 167582)
 id 532D54BEC11A; Mon, 10 Dec 2018 14:41:27 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From: Vijay Khemka <vijaykhemka@fb.com>
Smtp-Origin-Hostname: devvm4117.prn2.facebook.com
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH] ARM: dts: aspeed: Add sensors devices for Facebook
Date: Mon, 10 Dec 2018 14:41:16 -0800
Message-ID: <20181210224116.3396252-1-vijaykhemka@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-10_08:, , signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_144147_393672_0AE0BCAB 
X-CRM114-Status: GOOD (  14.62  )
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
Cc: "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>,
 vijaykhemka@fb.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Added ADC and other sensor devices in Facebook Tiogapass device tree.

Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
---
 .../dts/aspeed-bmc-facebook-tiogapass.dts     | 33 +++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
index f8e7b71af7e6..d9d7f208788a 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
@@ -21,6 +21,25 @@
 	memory@80000000 {
 		reg = <0x80000000 0x20000000>;
 	};
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		oemname0 = "MB_P3V3";
+		oemname1 = "MB_P5V";
+		oemname2 = "MB_P12V";
+		oemname3 = "MB_P1V05";
+		oemname4 = "MB_PVNN_PCH_STBY";
+		oemname5 = "MB_P3V3_STBY";
+		oemname6 = "MB_P5V_STBY";
+		io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>,
+					<&adc 4>, <&adc 5>, <&adc 6>;
+	};
+
+	iio-hwmon-battery {
+		oemname0 = "MB_P3V_BAT";
+		compatible = "iio-hwmon";
+		io-channels = <&adc 7>;
+	};
+
 };
 
 &fmc {
@@ -64,6 +83,10 @@
 	use-ncsi;
 };
 
+&adc {
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 	//Airmax Conn B, CPU0 PIROM, CPU1 PIROM
@@ -122,6 +145,10 @@
 
 &i2c8 {
 	status = "okay";
+	tmp421@1f {
+		compatible = "ti,tmp421";
+		reg = <0x1f>;
+	};
 	//Mezz Sensor SMBus
 };
 
@@ -134,13 +161,15 @@
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm0_default &pinctrl_pwm1_default>;
+	oemname0 = "System_Fan_Connector_1";
+	oemname1 = "System_Fan_Connector_3";
 	fan@0 {
 		reg = <0x00>;
 		aspeed,fan-tach-ch = /bits/ 8 <0x00>;
 	};
 
 	fan@1 {
-		reg = <0x00>;
-		aspeed,fan-tach-ch = /bits/ 8 <0x01>;
+		reg = <0x01>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x02>;
 	};
 };
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
