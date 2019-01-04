Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F825C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 03:13:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51F8320815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 03:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BN8okpEM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ARFjZD73"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F8320815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xlg1cYVI+HwqXT8gOBrn5euc9tF2MxwJf8A18Hht98U=; b=BN8okpEM6FHyBI
	P0LuFYyHHTrNTHR9RNojUlUqFu6KmDm5eE6hKed9vmJaMttgJ3jQJca7MrJ1hFAxv2AZqBiI6L4h4
	z969M4ksyPnCiFeqyF5xsDzvf7ceO0dsJoaRNLDzKe1/2SPuxwpVwnQvi1fMjjtEiVldHHQa6eo5v
	cMKUMB3ZAosaGu5Nv/PsrHv0ZDNScpFLqMR8n1nJYqKZmzBFyKiQQ4b/fuIbAVmDefoN1pTV0cTf5
	CYyP8+brpou9c5kM3o+k+IfIsnNHbjF1jeR1ltaT3dI39oE17hBO+IFR3nxwWqgQOae1XfGcym7Dh
	utBJ60b1DkjmF+eOvLUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfFvf-0003zl-8X; Fri, 04 Jan 2019 03:13:47 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfFpu-00068d-MZ
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 03:07:53 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c2ecdfb0000>; Thu, 03 Jan 2019 19:07:39 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 03 Jan 2019 19:07:50 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 03 Jan 2019 19:07:50 -0800
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 4 Jan
 2019 03:07:50 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via
 Frontend Transport; Fri, 4 Jan 2019 03:07:50 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw02.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c2ece040005>; Thu, 03 Jan 2019 19:07:49 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver
 <pdeschrijver@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH V4 18/20] arm64: dts: tegra210-smaug: add CPU power rail
 regulator
Date: Fri, 4 Jan 2019 11:07:00 +0800
Message-ID: <20190104030702.8684-19-josephl@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104030702.8684-1-josephl@nvidia.com>
References: <20190104030702.8684-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1546571259; bh=ZV0a7NNaucYPbruJwhxQSiG84s0auIj57IjUVum4l8Y=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=ARFjZD73s+CpSWBBaKbobmZ3tpGt7jvDCkYROowSqEqkQ7Iw1lGv55CzXUj9W5d/D
 Z8NRdNn4iJkzb8f04Ix2gLyOYt3h2xCQSJbdl5X13OYy3xOE2TUIJJeYpgKqiQp6Cf
 vFL3NcLBy90dH/tEoUjPSjpRTGl+f2CaQS5/5e1DTycaUOFi8Hs8pFz8jECLhBP2i2
 9KGSDDj0+cMW2nr+5h7ee9Dlt8pWcPZDV5/V8UYXFpjsqWHLMc/qCGjm9jexFZLWsd
 uZv5IqZdni1b8361vLLu+hNuS4SAlCRMatrqX52jDSOakOwSNj4s/4SndSxCO24DhV
 TWM56K+BZPWLQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_190750_851883_C3A0D2E4 
X-CRM114-Status: UNSURE (   7.25  )
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

Add CPU power rail regulator for Smaug board.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
---
*V4:
 - no change
*V3:
 - no change
*V2:
 - add ack tag
---
 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
index 43cae4798870..79cfcd5b7e62 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
@@ -1340,6 +1340,25 @@
 		status = "okay";
 		clock-frequency = <1000000>;
 
+		max77621_cpu: max77621@1b {
+			compatible = "maxim,max77621";
+			reg = <0x1b>;
+			interrupt-parent = <&gpio>;
+			interrupts = <TEGRA_GPIO(Y, 1) IRQ_TYPE_LEVEL_LOW>;
+			regulator-always-on;
+			regulator-boot-on;
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <1231250>;
+			regulator-name = "PPVAR_CPU";
+			regulator-ramp-delay = <12500>;
+			maxim,dvs-default-state = <1>;
+			maxim,enable-active-discharge;
+			maxim,enable-bias-control;
+			maxim,enable-etr;
+			maxim,enable-gpio = <&max77620 5 0>;
+			maxim,externally-enable;
+		};
+
 		max77620: max77620@3c {
 			compatible = "maxim,max77620";
 			reg = <0x3c>;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
