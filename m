Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C96C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:26:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A35E721726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uGJoiIK2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="AZ0iYK2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A35E721726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I0PqEr4QBcNPme9PslF0GjEFt/W/Dy0Wp6OYO2+36lk=; b=uGJoiIK2qtFd9j
	QD+cZaqA7tYx/xqp14exKhP/LtNnliuz5Bw9YOxFGhVGJRnTgy6WnfeOAdHmuEap3WkqcwsCJ9qvS
	X4DTfrObwzvSOTrY+qY/yR+M8EkhMChBsW1Xnwz0IKuyG78DToKuCFCGkG3OoUD14+Yomcf37VaHv
	HjICmmwTjvIXdI48DQeonTt+l0sYsSkIBdgfC+Kma2cUO5G1zW6dVVECAvJ9ISdzw1xb1hCscDZAv
	lWK0U1T3gikcvweDfshEOJA7a7s/tZylmkToI7K3IZqL7VoJhfCEf7dFtT1IHVXXBysKRINiP42iC
	nFZdMSQaD2cGORZ98PIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpbdi-0003Zp-55; Fri, 01 Feb 2019 16:26:02 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpbV1-0007K4-BI
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 16:17:16 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c5470d40000>; Fri, 01 Feb 2019 08:16:21 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Fri, 01 Feb 2019 08:17:02 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Fri, 01 Feb 2019 08:17:02 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 1 Feb
 2019 16:17:02 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Fri, 1 Feb 2019 16:17:02 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw01.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c5470fb0002>; Fri, 01 Feb 2019 08:17:01 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas
 Gleixner <tglx@linutronix.de>
Subject: [PATCH V6 1/7] dt-bindings: timer: add Tegra210 timer
Date: Sat, 2 Feb 2019 00:16:48 +0800
Message-ID: <20190201161654.18315-2-josephl@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190201161654.18315-1-josephl@nvidia.com>
References: <20190201161654.18315-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1549037781; bh=+dXRnUtcTsODwjanf23HZBenZ6P0mneirWKRIxLEdPM=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=AZ0iYK2LYDjg2ipjYHbTb5GRNbdY0iabySjC1oWXrAwULcv8twNz4qNWx8a3nWnHO
 qyv3tlIHAbTdSKi7NVuUm7CyLrgDXr/HYe7sl8Wm2l2g0kNMDkTjGjjW9wY49FVNtn
 4Gh7kilGQKBr2awWarqlqZ9nvrrSEPSwaM1bl82mVHjG2JSdcQbCQRlM3H/20ERTMj
 qcWF0WfcjFFBkd+B79kISMZnwnrGAmuuWX3dj0sNPraZ8/sviPqX+8TB/9ABNuO+aX
 SVtQ8eS6IbaH7eMft66dFwKoGaYBZGEYzOmhQdmknU5OhhNI1Vju4bQTAT2O7Qft0F
 JQryrqfuKbN6Q==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_081703_711874_B7F0A83F 
X-CRM114-Status: UNSURE (   9.24  )
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
 linux-kernel@vger.kernel.org, Joseph Lo <josephl@nvidia.com>,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The Tegra210 timer provides fourteen 29-bit timer counters and one 32-bit
timestamp counter. The TMRs run at either a fixed 1 MHz clock rate derived
from the oscillator clock (TMR0-TMR9) or directly at the oscillator clock
(TMR10-TMR13). Each TMR can be programmed to generate one-shot periodic,
or watchdog interrupts.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Joseph Lo <josephl@nvidia.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
---
v6:
 * add ack tag from Jon.
v5:
 * no change
v4:
 * no change
v3:
 * no change
v2:
 * list all the interrupts that are supported by tegra210 timers block
 * add RB tag from Rob.
---
 .../bindings/timer/nvidia,tegra210-timer.txt  | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt b/Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
new file mode 100644
index 000000000000..032cda96fe0d
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
@@ -0,0 +1,36 @@
+NVIDIA Tegra210 timer
+
+The Tegra210 timer provides fourteen 29-bit timer counters and one 32-bit
+timestamp counter. The TMRs run at either a fixed 1 MHz clock rate derived
+from the oscillator clock (TMR0-TMR9) or directly at the oscillator clock
+(TMR10-TMR13). Each TMR can be programmed to generate one-shot, periodic,
+or watchdog interrupts.
+
+Required properties:
+- compatible : "nvidia,tegra210-timer".
+- reg : Specifies base physical address and size of the registers.
+- interrupts : A list of 14 interrupts; one per each timer channels 0 through
+  13.
+- clocks : Must contain one entry, for the module clock.
+  See ../clocks/clock-bindings.txt for details.
+
+timer@60005000 {
+	compatible = "nvidia,tegra210-timer";
+	reg = <0x0 0x60005000 0x0 0x400>;
+	interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&tegra_car TEGRA210_CLK_TIMER>;
+	clock-names = "timer";
+};
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
