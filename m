Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE36C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:27:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFE3E20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hPrZzn/6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="DfOXvGWc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE3E20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+dQ8UKELakvXvgIoh23CqKfj7DcCGSxAJa5q1LCzWW4=; b=hPrZzn/6bg6KaQ
	I3r4Uv98RbweTuyW/B5CFOaojAL2Qj9m+nT591Huo5yGYbXd3ImLnWavkNF/u/Ka7DqS6nc8DdCvo
	ONtXS0biofgcxL2AWiszks8MlgRvaJrqge0g03Efqx1vIA4fEqFI3bdGWoqSKj5HNn5fbYPPsMIJW
	wkPZjFLoa2TO9fSIytaquBurukTJ7EyKyGVPsHm5sX6VgLZAsdgRGskiHzoXGunn8jRQNXhmujuiy
	DBdniqev0LYuj5z+SGyDAgbqQ6G8uMclow20l7F7Ufr+qi33y4Hj8JH3GzST+8fTxSN1o3FgT/aaU
	8EzJ2xKtq6/8vLqkFGvQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU6zZ-0000sH-BW; Tue, 04 Dec 2018 09:27:45 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU6yk-0008Cs-T9
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 09:27:04 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c0648530000>; Tue, 04 Dec 2018 01:26:43 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 04 Dec 2018 01:26:43 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 04 Dec 2018 01:26:43 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 4 Dec
 2018 09:26:43 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 4 Dec
 2018 09:26:43 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via
 Frontend Transport; Tue, 4 Dec 2018 09:26:43 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw02.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c0648510001>; Tue, 04 Dec 2018 01:26:42 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver
 <pdeschrijver@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH 04/19] dt-bindings: cpufreq: tegra124: remove cpu_lp clock
 from required properties
Date: Tue, 4 Dec 2018 17:25:33 +0800
Message-ID: <20181204092548.3038-5-josephl@nvidia.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204092548.3038-1-josephl@nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1543915603; bh=54g5O/FurZ7yAebuCOYdiwAgQkde0TtC+CkjFgnQVFE=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=DfOXvGWcihAgLs5UMlV47NcmboOeIgNGbkG6gDHmvCT1aQqDSHjjPLEnTGCcPM8Vr
 jHjQrE9WUWY8RN173/6tfSyiuZZf26+ETAjt4/JbwGYXVKpFRN+XSbBw8X2QmiIJ9a
 hpytdXSY8FKiVLCm8Q5dCOfWeyGjncP9S3s1KI3MWx0+PTWBGqWZt15W7gIc7CBbFb
 y1r2i7d5uYIyJ1foaVRW/BBXosg6fLJIk/l7heO+2OwhrkP8j5pHyOfAWH0NK0Xafs
 np+h733ECR3LJlYE+3FaYclwLlCWDcCBheK3FgofBtlmTCTlcZ14UZE/sQNnRzzbLE
 2U1lfutqT0C0Q==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_012655_641642_EF924B98 
X-CRM114-Status: UNSURE (   9.79  )
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
Cc: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Joseph Lo <josephl@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The cpu_lp clock property is only needed when the CPUfreq driver
supports CPU cluster switching. But it was not a design for this driver
and it didn't handle that as well. So removing this property.

Cc: devicetree@vger.kernel.org
Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 .../devicetree/bindings/cpufreq/nvidia,tegra124-cpufreq.txt   | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/nvidia,tegra124-cpufreq.txt b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra124-cpufreq.txt
index 031545a29caf..03196d5ea515 100644
--- a/Documentation/devicetree/bindings/cpufreq/nvidia,tegra124-cpufreq.txt
+++ b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra124-cpufreq.txt
@@ -9,7 +9,6 @@ Required properties:
   See ../clocks/clock-bindings.txt for details.
 - clock-names: Must include the following entries:
   - cpu_g: Clock mux for the fast CPU cluster.
-  - cpu_lp: Clock mux for the low-power CPU cluster.
   - pll_x: Fast PLL clocksource.
   - pll_p: Auxiliary PLL used during fast PLL rate changes.
   - dfll: Fast DFLL clocksource that also automatically scales CPU voltage.
@@ -30,11 +29,10 @@ cpus {
 		reg = <0>;
 
 		clocks = <&tegra_car TEGRA124_CLK_CCLK_G>,
-			 <&tegra_car TEGRA124_CLK_CCLK_LP>,
 			 <&tegra_car TEGRA124_CLK_PLL_X>,
 			 <&tegra_car TEGRA124_CLK_PLL_P>,
 			 <&dfll>;
-		clock-names = "cpu_g", "cpu_lp", "pll_x", "pll_p", "dfll";
+		clock-names = "cpu_g", "pll_x", "pll_p", "dfll";
 		clock-latency = <300000>;
 	};
 
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
