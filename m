Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313BAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:36:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0356020656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E7PWiXwq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aHQTYI+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0356020656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=0PQuKgdABK6a/uP36p0j2XVTIPjtySDAsh2d8pcszoI=; b=E7PWiXwqjoYcuvuvZNM+VYsuna
	axO9X4CVi+EB3WRO5f6Br8Qp1bQFu3Fr0MQrlXIItDSCqZqsDuz0sD3GYtJEuPJo0VR7/Z2GTPqNW
	UdkpTn5S9fCgOAjd+6Xfjtjeei+Mag5nbNMGM7HPyYs05KsUGock25W9ds4HK7bRUP/w+9JyH6Qs8
	Mjb6ifbsELgTMfT/RqLecp3t1+BHwT1GkLTNyC0sgGh4qlnOVI5wWiezNH5o8rSV6RzmvA7W8Bo0U
	VKne1G6lJjwvluERqsS4E9bi0C8RKvzOT+tZR6393rSdinmYsfjwlO1nGr0bhLiJmApsHHEWNDbk7
	6h//ZBMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjFWF-0003ML-4N; Tue, 15 Jan 2019 03:36:03 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjFUP-0000Zm-Gl
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 03:34:13 +0000
Received: by mail-pf1-x444.google.com with SMTP id u6so610633pfh.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 19:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7d6Ogf6N7tz/DtneEdqXk8KBTvb//DmYHP2fab33+vI=;
 b=aHQTYI+MRzBz5YPrG/LcAGSPcHfPmmk8JgMahVC7qUtRr3SLHlSoPsOL1/9/l0o22v
 Wdg1SpJU9kfluxaN/PUDS0UBQm3TSjboUAJJ/uxjdI45PIaemXEP28ED46uaqXA3GZ1M
 2HhefJkl01rthv2vuTQMOTlvsOLtq5JRyDI2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=7d6Ogf6N7tz/DtneEdqXk8KBTvb//DmYHP2fab33+vI=;
 b=t9EpCIa35qM+MjgUp3Vp58P/VJxJY1PW/Y1Pua20CJ8rveZ05EE0eaM6RnauM+/Qz3
 0LbEMnFGkew+cfAaw/zv0t6bQWkNRHalOO3QAWs43KHC5bcZJfhCa1I4CQugzUJTVGKc
 8ppjKBhz0IbAFSNhkA5FmeGMLHshPIvNz/VBbkRwqi+A3fXgWzxBv+RdYBzDOB0hX0/r
 VYlvXeBIc1Rl7i8hNiuHcUUvMdYBN2Es9kkBwGJs/poCcktkgspy9A8LAqrYK81EV9XQ
 JXZ5hkU5HT6seZdeOB6Xqll2T3M0VmK+umcvkrvI2/dcOdc3ai+wsQ0xISTIIUCD+dNA
 6Hyw==
X-Gm-Message-State: AJcUukc7te4Xs9don97bmu/JZpDOuEyVzI/cZ/h2fhpLlx9maZgPROsb
 DIUkJ+6CXU2caabngM3EL5wz
X-Google-Smtp-Source: ALg8bN7ao6X1kcEHeVSPExFQ0KBWu2DSRlw4r5xoQr3MN0o9y/5MIrjkwL+KYhv2XZp3Glc4SIgVTQ==
X-Received: by 2002:a65:6094:: with SMTP id t20mr1795150pgu.285.1547523248748; 
 Mon, 14 Jan 2019 19:34:08 -0800 (PST)
Received: from localhost.localdomain
 ([2409:4072:6084:4813:7cd6:42d1:f14c:3e90])
 by smtp.gmail.com with ESMTPSA id s9sm2137023pgl.88.2019.01.14.19.34.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Jan 2019 19:34:07 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: sboyd@kernel.org, mturquette@baylibre.com, afaerber@suse.de,
 robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-actions@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 2/6] dt-bindings: clock: Add DT bindings for Actions Semi
 S500 CMU
Date: Tue, 15 Jan 2019 09:03:36 +0530
Message-Id: <20190115033340.25016-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190115033340.25016-1-manivannan.sadhasivam@linaro.org>
References: <20190115033340.25016-1-manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_193409_939321_A9820B4E 
X-CRM114-Status: GOOD (  15.53  )
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
Cc: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>

Add devicetree bindings for Actions Semi S500 Clock Management Unit.

