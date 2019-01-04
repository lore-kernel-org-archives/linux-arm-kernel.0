Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F9BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 03:09:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 794FD20449
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 03:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EFGl9QQV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="A+34xlwX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 794FD20449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1UbQYjLhbQwunXMGOW68/A8DjNJPtv+VhPUvbnZco4E=; b=EFGl9QQVdaVRRe
	3+czO+KWuis9/Ufia2HT7hq7bghTLe+XSqS3djg30gIbuthlQFSToEAhA0cbXIiK/ESVAk9C8RcXj
	zvQ5QQSo1RHUIEvCZOeEhizHSaKr5l2VHiv1kM0qbphFF7YSnQy7btDJLm6RIjjBeL++RhpQJ3uSc
	up1QCipWhjqiMLcN95SMMLWXk89GRrB3F+t8lTSJWku7l+BBSi+VMOvcgTLfCyAngHNHzgvaX0PuW
	cSL9qLF7OsciE620N/mbLztohCmRf2qLjlelA5Y9rCpga4sQBZTy7f30HRrmTpBP8+2PBG2v3KsVo
	b8jgZ/sYTt5ll1VfsgeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfFrF-0007BL-Jy; Fri, 04 Jan 2019 03:09:13 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfFpN-0005fa-Ba
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 03:07:25 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c2ecdd70000>; Thu, 03 Jan 2019 19:07:03 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 03 Jan 2019 19:07:17 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 03 Jan 2019 19:07:17 -0800
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 4 Jan
 2019 03:07:16 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 4 Jan
 2019 03:07:16 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via
 Frontend Transport; Fri, 4 Jan 2019 03:07:16 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw02.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c2ecde20004>; Thu, 03 Jan 2019 19:07:16 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver
 <pdeschrijver@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH V4 03/20] dt-bindings: cpufreq: tegra124: remove
 vdd-cpu-supply from required properties
Date: Fri, 4 Jan 2019 11:06:45 +0800
Message-ID: <20190104030702.8684-4-josephl@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104030702.8684-1-josephl@nvidia.com>
References: <20190104030702.8684-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1546571223; bh=IlrTUSZ8iNX/a/rGz8+bVghxG+e/LBW1wnXFNs+jLoE=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=A+34xlwXjot4YQcgSLI43W5Y9cSpBD6YaGFtkzP5MzAdLX0klUU0UdLuXEky8CVZ1
 +Cu7uPIjVjhWyWp+5b8/77r4lJU2oLMZ1LTRuwkgXF5hmI91zjzstFZAZueH2zt1EG
 iN8c/ncdDbP4x6yXu1uhjz1vLgASm+YK8PL7GaU0Ju7aLwNxBrha17rEM4mvVX0GwC
 GFHyuA3w+DtKe+xG1gPhGfvjlxDcuOzxlDjBPV/HyvG4q6l/HsuH63xAlEznso8WNI
 JHvy5AU1FzQtni1/pOII9ClVZvExDbnFgPGIxCI+YAKbDoR2KvxUEYBLHbMUugCM3R
 PBTdFtXLUhWdg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_190717_803987_8812C968 
X-CRM114-Status: UNSURE (   7.85  )
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
Cc: devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Joseph Lo <josephl@nvidia.com>, linux-tegra@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The Tegra124 cpufreq driver works only with DFLL clock, which is a
hardware-based frequency/voltage controller. The driver doesn't need to
control the regulator itself. Hence remove that.

Cc: devicetree@vger.kernel.org
Signed-off-by: Joseph Lo <josephl@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
*V4:
 - add RB tag
*V3:
 - no change
*V2:
 - add ack tag
---
 .../devicetree/bindings/cpufreq/nvidia,tegra124-cpufreq.txt     | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/nvidia,tegra124-cpufreq.txt b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra124-cpufreq.txt
index b1669fbfb740..031545a29caf 100644
--- a/Documentation/devicetree/bindings/cpufreq/nvidia,tegra124-cpufreq.txt
+++ b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra124-cpufreq.txt
@@ -13,7 +13,6 @@ Required properties:
   - pll_x: Fast PLL clocksource.
   - pll_p: Auxiliary PLL used during fast PLL rate changes.
   - dfll: Fast DFLL clocksource that also automatically scales CPU voltage.
-- vdd-cpu-supply: Regulator for CPU voltage
 
 Optional properties:
 - clock-latency: Specify the possible maximum transition latency for clock,
@@ -37,7 +36,6 @@ cpus {
 			 <&dfll>;
 		clock-names = "cpu_g", "cpu_lp", "pll_x", "pll_p", "dfll";
 		clock-latency = <300000>;
-		vdd-cpu-supply: <&vdd_cpu>;
 	};
 
 	<...>
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
