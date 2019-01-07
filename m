Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A292C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 03:28:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48D1D20838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 03:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Vfffl91l";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="HRbwNY/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48D1D20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nzJLYMmeeVABvdvciuSDUwZuAeo5LjGIGu0pVajekkI=; b=Vfffl91liqVPYP
	faa896uVOT6fzas65nuWx5ubX/7fV5vWqoCpBbalY6S7TaSCuMFugWcwp1kCXAiikfo9KPoUHWE1h
	XqyiE3ZoRtn2C81lywLGAzzyB2BkO8XB0l+tfHMuGtfBQIAM6aZxd/LfPfIJGiGqYoLPMBIF8B+Dr
	QnG8dhVxEuHKU1uoIn1EpNw1Do3fuWx4B4Z702mBV4n1B/IRnM8uiPbC4Vtk2Xq+Isgg2gPcTJi/4
	piyI5xJYVopKhS4bHiefcav+pHP11acuunrh9RZSaJCiQya11mBV/8emT1zPgsVXVJBGSln/+IQ1y
	b7Q06Q+7i+S7eYBTBQUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggLac-00084a-Ev; Mon, 07 Jan 2019 03:28:34 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggLaQ-0007uR-BR
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 03:28:23 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c32c73f0000>; Sun, 06 Jan 2019 19:27:59 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Sun, 06 Jan 2019 19:28:21 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Sun, 06 Jan 2019 19:28:21 -0800
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 7 Jan
 2019 03:28:21 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Mon, 7 Jan 2019 03:28:21 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw01.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c32c7540000>; Sun, 06 Jan 2019 19:28:21 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>
Subject: [PATCH 3/6] arm64: dts: tegra210: fix timer node
Date: Mon, 7 Jan 2019 11:28:07 +0800
Message-ID: <20190107032810.13522-4-josephl@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107032810.13522-1-josephl@nvidia.com>
References: <20190107032810.13522-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1546831679; bh=bmNtucCFWvcWQo29UUZ3MkfE16y1idi/x3oqMPXW02g=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=HRbwNY/qu9l6/dyaYsDwVQSlkOVd13Sc4t060rbwGdMd6sTwzeiszdeaVLavB7adf
 XusIi2eA5/ilsE/ltyJg4udB+kngZ9/SGaVtv1u1WjvdwrziW0af69v7W6VBSWmOF1
 5vJjUr8hKNDTdo2MZJEqoDeMku2WzASe5CiTa69hKu77Srg8PzyBiOCsvhzoChKiUZ
 IVT9L4AaLKR4u0uQG/KybZHlxPVzqGONJFhhRuj0Ol77oyOPnpy/qu9nf6ApNRrIpd
 ZJAa6uUY5xvDeTI0lFcvPKKnFT5Eyx3WX98tleIGzJGo7H9k3Jb67kd6ZrVpDFm1dn
 XwzYQMI5WJ/Kg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190106_192822_399620_8F4FBB64 
X-CRM114-Status: UNSURE (   7.38  )
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

Fix timer node to make it work with Tegra210 timer driver. And backward
compatible with the Tegra watchdog driver.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index b5858b5ea052..143bd103c923 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -384,14 +384,12 @@
 	};
 
 	timer@60005000 {
-		compatible = "nvidia,tegra210-timer", "nvidia,tegra20-timer";
+		compatible = "nvidia,tegra210-timer", "nvidia,tegra30-timer";
 		reg = <0x0 0x60005000 0x0 0x400>;
-		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
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
