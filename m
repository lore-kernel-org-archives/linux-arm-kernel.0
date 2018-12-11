Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F17C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:03:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D33E2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ehuf80LC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.com header.i=@fb.com header.b="h3vc+ZHe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D33E2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Sqdd6Sc+2FfBQia98QjogAK4SoTHzdE+Wa0Suhp7Ccw=; b=ehuf80LCx4wcYp
	iXHwellkMMtLepovQ5H4+vE3Ubp5wEgdsGBeYDxh1Z5fPTlQU13+HR0oLje5J5oSo/yD9HutOG7pL
	BbMqeVrbV8NbUmOPiHaOLB1SXiiIjHTyo3y2iIeyZ1V/gERm9b3a36LGzctaLDOyKczy9pWhpXqb6
	x+LA71EehsOt0M6cNRkq8WSU6t0DMg0sPPb5Y42WZVax2WAPePsZHx4IiqZavIYCSyA5Tyr8Z5ZoH
	3KO9qsSbh17hOL/ClwrPzj2D/I78m3kIRrVabZ5UYm4LqajBi2EGPVVkuilvG8eNYCo09pHxSbzQl
	OEQHG0CBmR/Q0IyTWxSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWnJm-0004lf-4v; Tue, 11 Dec 2018 19:03:42 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]
 helo=mx0a-00082601.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWnJi-0004d6-ME
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 19:03:40 +0000
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
 by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 wBBJ2Q3f029453
 for <linux-arm-kernel@lists.infradead.org>; Tue, 11 Dec 2018 11:03:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=giQhL85stseyqCRPbKXft+tBsY9a/5TLW+C3737igHU=;
 b=h3vc+ZHe42AIOmhVXo0518swkCPq/+O4Bjlof3UysLXAIaI1AHmsHH92XEzwcAYAVGvA
 o7chMXbha8vQdA8M14nBV2znSi53q+rYqakHswtpJDRHCEOnNLedXDW7JBB1Wy7V7vl6
 RwpcCfYqo93YmIUUvMyGUtCUe/L+dLgmBn4= 
Received: from maileast.thefacebook.com ([199.201.65.23])
 by mx0b-00082601.pphosted.com with ESMTP id 2paj2u0a0t-14
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
 for <linux-arm-kernel@lists.infradead.org>; Tue, 11 Dec 2018 11:03:26 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Tue, 11 Dec 2018 11:03:05 -0800
Received: by devvm4117.prn2.facebook.com (Postfix, from userid 167582)
 id 234064C74214; Tue, 11 Dec 2018 11:03:01 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From: Vijay Khemka <vijaykhemka@fb.com>
Smtp-Origin-Hostname: devvm4117.prn2.facebook.com
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2 2/2] ARM: dts: aspeed: Add KCS support for LPC BMC
Date: Tue, 11 Dec 2018 11:02:46 -0800
Message-ID: <20181211190246.2134590-2-vijaykhemka@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211190246.2134590-1-vijaykhemka@fb.com>
References: <20181211190246.2134590-1-vijaykhemka@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-11_06:, , signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_110339_023212_8F94572B 
X-CRM114-Status: GOOD (  15.20  )
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

Added kcs device support for lpc BMC.

Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 33 +++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index d107459fc0f8..cb35a3ab580a 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -330,8 +330,32 @@
 				ranges = <0x0 0x1e789000 0x1000>;
 
 				lpc_bmc: lpc-bmc@0 {
-					compatible = "aspeed,ast2500-lpc-bmc";
+					compatible = "aspeed,ast2500-lpc-bmc, "simple-mfd", "syscon"";
 					reg = <0x0 0x80>;
+					reg-io-width = <4>;
+
+					#address-cells = <1>;
+					#size-cells = <1>;
+					ranges = <0x0 0x0 0x80>;
+
+					kcs1: kcs1@0 {
+						compatible = "aspeed,ast2500-kcs-bmc";
+						interrupts = <8>;
+						kcs_chan = <1>;
+						status = "disabled";
+					};
+					kcs2: kcs2@0 {
+						compatible = "aspeed,ast2500-kcs-bmc";
+						interrupts = <8>;
+						kcs_chan = <2>;
+						status = "disabled";
+					};
+					kcs3: kcs3@0 {
+						compatible = "aspeed,ast2500-kcs-bmc";
+						interrupts = <8>;
+						kcs_chan = <3>;
+						status = "disabled";
+					};
 				};
 
 				lpc_host: lpc-host@80 {
@@ -343,6 +367,13 @@
 					#size-cells = <1>;
 					ranges = <0x0 0x80 0x1e0>;
 
+				kcs4: kcs4@0 {
+						compatible = "aspeed,ast2500-kcs-bmc";
+						interrupts = <8>;
+						kcs_chan = <4>;
+						status = "disabled";
+					};
+
 					lpc_ctrl: lpc-ctrl@0 {
 						compatible = "aspeed,ast2500-lpc-ctrl";
 						reg = <0x0 0x80>;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
