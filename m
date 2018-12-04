Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C459CC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:27:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BA6520851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IKf9sb1c";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="MWmWUeLM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA6520851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JmRh4XNER39UJabC9+CQ1RJn0N7ZIqTdis3zftsmcac=; b=IKf9sb1cwbRFJs
	TWJzSiN0B0x2CgH1fBl78GHVkfRDoHLUXw97LwxgN+mubyjptjjjDKPN64ZWGvK0EaxV7WhvTHvLD
	hBPFZm9SGZKAtZJWYptyLAMRAolGxuoKsDwUyIINJT5/gbuQ6O4P9RKKVTs3VHgbpJSp5kQfFA3X/
	367Mh+fnf1A++P5U+FyJRUrxmUkL9KSuK+woN5iv+Pfkrfper/ilSJAYhANqUCdyaVDzrTEtBcFm6
	yFvwdh5vvb6T7PdgM4sKktLJmysB6HgqfNbwsmsuiOu6JrzSOeb+40+VTOAjHin9G8XbVJyUOzT5o
	Ad3EbdNoOOITHIaU4G2Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU6z6-0000Lh-DQ; Tue, 04 Dec 2018 09:27:16 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU6yg-000863-06
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 09:26:58 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c06484d0000>; Tue, 04 Dec 2018 01:26:37 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 04 Dec 2018 01:26:37 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 04 Dec 2018 01:26:37 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 4 Dec
 2018 09:26:37 +0000
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 4 Dec
 2018 09:26:37 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via
 Frontend Transport; Tue, 4 Dec 2018 09:26:37 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw02.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c06484b0003>; Tue, 04 Dec 2018 01:26:37 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver
 <pdeschrijver@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH 03/19] dt-bindings: cpufreq: tegra124: remove vdd-cpu-supply
 from required properties
Date: Tue, 4 Dec 2018 17:25:32 +0800
Message-ID: <20181204092548.3038-4-josephl@nvidia.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204092548.3038-1-josephl@nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1543915597; bh=oFIUZWNHCCdRz1ARKQmaqsrWbGyaFWNHECgg1sdJOzw=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=MWmWUeLMSozARm1Uh/eFiwrEKCMONzIJLK4HVQPoWo8ObYJR4js9otJVfrUz34MWk
 gXggvN8v17DrI+OerRoh1grI8vEoRAPsId5TFJz5m/lyIxa8vTLRGqX4PeNsdduojZ
 oRMvc8u8/JG/vKxP6iasl7g+A8YWm91+Z2ubMqyY4GEHQh9X38FbhHEPuYkAiE/l6M
 d5bKVHxBhMXMfV8lp9q7l43hAzQzjU1FF//jNy44b5xxcSrf2khjHIEfKtPapBNbh5
 sj4K+5lMFWqcsH9fk2ZjhQOg7N2mXVQseNGpOLlYa1zT07gJnvAQv0pPnsOiyEndMz
 +QgEk0QN+gAOQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_012651_102977_0C7F5494 
X-CRM114-Status: UNSURE (   8.52  )
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

The Tegra124 cpufreq driver works only with DFLL clock, which is a
hardware-based frequency/voltage controller. The driver doesn't need to
control the regulator itself. Hence remove that.

Cc: devicetree@vger.kernel.org
Signed-off-by: Joseph Lo <josephl@nvidia.com>
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
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
