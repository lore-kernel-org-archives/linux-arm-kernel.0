Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E83C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:24:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6F83218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Zcw8e+kn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SzoX7d+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6F83218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Ud46xlID6/1MOAlk5IAWoC0WU29DTeksXQbJTSIPlx0=; b=Zcw8e+kno+UAkkOF31SPhlXMIb
	YHq2JJI+OjFRtIb7yacmaOwi19sYt+Vk0pC4OooYUP1r5a73kKPZxw4rKrY+A0jd/Z/SSEG1Wx8lS
	6DeSUfHiwE5OB3lQdLaTCx+PaN0KKA77E5uOOj+wXUUt1vp5i25PQ5hWOMXUd72vHEpfgxbDVqCXx
	rKHH06qbATDawcOL2NEQmZ2RuY13CHqBnqOo5gxil9SZJxUL1s7cfO8ZTG70uhO7iBoCJkKPbgdLN
	l6vq1epFyo/tygYb0bzKA7r0PnK+Z9gnwPfrhmRoCzle4Tp0Sv3bCZFsEm2+Bd/Z9gfpii+dd0pcp
	rlYwVr3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmlYO-0005zZ-Mu; Thu, 24 Jan 2019 20:24:48 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmlYE-0005pV-AZ
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 20:24:43 +0000
Received: by mail-pg1-x544.google.com with SMTP id z10so3155441pgp.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 12:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=o5vW46nrjFVoZsnMcgT1mEReDdf43fF1J2psQEiWFOU=;
 b=SzoX7d+HKT5NucVKzZ22vuD4IMyi0BUeNEq+nZsXxgjwCVzKVfDBPnrJjg9VIXt4FV
 ESbJQqmYfE47OwYqfFizlKN95G5CdKqjuagakR0MmwNaLmoQCmTUvHdmuWZS+VbPhetq
 hQUngAFjUQ7/6Zm468Hmlhpzg7Q3xIUJTjHrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=o5vW46nrjFVoZsnMcgT1mEReDdf43fF1J2psQEiWFOU=;
 b=NvB1PKzsACudkPa15Ej4ogETAEU6cmmHCOD9lrcpeyAMZ+Sj2icdlI6RTlD/82BOnf
 Bv6AIOWbTOTaNGRSp4EkGbJboxzbXGTHNznHpYbmndhFlg4ysgZb9+HToDgaTu1yCZBp
 AMEodNVbZAS+1daIdnywzkAfsi0yxwYvSrI64MNDDWr3wSDA67nAsKsmghsAyPSNfEe8
 yGahgPpe18S/ZyUfrHwSyJvG12cygEgopX5kmkY0KsaUI4AXVNPt1kCjl26P639iwF8D
 RhS8SLx807bfzOLwQpfcl3lWo1oZzGG0lIZ1AFxw/w3o71/bWyzjE0r8pkBv40SmwSzr
 QT0Q==
X-Gm-Message-State: AJcUukf0QlNBgwsLPiQY+kZcTVznwVxkvOklsNNCkTwtt9sjxk3RUEL5
 nKrf1eMABBd0oOFcu5qT3oliRQ==
X-Google-Smtp-Source: ALg8bN53AUnDLmlfA5CanT+1yUS8gKuszSeTS3DYr7MsI/bOcmzSj4lSCbjz6YablM37qmPTUwrN5Q==
X-Received: by 2002:a62:37c3:: with SMTP id e186mr8138281pfa.251.1548361477400; 
 Thu, 24 Jan 2019 12:24:37 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
 by smtp.gmail.com with ESMTPSA id
 c72sm45263309pfb.107.2019.01.24.12.24.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 24 Jan 2019 12:24:36 -0800 (PST)
From: John Stultz <john.stultz@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/8 v5] arm64: dts: hi3660: Add dma to uart nodes
Date: Thu, 24 Jan 2019 12:24:21 -0800
Message-Id: <1548361463-28372-7-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548361463-28372-1-git-send-email-john.stultz@linaro.org>
References: <1548361463-28372-1-git-send-email-john.stultz@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_122438_990420_CA5AA472 
X-CRM114-Status: GOOD (  13.48  )
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
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
