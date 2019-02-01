Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B7BC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:38:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31CC520863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BjIU7FET";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="o7D5o6/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31CC520863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sB6s/3CevNb6v7BqQTnbRSV77sNYsbdKMX+tWMqwQlg=; b=BjIU7FET8Za0cw
	Z2N60ZuTYU4mtm6g9rGBtK+n/UQSP7usv99E8YO2XWXCiA8SicfIK1vi7mrNHT3h3uO1oCDrZIJ2D
	xECypx8DbS8L1HU+60VtEprQ6iwhoS7AgEgLuwmCUY2MR5T2GX8ljYLhE0V7fuQvK6KJdM8Gprd7N
	QUzFxftNx5wek4heeF5eaTlMlqissf/s+4b3nBxuRh2ECr2vXshLfLsEgpcWhC0pV85RLi418WwcL
	EKSSBeH+b+XoOuYqrai/hu9smxfkoIXwQjqA79qJZ+E6P0hojhSvI8AdRMJuFJjV8apD5c/COPb6n
	i+4a+4VadY6hF3OGyxMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpPem-0006QM-1F; Fri, 01 Feb 2019 03:38:20 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpPdF-0004gR-3J
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 03:36:47 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c53bece0001>; Thu, 31 Jan 2019 19:36:46 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 31 Jan 2019 19:36:44 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 31 Jan 2019 19:36:44 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 1 Feb
 2019 03:36:44 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via
 Frontend Transport; Fri, 1 Feb 2019 03:36:44 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw02.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c53becb0000>; Thu, 31 Jan 2019 19:36:44 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas
 Gleixner <tglx@linutronix.de>
Subject: [PATCH V5 7/7] arm64: dts: tegra210-smaug: Enable CPU idle support
Date: Fri, 1 Feb 2019 11:36:21 +0800
Message-ID: <20190201033621.16814-8-josephl@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190201033621.16814-1-josephl@nvidia.com>
References: <20190201033621.16814-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1548992206; bh=lqmtsCupYlrDPJ7aTV3NMXoUlvo9AdJMh0ODevoR1Zw=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=o7D5o6/ZIi3QMgiBze3kjVliuCXQQpt+pG7012XWfy+kOjlH00tTLJDkhAHm2TORf
 mMKQGLANhkZ4VLxeiQJfpTQUaN4JQp7p7GaGvWpGttzGhmD+/6pP2oLoFdnQf8teWz
 7RGbyyp+L9eBy7InuYtM3w27k9M8ft1xDD2xrlNuCNlTHlUfOlciwM0exIxA7/8qHS
 elDlf0nqO5QdE+5yk67iGemCmNZmVjThNxbP+HeIIf2ZHY9A3y4Vb9L3/P3YqtRva7
 Ssx2tBbnWux4D457V0OOw5ajfL2pBy8NAjMwtxW0l8KIUfxxkJo4azQ6Ua2Ho+fzcz
 xDb03377agx7g==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_193645_281561_A3179887 
X-CRM114-Status: UNSURE (   7.51  )
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

Enable CPU idle support for Smaug platform.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
v5:
 * no change
v4:
 * no change
v3:
 * no change
v2:
 * no change
---
 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
index 5a67890cfb7a..da0eb4530acf 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
@@ -1751,6 +1751,13 @@
 		cpu@3 {
 			enable-method = "psci";
 		};
+
+		idle-states {
+			c7 {
+				arm,psci-suspend-param = <0x00010007>;
+				status = "okay";
+			};
+		};
 	};
 
 	gpio-keys {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
