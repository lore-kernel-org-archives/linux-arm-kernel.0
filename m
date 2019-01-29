Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED753C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:30:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE3DF214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g4DV2VFB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="oRxaqqQR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3DF214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=c1rBf3V5Wkj90QA6EJTNd06EFQSD57cufja865iBZSE=; b=g4DV2VFBLx2K2f
	QFfjzj9NgWAV34UbivGUsFn8ka4ZHJ5Q77a9HHKVkJzHnLzlDV2UTajAZgktseCIxDqeCO+kJdDB1
	JU4ZPzrqGAO3Wodyl3uuAZC7n+F6qiRMkmQHOwyQCq0IIp2IAwbZc93MqGdqDwF8eZA1lInJq16Sf
	LTKKayNE4OER66o5dzbLhd6uI7oLT4jq81tH9L6RnWccarDCjq2wpHq66mHn7HRTDfUbmXIh+lkwo
	ksQ3Q2V0sb5jtcdGLPW82uyL77f8RMCnhfKGmYdMc3J+1jRP5qzwXLb7axk5XfHwnxip6KRDVA2XT
	PQNv1U20eDsiYl1Welkg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goPiN-00078L-Fp; Tue, 29 Jan 2019 09:29:55 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goPh6-00068X-Gf
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 09:28:41 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c501cc50000>; Tue, 29 Jan 2019 01:28:37 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Tue, 29 Jan 2019 01:28:36 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Tue, 29 Jan 2019 01:28:36 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 29 Jan
 2019 09:28:35 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 29 Jan 2019 09:28:35 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw01.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c501cc20003>; Tue, 29 Jan 2019 01:28:35 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>
Subject: [PATCH V3 4/6] arm64: dts: tegra210: add CPU idle states properties
Date: Tue, 29 Jan 2019 17:28:21 +0800
Message-ID: <20190129092823.24983-5-josephl@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129092823.24983-1-josephl@nvidia.com>
References: <20190129092823.24983-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1548754117; bh=2bAE2TFa23HscVFAfxOhYaDup4svaBcvFeGwLO9+yjc=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=oRxaqqQRA7Cf0JSraeNsor+Sb4miQ9DmsWqa4HWnAz+eRlB4fQf9WINUQ5nhrVonB
 gYKkd1918xn39sN8vDDi1pb1sykKrxPCJwqZ5GuYcxGYMmZOF2ahH3hUyLeOdKrH7r
 575dCVTmJfRCEP4Zbj+5aBZ+PmoGFQinYwcuufsfM6QFNJ+IUD7QF64kQ6H5lkRC5x
 tY1qVwJwes/xTIjwQfWodT4TGlWu1a0vBEDldW2wwM1f4K+IbBnPWjaWMted0bSjEM
 h7uk6Yl3ElDV9O3C7y00tH9dEvAcm4gwrucOJXFiFZk3Hd0yISdEpL5LY6oMyMOEUW
 vJ2po/uHzf3cQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_012837_053653_0D047E81 
X-CRM114-Status: UNSURE (   7.93  )
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

Add idle states properties for generic ARM CPU idle driver. This
includes a C7 state which is the power down state of CPU cores.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
v3:
 * no change
v2:
 * add entry-latency-us and exit-latency-us properties

Note:
This dt patch depends on the DT changes in below series.
http://patchwork.ozlabs.org/project/linux-tegra/list/?series=84380
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 2b387364afc3..75534692604c 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -1318,24 +1318,43 @@
 				 <&dfll>;
 			clock-names = "cpu_g", "pll_x", "pll_p", "dfll";
 			clock-latency = <300000>;
+			cpu-idle-states = <&C7>;
 		};
 
 		cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a57";
 			reg = <1>;
+			cpu-idle-states = <&C7>;
 		};
 
 		cpu@2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a57";
 			reg = <2>;
+			cpu-idle-states = <&C7>;
 		};
 
 		cpu@3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a57";
 			reg = <3>;
+			cpu-idle-states = <&C7>;
+		};
+
+		idle-states {
+			entry-method = "psci";
+
+			C7: c7 {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x40000007>;
+				entry-latency-us = <250>;
+				exit-latency-us = <100>;
+				min-residency-us = <1000>;
+				wakeup-latency-us = <130>;
+				idle-state-name = "c7-cpu-powergated";
+				status = "disabled";
+			};
 		};
 	};
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
