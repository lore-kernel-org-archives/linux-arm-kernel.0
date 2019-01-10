Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C3FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:35:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5179208E3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W+wbkCUj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SWCvuoSn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5179208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=gRzgCoG/fx4k8sE7IAQxnjgPUZpObgvSOSNwNW245ks=; b=W+wbkCUjJyxH9bkB0I8FOWEUJk
	JaBu/Xc/G791LZD6lNieE0xng38NhRSL0RYk2FXMFjFd9UqiYsmMB4huaz1YmUZbBkF1Ser2vbMFl
	6v9G1VObaPaHVyYwsDZI9fO7h97fPmGRiqzqdjKc6z4b2MZSS+nwlUaYhTpwfnHoK0HDmMwc+NQKr
	ehr3Zh/4YbnBPnI7v4D9LUH8CM3R4PTkjjlpTmd3wE0Y92wQAB9puqVdXO4CT6XfCKQfj3BFU6Tzk
	weMrR0Tj0WkzAZLKGYkaHRAHbhgQ7la0CAalHoC39/lXbPDjT3mW4cNKmnaPzm6D81MZykWD/4ZIL
	Ks4x+m2g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gheEP-0007Gx-A0; Thu, 10 Jan 2019 17:35:01 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gheDp-0006gk-Ej
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 17:34:33 +0000
Received: by mail-pg1-x541.google.com with SMTP id d72so5095875pga.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 09:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=VnxmDmWRiHgP8rQwZAnpNW6+tNuZ3Gwc75mIp5vRAak=;
 b=SWCvuoSnfQU8l4XA5RnQA4Xo85TwZCLQhNPOOlMXlpaSh1JIEkFmqrLaT4JNvUSEYS
 6StZRSA+n1lJ0bk+PUSx6ANXLkFjSLSFjSHlgSAWpiaoZcwnazcC+08U0ncm9ALhZg7T
 Y3eLnSwq4XG0sX76Evoku9ko3752RGhLLn/TE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=VnxmDmWRiHgP8rQwZAnpNW6+tNuZ3Gwc75mIp5vRAak=;
 b=LxXz6dmJlJ7CdKqae10wrQopvtoodjbwu/E9RI+ZKLuOaUHGExzYMjAr4B25m6qOYx
 oSJ7sKy/m4hqb9j1ud5GE0IZ/GzVn3UvNFvXnTCEFA4RcyOCR0tm6OFvsQa/XLCdl0tu
 3QzeN05RCokknMRNEuhirlmRW+NYqG4wKKbOLjq+ny4YTnw22ShqK1K/J1DxuQS8fuSW
 6WLqgJqcrYN7o783SdzaOkIuraE0bAaUxRDMAzbfj6CgA0l431vW2OLELXgusedvs7MP
 eKGwtJ0QRoaT7PF9sdUHXql3rVnHX0EnLfSDXbb4hEtwrftknufw/XA0hAiMlsjwv5pZ
 8GIQ==
X-Gm-Message-State: AJcUukfmSKmSlJvI8/tRLJlo01Alkoz35n/prYdxU7FiSzuzD6eErdA9
 STTli/v2jS/fiJr5QHm/x4AsHg==
X-Google-Smtp-Source: ALg8bN7XMfJIwJKKEavHsyAPlj4ivJhbI8iuWSsMXERF6VzGFeaZYQ1YqIKBRD4Wcncg2T0UDK0ewg==
X-Received: by 2002:a63:1a0c:: with SMTP id a12mr9993920pga.157.1547141664636; 
 Thu, 10 Jan 2019 09:34:24 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
 by smtp.gmail.com with ESMTPSA id
 k15sm125977409pfb.147.2019.01.10.09.34.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 10 Jan 2019 09:34:23 -0800 (PST)
From: John Stultz <john.stultz@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/8 v3] arm64: dts: hi3660: Add dma to uart nodes
Date: Thu, 10 Jan 2019 09:34:10 -0800
Message-Id: <1547141652-8660-7-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547141652-8660-1-git-send-email-john.stultz@linaro.org>
References: <1547141652-8660-1-git-send-email-john.stultz@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_093426_081533_485896E6 
X-CRM114-Status: GOOD (  13.91  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Ryan Grachek <ryan@edited.us>, Zhuangluan Su <suzhuangluan@hisilicon.com>,
 Tanglei Han <hantanglei@huawei.com>, Wei Xu <xuwei5@hisilicon.com>,
 Rob Herring <robh+dt@kernel.org>, John Stultz <john.stultz@linaro.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Try to add DMA support to the uart nodes following
the assignments made in the dts from the victoria vendor kernel
here:
https://consumer.huawei.com/en/opensource/detail/?siteCode=worldwide&keywords=p10&fileType=openSourceSoftware&pageSize=10&curPage=1

Cc: Tanglei Han <hantanglei@huawei.com>
Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
Cc: Ryan Grachek <ryan@edited.us>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v3:
* Remove dma enablment on uart0 which would use reserved channel 0
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 20ae40d..4c8d682 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -478,6 +478,8 @@
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x0 0xfdf00000 0x0 0x1000>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+			dma-names = "rx", "tx";
+			dmas =  <&dma0 2 &dma0 3>;
 			clocks = <&crg_ctrl HI3660_CLK_GATE_UART1>,
 				 <&crg_ctrl HI3660_CLK_GATE_UART1>;
 			clock-names = "uartclk", "apb_pclk";
@@ -490,6 +492,8 @@
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x0 0xfdf03000 0x0 0x1000>;
 			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+			dma-names = "rx", "tx";
+			dmas =  <&dma0 4 &dma0 5>;
 			clocks = <&crg_ctrl HI3660_CLK_GATE_UART2>,
 				 <&crg_ctrl HI3660_PCLK>;
 			clock-names = "uartclk", "apb_pclk";
@@ -514,6 +518,8 @@
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x0 0xfdf01000 0x0 0x1000>;
 			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+			dma-names = "rx", "tx";
+			dmas =  <&dma0 6 &dma0 7>;
 			clocks = <&crg_ctrl HI3660_CLK_GATE_UART4>,
 				 <&crg_ctrl HI3660_CLK_GATE_UART4>;
 			clock-names = "uartclk", "apb_pclk";
@@ -526,6 +532,8 @@
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x0 0xfdf05000 0x0 0x1000>;
 			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+			dma-names = "rx", "tx";
+			dmas =  <&dma0 8 &dma0 9>;
 			clocks = <&crg_ctrl HI3660_CLK_GATE_UART5>,
 				 <&crg_ctrl HI3660_CLK_GATE_UART5>;
 			clock-names = "uartclk", "apb_pclk";
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