Signed-off-by: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
[Mani: Documented S500 CMU compatible]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/clock/actions,owl-cmu.txt        |  7 +-
 include/dt-bindings/clock/actions,s500-cmu.h  | 78 +++++++++++++++++++
 2 files changed, 82 insertions(+), 3 deletions(-)
 create mode 100644 include/dt-bindings/clock/actions,s500-cmu.h

diff --git a/Documentation/devicetree/bindings/clock/actions,owl-cmu.txt b/Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
index 2ef86ae96df8..d19885b7c73f 100644
--- a/Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
+++ b/Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
@@ -2,13 +2,14 @@
 
 The Actions Semi Owl Clock Management Unit generates and supplies clock
 to various controllers within the SoC. The clock binding described here is
-applicable to S900 and S700 SoC's.
+applicable to S900, S700 and S500 SoC's.
 
 Required Properties:
 
 - compatible: should be one of the following,
 	"actions,s900-cmu"
 	"actions,s700-cmu"
+	"actions,s500-cmu"
 - reg: physical base address of the controller and length of memory mapped
   region.
 - clocks: Reference to the parent clocks ("hosc", "losc")
@@ -19,8 +20,8 @@ Each clock is assigned an identifier, and client nodes can use this identifier
 to specify the clock which they consume.
 
 All available clocks are defined as preprocessor macros in corresponding
-dt-bindings/clock/actions,s900-cmu.h or actions,s700-cmu.h header and can be
-used in device tree sources.
+dt-bindings/clock/actions,s900-cmu.h or actions,s700-cmu.h or
+actions,s500-cmu.h header and can be used in device tree sources.
 
 External clocks:
 
diff --git a/include/dt-bindings/clock/actions,s500-cmu.h b/include/dt-bindings/clock/actions,s500-cmu.h
new file mode 100644
index 000000000000..dc3fd2b0299d
--- /dev/null
+++ b/include/dt-bindings/clock/actions,s500-cmu.h
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Device Tree binding constants for Actions Semi S500 Clock Management Unit
+ *
+ * Copyright (c) 2014 Actions Semi Inc.
+ * Copyright (c) 2018 LSI-TEC - Caninos Loucos
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_S500_CMU_H
+#define __DT_BINDINGS_CLOCK_S500_CMU_H
+
+#define CLK_NONE		0
+
+/* fixed rate clocks */
+#define CLK_LOSC		1
+#define CLK_HOSC		2
+
+/* pll clocks */
+#define CLK_CORE_PLL		3
+#define CLK_DEV_PLL		4
+#define CLK_DDR_PLL		5
+#define CLK_NAND_PLL		6
+#define CLK_DISPLAY_PLL		7
+#define CLK_ETHERNET_PLL	8
+#define CLK_AUDIO_PLL		9
+
+/* system clock */
+#define CLK_DEV			10
+#define CLK_H			11
+#define CLK_AHBPREDIV		12
+#define CLK_AHB			13
+#define CLK_DE			14
+#define CLK_BISP		15
+#define CLK_VCE			16
+#define CLK_VDE			17
+
+/* peripheral device clock */
+#define CLK_TIMER		18
+#define CLK_I2C0		19
+#define CLK_I2C1		20
+#define CLK_I2C2		21
+#define CLK_I2C3		22
+#define CLK_PWM0		23
+#define CLK_PWM1		24
+#define CLK_PWM2		25
+#define CLK_PWM3		26
+#define CLK_PWM4		27
+#define CLK_PWM5		28
+#define CLK_SD0			29
+#define CLK_SD1			30
+#define CLK_SD2			31
+#define CLK_SENSOR0		32
+#define CLK_SENSOR1		33
+#define CLK_SPI0		34
+#define CLK_SPI1		35
+#define CLK_SPI2		36
+#define CLK_SPI3		37
+#define CLK_UART0		38
+#define CLK_UART1		39
+#define CLK_UART2		40
+#define CLK_UART3		41
+#define CLK_UART4		42
+#define CLK_UART5		43
+#define CLK_UART6		44
+#define CLK_DE1			45
+#define CLK_DE2			46
+#define CLK_I2SRX		47
+#define CLK_I2STX		48
+#define CLK_HDMI_AUDIO		49
+#define CLK_HDMI		50
+#define CLK_SPDIF		51
+#define CLK_NAND		52
+#define CLK_ECC			53
+#define CLK_RMII_REF		54
+
+#define CLK_NR_CLKS	       (CLK_RMII_REF + 1)
+
+#endif /* __DT_BINDINGS_CLOCK_S500_CMU_H */
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
