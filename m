Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B4CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:16:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43A80217D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oeG28nE/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WjPwubY0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43A80217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tPYf2Hlqi9SNJxWmX5fVy947N9esp5lZXYmJklm2uuI=; b=oeG28nE//TER1a
	3YkJzoLnfVbo7NmzSAo+SNlvjIDPn5BjV3FeJwg0ddyaZ37ypXydIJ/fpV8qnVZgApYM0cnoBIdjy
	ie4daks8IBj693Jfh+wOy703xtXB5kHjMUYp5sMxNxn3MR/ikMCyg8G7tI0EvIfCloCkHbRpUzSw+
	nc8WCxnfxF7Gt0+FNzEdnmHnnTL9yVUeFlDvHo+TLRlz19da9z0hZT8QkXm/ycWQxmv5e5cliJKdz
	/FNJZVeGs/VHLFZNRfjIzdRQXTKijN33whp6pI4wEEQKcZ1GJwPQpJu8+vZbeKzEKMDUEHjWntYup
	sAZVU3Nknm43bOQgq5VA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZBUP-0000hw-AO; Tue, 18 Dec 2018 09:16:33 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZBRR-0004uH-3K
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 09:13:34 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c18ba250001>; Tue, 18 Dec 2018 01:13:10 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Tue, 18 Dec 2018 01:13:18 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Tue, 18 Dec 2018 01:13:18 -0800
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 18 Dec
 2018 09:13:17 +0000
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 18 Dec
 2018 09:13:17 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via
 Frontend Transport; Tue, 18 Dec 2018 09:13:17 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw02.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c18ba2c0000>; Tue, 18 Dec 2018 01:13:17 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver
 <pdeschrijver@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH V3 14/20] arm64: dts: tegra210: add DFLL clock
Date: Tue, 18 Dec 2018 17:12:26 +0800
Message-ID: <20181218091232.23532-15-josephl@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218091232.23532-1-josephl@nvidia.com>
References: <20181218091232.23532-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1545124390; bh=X8IM1AVwmLXhNc7N634JKKLIfqcOTCbNoUW3iESapF4=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=WjPwubY0wproleXZZgbDpIvASlErvicm7OgW+7oAXW0gh8CflXU7/Jc0PuULSXDOV
 tRMsypNaGpFjE1Gygn3zyTGia9maeA4hsQnAqjAvq50eXZErW52drRjffMwQbT2921
 QW/9SGUikqMjceRqJrxcVa2SOxCv1OA2GKRE1e8fwbSbrcZx847h9EwFB1WoFcrgK/
 HDDa+MzHKHV6gXaR3axORHigaWdoKANz7cpuqii2BCwhdY+HICeZoZ/iikFhDSKisI
 opnOXqQ38qWgZEgqmac7GJk5Lgm8+mnI/MCtkG9S7wDWJmAvw+uMJrZAGLsrsIALnl
 j0pbsTnXCQ93A==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_011329_864769_1745ED37 
X-CRM114-Status: UNSURE (   8.02  )
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
Cc: linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Joseph Lo <josephl@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add essential DFLL clock properties for Tegra210.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
---
*V3:
 - no change
*V2:
 - add ack tag
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 2205d66b0443..a6db62157442 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -4,6 +4,7 @@
 #include <dt-bindings/memory/tegra210-mc.h>
 #include <dt-bindings/pinctrl/pinctrl-tegra.h>
 #include <dt-bindings/pinctrl/pinctrl-tegra-io-pad.h>
+#include <dt-bindings/reset/tegra210-car.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/thermal/tegra124-soctherm.h>
 
@@ -1131,6 +1132,24 @@
 		#nvidia,mipi-calibrate-cells = <1>;
 	};
 
+	dfll: clock@70110000 {
+		compatible = "nvidia,tegra210-dfll";
+		reg = <0 0x70110000 0 0x100>, /* DFLL control */
+		      <0 0x70110000 0 0x100>, /* I2C output control */
+		      <0 0x70110100 0 0x100>, /* Integrated I2C controller */
+		      <0 0x70110200 0 0x100>; /* Look-up table RAM */
+		interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA210_CLK_DFLL_SOC>,
+			 <&tegra_car TEGRA210_CLK_DFLL_REF>,
+			 <&tegra_car TEGRA210_CLK_I2C5>;
+		clock-names = "soc", "ref", "i2c";
+		resets = <&tegra_car TEGRA210_RST_DFLL_DVCO>;
+		reset-names = "dvco";
+		#clock-cells = <0>;
+		clock-output-names = "dfllCPU_out";
+		status = "disabled";
+	};
+
 	aconnect@702c0000 {
 		compatible = "nvidia,tegra210-aconnect";
 		clocks = <&tegra_car TEGRA210_CLK_APE>,
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
