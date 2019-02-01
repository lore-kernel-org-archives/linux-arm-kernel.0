Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2005C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:37:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C17F20815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IHX4gWUy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jPk9WJvF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C17F20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JgKci4wQ1Nte+NerSNpdi/3K5FnyyAvqQFVEPIvA7VQ=; b=IHX4gWUy9f23a6
	VYibzogt7XWjM8vS4TtuAMe2ggpYgZjFP2bL6/nMJ6h6TyDsgbNMoFQnSjun5eWdXfl5p0Iodd3vI
	PPlMv4VyYqv7knKvA6rzqUa3PhtYAUgi25aiGq0hL3fKjAesd+fbsc+nshnjA8+RWJXXCWetvHTAw
	zYRcSKu1xcpQbgi8er17hHNsmi6asf2UFT6a5ROpZTc55uPzP6toyrOeJnHoHhqCsz/FdNxXZDElp
	CClrvZC5wTo7zRZlwjAe8vcNvkZfyMipXS0dH9LoLLfijUnjugaTd4VaveXWSMwNIEm6PcvUY+2oz
	054O0cLnnYLLlfqNOwSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpPdW-0004tr-Cu; Fri, 01 Feb 2019 03:37:02 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpPd8-0004ZF-L5
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 03:36:42 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c53bea90000>; Thu, 31 Jan 2019 19:36:09 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 31 Jan 2019 19:36:38 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 31 Jan 2019 19:36:38 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 1 Feb
 2019 03:36:37 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via
 Frontend Transport; Fri, 1 Feb 2019 03:36:37 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw02.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c53bec40000>; Thu, 31 Jan 2019 19:36:37 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas
 Gleixner <tglx@linutronix.de>
Subject: [PATCH V5 4/7] arm64: dts: tegra210: fix timer node
Date: Fri, 1 Feb 2019 11:36:18 +0800
Message-ID: <20190201033621.16814-5-josephl@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190201033621.16814-1-josephl@nvidia.com>
References: <20190201033621.16814-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1548992169; bh=XM9X8l3VLpXW3kN1JPu9vpI4LiWKf8z8ffKj/rnZ6vo=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=jPk9WJvFdUgTzGWBTnCCglSbmxe/CzJpAFxa9xhE29r8QLn65L5+f0nK8IwIf+stj
 IjNXzE3KVs9RO7cVhzlFDieATa3RyHu8rYCWmSa2ZKOzJH85uNtZ3/m3WMnS7qohOx
 ldpCXjV/EXV1+ejYxUerdbwUUnyvk+MRCQO6petMeINBXR28XqA1lgLTlypuIDH6Yc
 BmVg/rEm8no6CFbpwEEfSb03w+AM4fBVMFkuWsBHMhpFxuybpJGblg9v113ihFablL
 9sAXl1qswONxp39Pr09AfrNsU6bNtm2mZn29J3RU+OoMjT0h8J+X4WItwUFkvjbwhP
 gGVatmWLnpeMw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_193639_428296_BFE02CD2 
X-CRM114-Status: UNSURE (   7.95  )
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
v5:
 * no change
v4:
 * no change
v3:
 * no change
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
