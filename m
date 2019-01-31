Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE9BC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:26:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B616720B1F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qp4Gjo8I";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="F0eAVYtE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B616720B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TPdadte/Tk6+msLuPm47dpZMovWsw90kEyIGL5RKrH0=; b=Qp4Gjo8I/bj3W2
	Un0gnQ1dEwD90ogc7s6xVwxcGz5cLK2SW8smkVfLMM+OKRBUwnK1KDyHoPoBDePOUhCsGdNBIi5KZ
	xC0wMnmEkZclM1dKwn2Zr7/HoJCiYs4VtSuQ+AyjUpBGarOiIkuRTNEEs/RZZ6JXwAyWjMP4CnmXQ
	xUm6VA8OZE3Bpfa9AGXzK+OIRsCBstuP2JGshnDLrYu1HdmUbJCOo2ayZX28mHrQOrwwoOJxTmhXm
	5bn1XnYvb3kTzZ9bJnZnQETXXPcknIgYJxQoFs+bwzxoXX4SeYrwVLWLK/KVa5R5RC7uuWfo3VKf/
	f7ofmC6K2OTkSICH2JRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp8bp-0007JA-SC; Thu, 31 Jan 2019 09:26:09 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp8aD-0004jD-Tq
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 09:24:35 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c52becf0000>; Thu, 31 Jan 2019 01:24:31 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Thu, 31 Jan 2019 01:24:29 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Thu, 31 Jan 2019 01:24:29 -0800
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 31 Jan
 2019 09:24:28 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via
 Frontend Transport; Thu, 31 Jan 2019 09:24:29 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw02.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c52becc0000>; Thu, 31 Jan 2019 01:24:29 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>
Subject: [PATCH V4 6/7] arm64: dts: tegra210-p2180: Enable CPU idle support
Date: Thu, 31 Jan 2019 17:24:09 +0800
Message-ID: <20190131092410.28222-7-josephl@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131092410.28222-1-josephl@nvidia.com>
References: <20190131092410.28222-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1548926671; bh=PceGdDiJMejWEZzyq+rxtW03KeoQYPMZsc1JrfExrFQ=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=F0eAVYtEo31qeCE/XBGu+KL3R024+DZTi3AE6jhjsBEbQGQ16F7KxOKK76KRQSYUT
 /JrssT3sMqxhfHR2IYX8dgbQTx8C7dxqgv3NfiGHJ63Zu765AjVxLSzE/E2Gw/6heE
 1GCPykhjmg9a9h0he/Q/uNRURfJ1GLfr0BcDiaWA1+7yHdhL0BkkKg4EmoYc7UeVs7
 XiV3XWGyLNu8dCezAQXeLdfX1fituNIYL3i0Z/72AlpjSDmMqRxq+cXKylm6XzVFOZ
 TdD3L2Fo8pFs+1TCl0cpSzqWFzvbzX1H5AjR7gJnlxkhUJVsyTDekuN1pNMYCx2wqK
 SHX80IYcp3szQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_012430_630226_CB3F17E1 
X-CRM114-Status: UNSURE (   7.00  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Joseph Lo <josephl@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Enable CPU idle support for Jetson TX1 platform.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
v4:
 * no change
v3:
 * no change
v2:
 * no change
---
 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
index 053458a5db55..d1a492c63e96 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
@@ -305,6 +305,12 @@
 		cpu@3 {
 			enable-method = "psci";
 		};
+
+		idle-states {
+			c7 {
+				status = "okay";
+			};
+		};
 	};
 
 	psci {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
