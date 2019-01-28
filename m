Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F06C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:19:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B41392087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="exP5mPI1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="rvtEnfU8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B41392087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+In45M71pNVfbbfHz3ltoYdIVLo9moVZr+EG5RV4L2w=; b=exP5mPI1vXhcST
	sRxykx5jRS6DmYOrwoKG8up7EBfx7YNZPLXnTzsX9fzfd+0RlmFP2/W3zJd9PixHkphG0UKEPIszn
	VVbRY/zSq3ExOCedUbQArwi9kgC9v+PGZLfa5LjzD1dnxhiAt5+AYszge2s+BqlZIUDdJsjE2DiJ6
	aa7adY5U1BHk+bCbJxx9OOdwXPDPyzdAmULgyCAKCkTciiSLe41fUVI+hdqcBUh7RMSmr5KmwBcq4
	QYK9ZO9DWUYLFxTBGgykWMbsCfAgizSZlaIgKk3Uxi+hWU4JxLOFspSigTW2jHNtjBnmeVmbXHzRg
	IZ3lOG1IZsIzjWi0khLA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go34W-0006Fl-4w; Mon, 28 Jan 2019 09:19:16 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go33o-0005Zj-8i
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 09:18:37 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c4ec8c10000>; Mon, 28 Jan 2019 01:17:53 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Mon, 28 Jan 2019 01:18:31 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Mon, 28 Jan 2019 01:18:31 -0800
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 28 Jan
 2019 09:18:31 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 28 Jan
 2019 09:18:30 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Mon, 28 Jan 2019 09:18:30 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw01.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c4ec8e50005>; Mon, 28 Jan 2019 01:18:30 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>
Subject: [PATCH V2 3/6] arm64: dts: tegra210: fix timer node
Date: Mon, 28 Jan 2019 17:18:12 +0800
Message-ID: <20190128091815.7040-4-josephl@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128091815.7040-1-josephl@nvidia.com>
References: <20190128091815.7040-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1548667073; bh=oSs2GxA4T1rS7Z03+cb/ELec9MX/NjjwFBgEQ7Wz8Sk=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=rvtEnfU8sX2vbhGVKAFvHbqMD5trEmdv/oLamf+vKf3k/hEz1Mkz2Bo4gQ9XE1RGj
 LYbWcBfA5moJ3083mqD6Z8crzXBsMtDKDjTqP5qe2AbNcYJ8vZwLz3j5ZUJZO6B93V
 q0wDerxkxKkTb7GNfDJACUeWO3Zo/AxUEwyJdYZUvtRMm6EimggVCdpgJBjs5xD+Oj
 CYgGGe8+HF5xH8riqTPLn6d4z05nv3xhUIAztqc8OIMfZjy6HUHUXAisT51uHViak0
 Gafb28zE2YsyMHqx0ErK+k+iSHym+dcRb+YLLuvKKdYSUqdXXwMFvKXyim6ochkZkb
 qI46lvsPsvK9g==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_011832_960578_C6440AFE 
X-CRM114-Status: UNSURE (   7.08  )
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

Fix timer node to make it work with Tegra210 timer driver.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
v2:
 * list all the IRQs per each timer channels 0 through 13
 * remove compatible string of "nvidia,tegra30-timer"
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index b5858b5ea052..2b387364afc3 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -384,14 +384,22 @@
 	};
 
 	timer@60005000 {
-		compatible = "nvidia,tegra210-timer", "nvidia,tegra20-timer";
+		compatible = "nvidia,tegra210-timer";
 		reg = <0x0 0x60005000 0x0 0x400>;
-		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+		interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
+			     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA210_CLK_TIMER>;
 		clock-names = "timer";
 	};
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
