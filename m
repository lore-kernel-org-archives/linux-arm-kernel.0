Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE47AC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:30:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADDAE214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fV7Fdy87";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="eD+JYgVS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADDAE214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=teB1LehyO+6c4ABwzEruiXJ8fbi/4auTUMyr4Yy+o30=; b=fV7Fdy87Fw/PnH
	L253DPY9lTuO3bTs88roySsxckPfPO/0/mhF2JJ7y9NTGwq7/C2N5E6f7wi8IZVDoaQDs6odqgVDB
	eqfmkyZT357FetGNN5mmRLFwnA+2JlZYoDPrGLX7mCKmFTJHJ4Lri92ZzIOB5jymeVTPoZl4SmoLR
	CHm9uHKj3HCD8mXhTcIFcOYJ1buiNl12XeBYre2xJRgfZf25sff4V3IuCyOrAAMmN74x11AdTrRKm
	jbnomKtHvR6hMu5KMqu1XfDmTj9TpqXWmdsiWv5Lku2Mnv0QedqDFvPUp2fqZSeUOQJ5iUvc6hpqR
	oZ6SFdioy4ELkoojOsRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goPih-0007th-Sn; Tue, 29 Jan 2019 09:30:15 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goPh9-0006Bg-6T
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 09:28:42 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c501cab0000>; Tue, 29 Jan 2019 01:28:11 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 29 Jan 2019 01:28:38 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 29 Jan 2019 01:28:38 -0800
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 29 Jan
 2019 09:28:38 +0000
Received: from HQMAIL104.nvidia.com (172.18.146.11) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 29 Jan
 2019 09:28:37 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 29 Jan 2019 09:28:37 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw01.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c501cc40001>; Tue, 29 Jan 2019 01:28:37 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>
Subject: [PATCH V3 5/6] arm64: dts: tegra210-p2180: Enable CPU idle support
Date: Tue, 29 Jan 2019 17:28:22 +0800
Message-ID: <20190129092823.24983-6-josephl@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129092823.24983-1-josephl@nvidia.com>
References: <20190129092823.24983-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1548754091; bh=ohcHPu43YSqkJDsZ15hzw5CwbI9S1iwLmxddh97DsgE=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=eD+JYgVSrVBjuHLNFbqxZ8522CCg/uEk5jc8L+SHpZAKHQGX7+MEhBdnh8Ui4sZxo
 7cxhJbGE7oUGdbohFDkuTL+pRrSfJ6o1hw6mEyaB7LkbNoOORLvp/FXZTD4QyYJQsP
 n2/+teLxaSh/SG54SrIQp7uGKsdU1EF2Fb+Ajj9BmWq1K6u+o6gSvcVkfTOegu5ZTO
 sVviTTcWcBnEZ0vvFN6NytRY2Emt7lA2CyotJpOBwp8zBneIiiHxfpa9osF2VQ6huM
 5HdJ3Yd4jgysPsI2FsRUT36joSUCwCfAtR32kHipGGBe8LiamiedxXCfImM38/4seN
 YO1y2B04/+tsA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_012840_136448_2EF6F242 
X-CRM114-Status: UNSURE (   7.49  )
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
