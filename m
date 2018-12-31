Return-Path: <SRS0=D6bT=PI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164B0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 18:56:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D48992073F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 18:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rmxLppoH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uhjesctv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D48992073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=xc/2OlCDueNBnd5uQeosY0WY8JScwhEfKNcuxsj0lS0=; b=rmxLppoHQoVnYli41VCkaM6+F3
	6Ygg0DJyuejRjWX/ki51CpgTPGfFKTvGeMYMQDMJV20o4WW56nojbVaUBwfJIXoAbz9ZDSOHVqAW5
	cfKiiruPT0GX/tI//iw1OoWDP775yqg8nyeWJlxlwgwbSr/H4XeJTsbcKo++10dLP+eCYRDxrxPTa
	C08GbxPZD7adgtYgJU4UYJikYPAsXypXKAM4E+5FuaCcZYYDSXaN41HXshQOs9SJPSBl7KZBPtkox
	HjT/hJRZTfggdg30aKs8Mkfd44U5AHXABoBRM2DktLYng05HXkmb2SoLqj65SxfXpU4kmdZc5T9nT
	7a5UjnRw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ge2jW-0003Pa-1l; Mon, 31 Dec 2018 18:56:14 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ge2j9-00034p-SC
 for linux-arm-kernel@lists.infradead.org; Mon, 31 Dec 2018 18:55:55 +0000
Received: by mail-pf1-x441.google.com with SMTP id 64so13460060pfr.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 31 Dec 2018 10:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=9D7Rmsu05/Pbcqbi1xBn66qiVOUkQv4REhih46r6FtQ=;
 b=Uhjesctv2Sn27JZlyXrOgt4VnPsGLpQiRpLu0pyiNYRmKSYhCoDrGpQeWpf1rMU+7+
 nrH4mLw6X3N2HaUnYTAv/DB3s+CsG13BXY9/bbkpMMcZm74+reGhIiw1/us7rjTqbz0Q
 4lLNMtsU4F6M7rZz4mujTd8dqQLbpPdWXDHxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=9D7Rmsu05/Pbcqbi1xBn66qiVOUkQv4REhih46r6FtQ=;
 b=a/NEHckhWdTaL2pF+E3yfIuzJe193g64Rnw6dp4NRvqIFpPJaCHCMBVP00m0ojJwIe
 uL9qhG8hM8eXQR+7XkjQNA2zJmJLe/OvJah+bys2IlgVtpoYNnMwSxAC8LeN8IDqIE1t
 JWX4iZoxwXULea7+JuwKopvoYshYNVGm9VOdxcpRzPB12d5E/iwZeB14eoSctW78LNPr
 CYqBqnnOmdZHKph+FHtFGqM7bMkb+yo5d8nKeKcl9phaUTc0HE51UcRaOojyniBaOFYA
 E3SWckLx6JgLq+c0EFBPTUwD8fMnh/OLQHbe+ZWSP3iE1jnGeNSZEbZ9IR1WHFbAUWIw
 FSxw==
X-Gm-Message-State: AJcUukfORvqvpXqLJsmp62gp5KysnGkynIPlZOOcitC7ZK0mI4JXs0DV
 mU0AK3fZOU2vL1Y2nZMQ8drh
X-Google-Smtp-Source: ALg8bN7rAo8T1pt8mQGMzJEOpPlWv6qGczbwWVs7FsunvcRXHzIVmSGfbhXqHssxyqnCsT9xHhUMfA==
X-Received: by 2002:a63:4b60:: with SMTP id k32mr8334133pgl.186.1546282551092; 
 Mon, 31 Dec 2018 10:55:51 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7440:b882:8d58:e15f:9ff4:efc2])
 by smtp.gmail.com with ESMTPSA id s9sm66146224pgl.88.2018.12.31.10.55.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 31 Dec 2018 10:55:50 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: sboyd@kernel.org, mturquette@baylibre.com, afaerber@suse.de,
 robh+dt@kernel.org
Subject: [PATCH 2/6] dt-bindings: clock: Add DT bindings for Actions Semi S500
 CMU
Date: Tue,  1 Jan 2019 00:25:13 +0530
Message-Id: <20181231185517.18517-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181231185517.18517-1-manivannan.sadhasivam@linaro.org>
References: <20181231185517.18517-1-manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_105552_220344_4677DAB4 
X-CRM114-Status: GOOD (  16.30  )
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
Cc: devicetree@vger.kernel.org, linux-actions@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Edgar Bernardi Righi <edgar.righi@lsitec.org.br>,
 linux-arm-kernel@lists.infradead.org
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
---

Rob, I have removed your Reviewed-by tag for this patch since the
earlier revision contained only bindings constants and lacked the
compatible documentation, which is added now.

 .../bindings/clock/actions,owl-cmu.txt        |  7 +-
 include/dt-bindings/clock/actions,s500-cmu.h  | 78 +++++++++++++++++++
 2 files changed, 82 insertions(+), 3 deletions(-)
 create mode 100644 include/dt-bindings/clock/actions,s500-cmu.h

diff --git a/Documentation/devicetree/bindings/clock/actions,owl-cmu.txt b/Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
index 2ef86ae96df8..86183f559022 100644
--- a/Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
+++ b/Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
@@ -2,13 +2,14 @@
 
 The Actions Semi Owl Clock Management Unit generates and supplies clock
 to various controllers within the SoC. The clock binding described here is
-applicable to S900 and S700 SoC's.
+applicable to S900,S700 and S500 SoC's.
 
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
