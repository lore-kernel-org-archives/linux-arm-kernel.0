Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E918CC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:55:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B3712082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mwd99I0e";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vYm88F++";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="L/M/Sj8y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B3712082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s2uATdJquzbjaNJXmBTA4heExU7rTigQQB3i+Zh35oU=; b=Mwd99I0eQZNPDx
	t8YIkF+InjWZRvFDbO55R9zFjYTd+gYswOaaVb1VkvrfaroByrnoTS8Al+Hf8B+S9ePacnuqSiRUU
	k1RKeXn0dhpau+MuPjPFsRmyC9r1M9P7O8F2E2pC2ocvw07q00R4ewLWQRJ1F9sQzLQbbC8lNFkkf
	4M6xrM+NeXYYjvTQmVVwHpNZBItiHBxNEPV0+L9JVEI2lwZ0NGQK8lDo5KexBmNHO4RjtFMcTatJd
	l9MZHB9hVhb0mb2ABmdiv/KILx7ZNJXJhvKzrmatPo2Lgcm/nsb/PYJ9qOA4xo7nspTM6WQVGNxsA
	8MpVkGBGSImr6lgJFaXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU7Qf-0000sF-JQ; Tue, 04 Dec 2018 09:55:45 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU7QL-0000Sp-Bu
 for linux-arm-kernel@bombadil.infradead.org; Tue, 04 Dec 2018 09:55:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kpTaO/fqNYDNOAC7geVVmnzlQpoAANJs9ytAihdlyS8=; b=vYm88F++gJZbWp/tf/QOt3zLr2
 ttQ3NzxG7VYlysMFDhybPGc3vMTJob83aiOIRHYWMbc3P/9rZFsE4f0f4L6zQ9IGUu1putzqVp5eH
 9XSzHyVNl56N8maeVpu7RQ5t494VCI+EFXUyTYrrlAzQnbPbfGOxuRIXoVpfqtGOOi6gzwv4s5wmE
 ngw+5o9y8TJfqhCHG6HeN575/av/5xnGaPhpJj/880DKH2tgwCIXMb04Z/3myVBCcNtntwadDpV/q
 2o0FZn7Zci+yuXPeL7QmyEQ+3i32JK3aeg5JklchSC9uWYEsYNumh23ljDPaPd6vdItqUvAK520vj
 It4cJaiA==;
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU6zD-0008RU-K4
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 09:27:24 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c06486f0000>; Tue, 04 Dec 2018 01:27:11 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 04 Dec 2018 01:27:12 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 04 Dec 2018 01:27:12 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 4 Dec
 2018 09:27:11 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via
 Frontend Transport; Tue, 4 Dec 2018 09:27:11 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw02.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c06486e0004>; Tue, 04 Dec 2018 01:27:11 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver
 <pdeschrijver@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH 16/19] arm64: dts: tegra210-p2371-2180: enable DFLL clock
Date: Tue, 4 Dec 2018 17:25:45 +0800
Message-ID: <20181204092548.3038-17-josephl@nvidia.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204092548.3038-1-josephl@nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1543915631; bh=kpTaO/fqNYDNOAC7geVVmnzlQpoAANJs9ytAihdlyS8=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=L/M/Sj8ynTEjWxtRYYC+DvSLPLqJIwVBR/+z2+5YgHvDfCie3hWgOP5s9hG9bSAKF
 DMsO1Z/OlMGKiFT0KmdaIyXdDeQd5Oef0UgfT/UVn13djqTfIvgKXRIUbrPEFV4U9o
 YMULr8dWNgvVpj6WP8m5emlQn6mCyg7KTySmVmmfj3XxFWdPMAJob3dBrz4jqI27j8
 L8cTyLoFwwaSgyeSuMpOIi/b1dxJfACPjl/CRwfCFG/iAfUYpJlExn4Xnrtr3TqeLz
 5FT+QafRII6Mfg4Cne34+oc2wldACI4JTZvh5WddXmfnbt4n6nXdZLejOulqGw7tia
 pYnJoak+8bVVA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_042723_805806_11EB70BB 
X-CRM114-Status: GOOD (  10.82  )
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

Enable DFLL clock for Jetson TX1 platform.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 .../boot/dts/nvidia/tegra210-p2371-2180.dts   | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
index 37e3c46e753f..53f497c2b3ff 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
@@ -78,4 +78,24 @@
 			};
 		};
 	};
+
+	clock@70110000 {
+		status = "okay";
+		nvidia,pwm-to-pmic;
+		nvidia,init-uv = <1000000>;
+		nvidia,align-offset-uv = <708000>;
+		nvidia,align-step-uv = <19200>;
+		nvidia,sample-rate = <25000>;
+		nvidia,droop-ctrl = <0x00000f00>;
+		nvidia,force-mode = <1>;
+		nvidia,cf = <6>;
+		nvidia,ci = <0>;
+		nvidia,cg = <2>;
+		nvidia,idle-override;
+		nvidia,one-shot-calibrate;
+		nvidia,pwm-period = <2500>; /* 2.5us */
+		pinctrl-names = "dvfs_pwm_enable", "dvfs_pwm_disable";
+		pinctrl-0 = <&dvfs_pwm_active_state>;
+		pinctrl-1 = <&dvfs_pwm_inactive_state>;
+	};
 };
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
