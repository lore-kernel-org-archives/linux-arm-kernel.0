Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF39C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:23:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A2AB20838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VIg8r9N4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ng8z7cxy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A2AB20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=M8AlxTn4bu0rnErMRaK0HSP3sGfAJDWZ1f2h/nSsO7s=; b=VIg8r9N4G3oCCw
	LFtn0g6WMqSBe3ReHpcc91qtHmAMyxSY8IuykkB4BVhMzinHge/ypq6nRiykmBVLt8sUgL7BhElxq
	Q5wz3iMRKYe6e0fh/d8ZToM/LQx/BFKhJcTnKK5ux9jYbgRC6YaWEh6F21cxsCALML45JegNeNM7/
	HOS0DQ+qoaB4g2f+UL3sAoPXIKxZQ/frcKjFwzbupnSR1e0urmtv+XaOG4yhAGIRZVMFVPovyahpC
	R9+TzDrjxm81tbiiw6nDcpcvYQBC3+Es4JVvbdVA7HhnoUoBFgEx2zHooyMJYXKZ6+PbU1gqOwmOg
	sTsblETLzAUDcjdqFlVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwihD-0006uu-Vj; Thu, 21 Feb 2019 07:23:04 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwigI-0005p9-Ob
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 07:22:09 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c6e51a40000>; Wed, 20 Feb 2019 23:22:12 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Wed, 20 Feb 2019 23:22:06 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Wed, 20 Feb 2019 23:22:06 -0800
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 21 Feb
 2019 07:22:06 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Feb 2019 07:22:06 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw01.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c6e519d0000>; Wed, 20 Feb 2019 23:22:06 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas
 Gleixner <tglx@linutronix.de>
Subject: [PATCH V7 5/8] arm64: tegra: add CPU idle states properties for
 Tegra210
Date: Thu, 21 Feb 2019 15:21:47 +0800
Message-ID: <20190221072150.4395-6-josephl@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221072150.4395-1-josephl@nvidia.com>
References: <20190221072150.4395-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1550733732; bh=Krx9tvdK8mQ7TQM92OcKajbqr0b518YrQWvANYWEcRI=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=ng8z7cxyH1l6eMNTRE9LgCFwFXhZ+5elSU5uBck2vP1VXnABZqkBrl7/VpI/ci7OM
 NVoonpW9421HnMP1DANcvpgD9obXvLH/PR/RcaNei4Zojdm4PamBQ4X+9RJ0qXuWH+
 pPFLRda38iD4znM3M7K9LpgfwoxmwG3+8w26FIFWpJoOukRSfTOmAprAhcKr9yhpcs
 ClTsFwocRg4AY7XmaS5ILxFB6ImWFJh6e7bJpG3x6IdfK4YX+u7e59dl6rMZOf0nNH
 9dfA8ryyxedZv0AQxJkXH21mmJ7GlEmLJNfiLS3n9wqEWEb4wr7LJIOkWEwHhxqbJv
 lMMrmVhNv8G8w==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_232207_253771_AD598F89 
X-CRM114-Status: UNSURE (   6.93  )
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
includes a cpu-sleep state which is the power down state of CPU cores.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
---
v7:
 * s/C7/CPU_SLEEP/ & s/c7/cpu-sleep/
 * update the timing of 'entry/exit-latency-us'
v6:
 * add ack tag from Jon.
v5:
 * no change
v4:
 * no change
v3:
 * no change
v2:
 * add entry-latency-us and exit-latency-us properties
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index abbb686bd8ba..79cedd36ffad 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -1371,24 +1371,43 @@
 				 <&dfll>;
 			clock-names = "cpu_g", "pll_x", "pll_p", "dfll";
 			clock-latency = <300000>;
+			cpu-idle-states = <&CPU_SLEEP>;
 		};
 
 		cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a57";
 			reg = <1>;
+			cpu-idle-states = <&CPU_SLEEP>;
 		};
 
 		cpu@2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a57";
 			reg = <2>;
+			cpu-idle-states = <&CPU_SLEEP>;
 		};
 
 		cpu@3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a57";
 			reg = <3>;
+			cpu-idle-states = <&CPU_SLEEP>;
+		};
+
+		idle-states {
+			entry-method = "psci";
+
+			CPU_SLEEP: cpu-sleep {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x40000007>;
+				entry-latency-us = <100>;
+				exit-latency-us = <30>;
+				min-residency-us = <1000>;
+				wakeup-latency-us = <130>;
+				idle-state-name = "cpu-sleep";
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
