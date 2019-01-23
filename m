Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1995FC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 23:07:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D57EF21019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 23:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BFUaoxR2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Puf/wGkU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D57EF21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=6n3sY1lp2KM3eApcptdaDALLbq/zUzh3zbe1KCaUD90=; b=BFUaoxR2TI8F/0
	HvHWwEP9121IwduiswzGEwtbXfNM8Y3UsDWyYcZMEYU7T9n4GDSchIS/Y6biys13Hsc0d5XsVlLiX
	qvId/UuUR/DFp2r5acrBB7u0+YGaQgm0weKUk/KssBi1NEOoQYLxi+rG4pJgxyuPlYLqpUpRgu1TD
	PmdnEK5thjSe+1clACUCXQQHvbUad6pDhZzoFXrBy+BkQGQvrxt8vfEKnlCi4gtuIWkYZ+fB/lUg4
	/nM9uIwzYxToGxu5LvZB71IzCu7d/vehkkbajKwr8wiXJbkjL3MNOvXGVwqYAeXi/0ScbRm3sa2dc
	YEylj0gRO3CsfrfKDAoQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmRcT-0001HH-EC; Wed, 23 Jan 2019 23:07:41 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmRcQ-0001Ge-92
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 23:07:39 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0NMxvbD005216
 for <linux-arm-kernel@lists.infradead.org>; Wed, 23 Jan 2019 15:07:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=mw2Se00uQPELWHjBZyhQPnW3g6bdq8Gqz6xg7vQx+UQ=;
 b=Puf/wGkUlgCL02rBFrfdRU2MGYaU5EjRSygEwYmhdCmyYpMOm+pAqSDhzGR/pwfAWzWv
 tnBSxHAtMy0tx66AG18hV/UR122jqXllWSXJR2WYjbN9DGF5tIseW4vZ1TQUnz1VzD1z
 9iTI6d8f4Q1xT7Q2WSAqCjX/Q0qS01bIiho= 
Received: from mail.thefacebook.com ([199.201.64.23])
 by mx0a-00082601.pphosted.com with ESMTP id 2q714ng3hs-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
 for <linux-arm-kernel@lists.infradead.org>; Wed, 23 Jan 2019 15:07:37 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Wed, 23 Jan 2019 15:07:36 -0800
Received: by devvm4117.prn2.facebook.com (Postfix, from userid 167582)
 id 44BA7861B078; Wed, 23 Jan 2019 15:07:36 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From: Vijay Khemka <vijaykhemka@fb.com>
Smtp-Origin-Hostname: devvm4117.prn2.facebook.com
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH 1/2] ARM: dts: aspeed: Add peci and lpc for Facebook
Date: Wed, 23 Jan 2019 15:07:32 -0800
Message-ID: <20190123230733.1821501-1-vijaykhemka@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-23_11:, , signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_150738_425708_B6B79C5A 
X-CRM114-Status: GOOD (  12.28  )
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

Added lpc control for enabling lpc clock, peci for cpu sensors and lpc
snoop devices to Facebook Tiogapass device tree.

Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
---
 .../arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
index 73e58a821613..d60dbb019f82 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
@@ -54,6 +54,16 @@
 	};
 };
 
+&lpc_snoop {
+	status = "okay";
+	snoop-ports = <0x80>;
+};
+
+&lpc_ctrl {
+	// Enable lpc clock
+	status = "okay";
+};
+
 &uart1 {
 	// Host Console
 	status = "okay";
@@ -67,6 +77,10 @@
 	status = "okay";
 };
 
+&peci0 {
+	status = "okay";
+};
+
 &kcs2 {
 	// BMC KCS channel 2
 	status = "okay";
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
