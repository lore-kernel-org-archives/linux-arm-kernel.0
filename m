Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D03FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:13:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3D862087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="swNcqawj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D862087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FUl4aX8WAbYnFBIIjuJvy9BcOiHV/9Aqi3soZ/6xozg=; b=swNcqawjoKlFzh
	zqCXO3XiHAm5pXmG+dHoH1jIx3RxE7pP1hxDkEuERVZ71REUwCZbjhY5lcJmb+HVuVFlN3JjUbUNG
	ToFF1MM4+xOSNrU8+9uPYZZzu9sVx7I0d71+tuxZkoiMD3iUB9XOyNQtx5OIpx7AQhbowTGbEtrXB
	6e0XQmf9DFv49oBaOzEYH9lC0CqwiwkGaMm0QkDmSnWnCTxNc29u5qNtYabmA5PRt8irXzmElhthP
	A7NZJXcg6cKSbsMNdyih6IIYcTI2NlmhEKMEs3iy3lUBhf4tyM2lf+1y8OWnf5aBrAr8y22SmsvI/
	WUzg+a6Y2yfxoWTPGM2Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyy5b-0006ql-TK; Wed, 27 Feb 2019 12:13:31 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyy51-00067i-Uc
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 12:12:57 +0000
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1RC8kN8019402; Wed, 27 Feb 2019 13:12:45 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2qtvh3pd6u-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Wed, 27 Feb 2019 13:12:45 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 944D131;
 Wed, 27 Feb 2019 12:12:44 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6D7335266;
 Wed, 27 Feb 2019 12:12:44 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 27 Feb
 2019 13:12:44 +0100
Received: from localhost (10.201.20.122) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 27 Feb 2019 13:12:43
 +0100
From: Benjamin Gaignard <benjamin.gaignard@st.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <arnd@arndb.de>,
 <shawnguo@kernel.org>, <s.hauer@pengutronix.de>, <fabio.estevam@nxp.com>
Subject: [PATCH 1/7] devicetree: bindings: Document domains controller bindings
Date: Wed, 27 Feb 2019 13:12:26 +0100
Message-ID: <20190227121232.24873-2-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190227121232.24873-1-benjamin.gaignard@st.com>
References: <20190227121232.24873-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
X-Originating-IP: [10.201.20.122]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-27_07:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_041256_437858_3B94A42D 
X-CRM114-Status: GOOD (  13.51  )
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
Cc: benjamin.gaignard@linaro.org, loic.pallardy@st.com,
 linux-kernel@vger.kernel.org, linux-imx@nxp.com, kernel@pengutronix.de,
 linux-arm-kernel@lists.infradead.org,
 Benjamin Gaignard <benjamin.gaignard@st.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Document commons domains controller bindings for controller
and client devices.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 .../bindings/bus/domains/domainsctrl.txt           | 55 ++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/domains/domainsctrl.txt

diff --git a/Documentation/devicetree/bindings/bus/domains/domainsctrl.txt b/Documentation/devicetree/bindings/bus/domains/domainsctrl.txt
new file mode 100644
index 000000000000..f82e5e11ea64
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/domains/domainsctrl.txt
@@ -0,0 +1,55 @@
+Common Domains Controller bindings properties
+
+Bus domains controllers allow to divided system on chip into multiple domains
+that can be used to select by who hardware blocks could be accessed.
+A domain could be a cluster of CPUs (or coprocessors), a range of addresses or
+a group of hardware blocks.
+
+This device tree bindings can be used to bind bus domain consumer devices with
+their bus domains provided by bus domains controllers. A bus domain provider
+can be represented by any node in the device tree and can provide one or more
+bus domains. A consumer node can refer to the provider by a phandle and a set
+of phandle arguments of length specified by the #domainctrl-cells property in
+the bus domain provider node.
+
+==Bus domain provider==
+
+Required properties:
+- #domainctrl-cells	: Number of cells in a bus domain specifier;
+			  Can be any value as specified by device tree binding
+			  documentation of a particular provider.
+
+==Bus domain consumer==
+
+Required properties:
+- domainsctrl-X		: A list of bus domain specifiers, as defined by
+			  bindings of the bus domain controller that is the
+			  bus domain provider.
+
+Optional properties:
+- domainsctrl-names	: A list of bus domain name string sorted in the same
+			  order as the domainsctrl-X proprerties. Consumer
+			  drivers will use domainsctrl-names to match bus
+			  domains with bus domains specifiers.
+			  Note that "default" and "unbind" are reserved names
+			  used by the framework.
+
+Example of usage with:
+- a domains controller with a 2 parameters cell
+- a domains controller with a 3 parameters cell
+- a client device node using the both controllers and 2 configurations
+  named "default" and "unbind"
+
+ctrl0: ctrl@0 {
+	#domainctrl-cells = <2>;
+};
+
+ctrl1: ctrl@1 {
+	#domainctrl-cells = <3>;
+};
+
+foo@0 {
+	domains-names = "default", "unbind";
+	domainctrl-0 = <&ctrl0 1 2>, <&ctrl1 3 4 5>;
+	domainctrl-1 = <&ctrl0 6 7>, <&ctrl1 8 9 0>;
+};
-- 
2.15.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
