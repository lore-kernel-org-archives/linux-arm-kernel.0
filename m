Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0503C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:50:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90B93217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sBbSEVVi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jn+3IyUk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B93217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=zYYmWW9thNm5LfhbXJv1WJOVTbkt3LFt6p+m/10m4RI=; b=sBb
	SEVVijs3KWof6EYvpCLBM7mhfZWGJ9RMkTiIBR9jzRFQ2fCJDXfKxpT45wVXrsIn97GyIzdWLBs/I
	fbPZxlGS9sM7BFHRp+GcUgIRWiAoD2f1Bc151BD0NcYOglVi90vEHRgs1g4xCNx5qQvmR/3tEVIt1
	o4zW+AA67oV7F2tw3OV4QGu/k71tB20fQIRKyb7NKFoCl2P76lMpUMoJYiqV+ZkDbFQmwGLutXjiI
	y21xXySP8MoCJ8nxVIj+n82gEQtws3+n0xUqkJ//PfdNdeuZxk3t5GVd5F26EhLracg8LLDu8UHYM
	7/s/EXfNBBc/3ceTcLoywJAMh+YLHTw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gybFy-0007lh-Pk; Tue, 26 Feb 2019 11:50:42 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gybFv-0007l0-WC
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 11:50:41 +0000
Received: by mail-pl1-x644.google.com with SMTP id k2so6141361plt.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 03:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=eSkZIpYqGQu03MiKs/ZrVx2wlOErDr8e6IcNNsqO99g=;
 b=jn+3IyUkPCgt6Y9fYP/1P9P6y3OtmQN1UUVR8aQBn/6/CUbfGr6eDU9bK8G1y5mH1u
 YH0iRITGECDfaksFLsgjc1P+xmmRm4XD5uJi2kjDW0/JxNjlLJMdQPCRyrvzR16VlfkI
 IpOWwSkrP8lJFHm2gBZ81fgrhiCkgEOWm2DMraGsyXxZYzUc8ipVPYCZru5yKeTuViuV
 8y4iqLEe73qSgo3PGt2DxKMRdL3FpICTvKBsE5i1kWLraMJOWWPPiH5sbrF7kKxj9DCO
 mVUAFA9Kmp1mrdT+mS9DP/cXIrXYTA2mJA4Vm8xoeiOGdkJRdPYKdmhIJCu7DNg2Qycq
 W8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=eSkZIpYqGQu03MiKs/ZrVx2wlOErDr8e6IcNNsqO99g=;
 b=l+XSdeqmMBYrXRqzSIf85iS+hCb2ndHSJ7kUUz0kzt5eOCtf9+D3xJC5AM9gzkD3bp
 OPHT7NdlBTuRVtwEwLzpKy+0FPOprWIPk/JIe6lsSVDE3TFvFX8WpamrNWhJi+jVEcc3
 fsbh0MvzAMjLwdxzvdefU/mSxBDSNRewr63x4l1VK1Pl+XGPaTa/tyFvZ2+qyFvBdDnP
 jWP9gWe9KmDhURchwu2BankgEUNj5WjlHtRNr2KcU6FB3OVtTAJzRsR5wfTmUlu45v0a
 Z6slgVRt1+FBVhXdq6fGCMWq7vHjs919eSyrRasqUvoTZvWPzEo9o+EsqMZ8N+xJByiI
 KFNA==
X-Gm-Message-State: AHQUAuYEmJbujAmEAU1SDUx9sxQN9NYvwvW0/Mhi2kiqlr73Ztl3BHU2
 httA/R/Szsp+Zw8XVbJ0VpLaq1kn4Q==
X-Google-Smtp-Source: AHgI3IbMRmWyU2xURN7gN6VP/kb7Gu3EWjq2THo2Me64kHFXAFlyQhThTRuXcqhA3DRUAYTzCy9exg==
X-Received: by 2002:a17:902:63:: with SMTP id
 90mr24826573pla.122.1551181838281; 
 Tue, 26 Feb 2019 03:50:38 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7288:2b3b:d5bf:2058:5f56:d25e])
 by smtp.gmail.com with ESMTPSA id t10sm31639245pfa.151.2019.02.26.03.50.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Feb 2019 03:50:37 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linus.walleij@linaro.org
Subject: [PATCH 1/2] arm64: dts: bitmain: Add GPIO support for BM1880 SoC
Date: Tue, 26 Feb 2019 17:20:21 +0530
Message-Id: <20190226115022.19022-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_035040_041785_952FF274 
X-CRM114-Status: GOOD (  10.20  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, darren.tsao@bitmain.com, linux-gpio@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 haitao.suo@bitmain.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add GPIO support for Bitmain BM1880 SoC based on Designware APB GPIO
controller IP. IP exposes 3 GPIO controllers with a total of 72 pins.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/bitmain/bm1880.dtsi | 54 +++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/bitmain/bm1880.dtsi b/arch/arm64/boot/dts/bitmain/bm1880.dtsi
index 55a4769e0de2..e4da4ec6a5ee 100644
--- a/arch/arm64/boot/dts/bitmain/bm1880.dtsi
+++ b/arch/arm64/boot/dts/bitmain/bm1880.dtsi
@@ -80,6 +80,60 @@
 			#interrupt-cells = <3>;
 		};
 
+		gpio0: gpio@50027000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x0 0x50027000 0x0 0x400>;
+
+			porta: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				snps,nr-gpios = <32>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		gpio1: gpio@50027400 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x0 0x50027400 0x0 0x400>;
+
+			portb: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				snps,nr-gpios = <32>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		gpio2: gpio@50027800 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x0 0x50027800 0x0 0x400>;
+
+			portc: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				snps,nr-gpios = <8>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
 		uart0: serial@58018000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x0 0x58018000 0x0 0x2000>;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
