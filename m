Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A09CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:05:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3262720874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kbJP4FUC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.com header.i=@fb.com header.b="abqWKZiy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3262720874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=e2d4rwbEbzlI39BktVw+mx4aLCbw5H24gCGTvFubdvs=; b=kbJP4FUCw0T7Qp
	wHCmzfAopqZI55lCKfUMrnwkE5rwIVNFVByo+gFVddzUl0FFS8BoKqz+p5YzQBlMpYj+nY3aGCT7L
	5VBH3SOfkmApSwB9zi/d6lXAFlGkegQ4isZ5vJiRCm78wPhVEN5JrDIk/FVyI70LP04xRvAG1CpUy
	Re6Ih3u3N0gkjbBHcH65aI1KGROmLRvP/LHGWp9dMJNxeB6aanX4FohhbF1Xaez1hd4PdotqOqaHd
	Vx9AV1wRbpy5htpjAPt1tidC2rn8njRpmiSdzne4Fx2MSslWuoeDZTldQjYULM7ZVtZOf3g0yIFUu
	qk+omjF8DYL+s90Jds7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYz8h-0000Nh-2U; Mon, 17 Dec 2018 20:05:19 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYz84-0007GI-S5
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 20:04:42 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 wBHJxddo006564
 for <linux-arm-kernel@lists.infradead.org>; Mon, 17 Dec 2018 12:04:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=yvw7AtsoTE2YxwaSB255LKOsEJAqEUpaPlkV5KitJaI=;
 b=abqWKZiyvRWmJV+mYnqF9DMTB4BEWivM4MRCipft315mPlZ9KFNJWpPDA+pw4DWJb3FA
 zIOsMRFq9sI0M0YHgj3SoS4bqnLGm/Ypo7mRpx075KzZXkvpoYAoDtcfPA4GDPYJygkP
 qg8u6DPqLFmYn+bTD7fZxWX3ojmPUYtpM1U= 
Received: from maileast.thefacebook.com ([199.201.65.23])
 by mx0a-00082601.pphosted.com with ESMTP id 2pegmwrh06-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
 for <linux-arm-kernel@lists.infradead.org>; Mon, 17 Dec 2018 12:04:29 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Mon, 17 Dec 2018 12:04:19 -0800
Received: by devvm4117.prn2.facebook.com (Postfix, from userid 167582)
 id 094BD57DAE11; Mon, 17 Dec 2018 12:04:17 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From: Vijay Khemka <vijaykhemka@fb.com>
Smtp-Origin-Hostname: devvm4117.prn2.facebook.com
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2 4/4] ARM: dts: aspeed: Add lpc ctrl for Facebook
Date: Mon, 17 Dec 2018 12:04:05 -0800
Message-ID: <20181217200405.2904551-4-vijaykhemka@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181217200405.2904551-1-vijaykhemka@fb.com>
References: <20181217200405.2904551-1-vijaykhemka@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-17_07:, , signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_120441_015758_AC986859 
X-CRM114-Status: GOOD (  13.83  )
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

Added lpc ctrl device to enable LPC clock in Facebook
Tiogapass device tree.

Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
---
 .../boot/dts/aspeed-bmc-facebook-tiogapass.dts  | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
index 73e58a821613..ef7875b54562 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
@@ -22,6 +22,17 @@
 		reg = <0x80000000 0x20000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		flash_memory: region@98000000 {
+			no-map;
+			reg = <0x98000000 0x00001000>; /* 4K */
+		};
+	};
+
 	iio-hwmon {
 		compatible = "iio-hwmon";
 		io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>,
@@ -54,6 +65,12 @@
 	};
 };
 
+&lpc_ctrl {
+	status = "okay";
+	memory-region = <&flash_memory>;
+	flash = <&spi1>;
+};
+
 &uart1 {
 	// Host Console
 	status = "okay";
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
