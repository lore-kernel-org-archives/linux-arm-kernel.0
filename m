Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E629C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:43:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0385C2082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AKuxWacT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ayQN/xuh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="SSkXZSQ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0385C2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mCulqAnjpzLyaAgmEdRtI1WJRx6io8QXGJS3mr0LTFc=; b=AKuxWacTJvGq8C
	ybteXHYeB1msh9be8w9swfwjRK1QogleOeQiZSLWZp7uq7rsw1/eYV0/U+Hfn7ledzyxM8HpsWUIU
	dpRJIXc+7ksqoPwvpwECzC7ZGp7qRwGPGmR8eYyuJj0/ROFDZKExec4b+pWJSMcOg915YCUHvOVGm
	+XgNXvEh9Vn2/UDzvhQFb2twv5Jmz7jxRkw+ksDgliwwN8zI8Hhxhexiq7UOmp6afxwiTp5zsuzxJ
	cdWe+voxy/3a22jKNPhS91RXTnzkb3dDhErLOnLAIgImLFqT/pA3Xs7e65SCBz91IUS1yZSzj/All
	ubOMlZf+9eOz7VNO7hMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU7EZ-0001P3-4k; Tue, 04 Dec 2018 09:43:15 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU7EP-00013a-CB
 for linux-arm-kernel@bombadil.infradead.org; Tue, 04 Dec 2018 09:43:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0iBfIoTpjMNvTe2HiUitSTQD9qacFKjCr8+8R9poNCk=; b=ayQN/xuhu2EOHQmcv0bmXPKDoD
 jcfl3phsgCI6yJW2l1pAfhqwZUM6HXI0Q47ESRH9Qda/GH8wcLeQw1xBhW+oAnQ24C5fkYfQj5UlY
 LatpxptaTFhkdlbz8S1Wj6SfdE0lY11X5I/j6cqDzJ9GTygey+0vw81FnQ8sUmOt3zAx3Aju/GZ7L
 Y+nyGmzDN7H+Hb/kUuDjTJilEw0LhwbUaH769ysvsnIgQ6V5mIvQBYYIzk66qVxMjWdoL7hyIHRlS
 fteq1qj+hxFIKiRx7T/JUk3Igjl/buitp9VaXUzoG4WwtlLEg0FA3D2RMmZ86N862dDxe5A5UinCN
 eb6lhkxA==;
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU6zE-00086F-QY
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 09:27:26 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c06486b0000>; Tue, 04 Dec 2018 01:27:07 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 04 Dec 2018 01:27:04 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 04 Dec 2018 01:27:04 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 4 Dec
 2018 09:27:04 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via
 Frontend Transport; Tue, 4 Dec 2018 09:27:04 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw02.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c0648670003>; Tue, 04 Dec 2018 01:27:04 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver
 <pdeschrijver@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH 13/19] arm64: dts: tegra210: add DFLL clock
Date: Tue, 4 Dec 2018 17:25:42 +0800
Message-ID: <20181204092548.3038-14-josephl@nvidia.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204092548.3038-1-josephl@nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1543915627; bh=0iBfIoTpjMNvTe2HiUitSTQD9qacFKjCr8+8R9poNCk=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=SSkXZSQ2ZsimgKoNgScXLZ7XpKQVdO2Xl4319RiUTqPIfdtxqVno7oj6LXXsfGNQf
 K4lPY+XI9SB415QCkr8y6yssJnneY8VNxQoNs9VTSY1JVQb+GJ7C/ZxZhx4n1vyTZe
 CVgTkZ19ADbCCb1qICJo39arSy6j34Dki4wZHso8RZtPz24hDsFbaMfwzGkYoyUd7A
 gHBzQKXhUrfn31t/llAxDckEKETqsgaR6w+FFxaGg6+x1i3KHlT/kijU198YzxPKvY
 yFSTMa0IzEsN3ThcY2VVYuD5XkrhUFtxhVSkElfVdhm8LsdJD/Q4qDZesQCxf1njgA
 56T1Fq6WaW4Eg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_092725_184644_96467B91 
X-CRM114-Status: UNSURE (   9.64  )
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
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
