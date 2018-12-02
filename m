Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E940AC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:27:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 677B720881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Lj31RIzN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNUqTPbs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677B720881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=wPMgTj9zl1IKMXhHHDCqwloEHTBe2hJr0B1AsLPJKIk=; b=Lj31RIzNtix7WLd0axyj5dEJFJ
	Iaso/+LcmLjPMNKUVWNHNjoLYYDsil2zjxULeiTZoB8/Nn7g4IcvyhnTiV7vC9ChWTVvNi1K9tOcW
	IeFGGhJjYqLjj3Seth44V+4JUTox62jTYzXJxw477ZdI7fJHtXlbEQ57m02HVj36aj6FOh1lmqDlJ
	FAOmU6r/51UWPI8b1yfdrhAX/W1Pjfnww/mPDlVEr/gqFC3bf+kEr3a43fgX8Ng/fhF5I7XBbaFpv
	XhM8mHWV4GRny0BDhfibdxK1DIkpleecvG/55QmP3CffNgKpKkenIL98FNdzswrBgZCrrRmWcVgY8
	uJZRsKwQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTYKr-0006FO-6u; Sun, 02 Dec 2018 20:27:25 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTYIF-00024U-47
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 20:24:52 +0000
Received: by mail-wm1-x341.google.com with SMTP id g67so3664658wmd.2
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 12:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=b3VT8ipXM4GVCZfalW4x+w8+g6CzhWh2u23wr46Xid4=;
 b=aNUqTPbso6m71CsDPncXaS+OD9GjWDC8sdZNTC5QUXKn5NR3XXevF+2rH7Kos/bZgq
 +HVpsXGjnXO2I61hUE4benHItT6tIgyGNYqMeOrS7HdRZDYkxBLH0YmGqR89wOjYPiYg
 lfcZW2ruOVm9y+auWUQAr2VxlodOPgEwepwWk9qtvg2QDO9jmtNi28noUbpf2ErVxw1h
 LTrD1SKoxVMDkwsfKbjMAIw1KrP7fX/A2Hl6v2VORzADCh8qMCUOCo93k48Tm2mwp7Iw
 ZgGnMqXIq+wMz3Qk9Yeb0iKaFTxrrksbYq/f09V/EuRZ+k2zyvheFhCgKrOkV31prfTK
 6dlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=b3VT8ipXM4GVCZfalW4x+w8+g6CzhWh2u23wr46Xid4=;
 b=h9nJ9QdOdRYp6yOBrFVjp3r/ZmYfPP6Qyv+O4xUioJ0yHHRJsjB8ZqB1dvPa77FW9t
 RApxShjR0Ou6iLkvpp9zDMPN8Vhre5nQZnRMHjmu44H3yW1lIKTt99kfdysHwRc8XQUn
 T0lxqqPxnmWtk/9IpVxQRG8WfuIvfyEssHNoW4xCtYNxqqvU+6AB87PF35r6E14ZCScb
 XnPlMRhAt1weuWijJ9uQ6VKASrtgoJrGN7ehXEzYMfAwPMlxdrSqSwfK35B/Yqe5Arz4
 /EIYmCFG2HOPAqG9Yq4w6PNFiLXCiYSruAPBxV6eYLvu4OFtDF/KyowWsR9hz7NuIrD7
 PMUQ==
X-Gm-Message-State: AA+aEWaBVsle3mu4Gsd/gWzWNTqMAXexliRuzWtZjVJCE08GSU+czBts
 RKQKWND6zkO2wHprnY8yQqg=
X-Google-Smtp-Source: AFSGD/VH0g5NGCrKj4K3ZKMdWMNXZ10pqp0zr3BBq6RdMbSLXd+fpFXumiuxq4rbqS8pJkeiQZPd7A==
X-Received: by 2002:a1c:2807:: with SMTP id
 o7-v6mr5699286wmo.138.1543782271634; 
 Sun, 02 Dec 2018 12:24:31 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
 by smtp.gmail.com with ESMTPSA id l3sm14451510wma.44.2018.12.02.12.24.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 02 Dec 2018 12:24:31 -0800 (PST)
From: Mesih Kilinc <mesihkilinc@gmail.com>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH v6 12/17] dt-bindings: clock: Add Allwinner suniv F1C100s CCU
Date: Sun,  2 Dec 2018 23:23:46 +0300
Message-Id: <963e6608b509ae7a83966c76b9d0fc7d8bf1c07b.1543781680.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543781680.git.mesihkilinc@gmail.com>
References: <cover.1543781680.git.mesihkilinc@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_122443_926307_D64C3458 
X-CRM114-Status: GOOD (  15.22  )
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
Cc: Mesih Kilinc <mesihkilinc@gmail.com>,
 Julian Calaby <julian.calaby@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Russell King <linux@armlinux.org.uk>, Marc Zyngier <marc.zyngier@arm.com>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 Icenowy Zheng <icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add compatiple string for Allwinner suniv F1C100s CCU.
Add clock and reset definitions.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 .../devicetree/bindings/clock/sunxi-ccu.txt        |  1 +
 include/dt-bindings/clock/suniv-ccu-f1c100s.h      | 70 ++++++++++++++++++++++
 include/dt-bindings/reset/suniv-ccu-f1c100s.h      | 38 ++++++++++++
 3 files changed, 109 insertions(+)
 create mode 100644 include/dt-bindings/clock/suniv-ccu-f1c100s.h
 create mode 100644 include/dt-bindings/reset/suniv-ccu-f1c100s.h

diff --git a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
index 47d2e90..e3bd88a 100644
--- a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
@@ -22,6 +22,7 @@ Required properties :
 		- "allwinner,sun50i-h5-ccu"
 		- "allwinner,sun50i-h6-ccu"
 		- "allwinner,sun50i-h6-r-ccu"
+		- "allwinner,suniv-f1c100s-ccu"
 		- "nextthing,gr8-ccu"
 
 - reg: Must contain the registers base address and length
diff --git a/include/dt-bindings/clock/suniv-ccu-f1c100s.h b/include/dt-bindings/clock/suniv-ccu-f1c100s.h
new file mode 100644
index 0000000..f5ac155
--- /dev/null
+++ b/include/dt-bindings/clock/suniv-ccu-f1c100s.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ *
+ * Copyright (c) 2018 Icenowy Zheng <icenowy@aosc.xyz>
+ *
+ */
+
+#ifndef _DT_BINDINGS_CLK_SUNIV_F1C100S_H_
+#define _DT_BINDINGS_CLK_SUNIV_F1C100S_H_
+
+#define CLK_CPU			11
+
+#define CLK_BUS_DMA		14
+#define CLK_BUS_MMC0		15
+#define CLK_BUS_MMC1		16
+#define CLK_BUS_DRAM		17
+#define CLK_BUS_SPI0		18
+#define CLK_BUS_SPI1		19
+#define CLK_BUS_OTG		20
+#define CLK_BUS_VE		21
+#define CLK_BUS_LCD		22
+#define CLK_BUS_DEINTERLACE	23
+#define CLK_BUS_CSI		24
+#define CLK_BUS_TVD		25
+#define CLK_BUS_TVE		26
+#define CLK_BUS_DE_BE		27
+#define CLK_BUS_DE_FE		28
+#define CLK_BUS_CODEC		29
+#define CLK_BUS_SPDIF		30
+#define CLK_BUS_IR		31
+#define CLK_BUS_RSB		32
+#define CLK_BUS_I2S0		33
+#define CLK_BUS_I2C0		34
+#define CLK_BUS_I2C1		35
+#define CLK_BUS_I2C2		36
+#define CLK_BUS_PIO		37
+#define CLK_BUS_UART0		38
+#define CLK_BUS_UART1		39
+#define CLK_BUS_UART2		40
+
+#define CLK_MMC0		41
+#define CLK_MMC0_SAMPLE		42
+#define CLK_MMC0_OUTPUT		43
+#define CLK_MMC1		44
+#define CLK_MMC1_SAMPLE		45
+#define CLK_MMC1_OUTPUT		46
+#define CLK_I2S			47
+#define CLK_SPDIF		48
+
+#define CLK_USB_PHY0		49
+
+#define CLK_DRAM_VE		50
+#define CLK_DRAM_CSI		51
+#define CLK_DRAM_DEINTERLACE	52
+#define CLK_DRAM_TVD		53
+#define CLK_DRAM_DE_FE		54
+#define CLK_DRAM_DE_BE		55
+
+#define CLK_DE_BE		56
+#define CLK_DE_FE		57
+#define CLK_TCON		58
+#define CLK_DEINTERLACE		59
+#define CLK_TVE2_CLK		60
+#define CLK_TVE1_CLK		61
+#define CLK_TVD			62
+#define CLK_CSI			63
+#define CLK_VE			64
+#define CLK_CODEC		65
+#define CLK_AVS			66
+
+#endif
diff --git a/include/dt-bindings/reset/suniv-ccu-f1c100s.h b/include/dt-bindings/reset/suniv-ccu-f1c100s.h
new file mode 100644
index 0000000..6a4b438
--- /dev/null
+++ b/include/dt-bindings/reset/suniv-ccu-f1c100s.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ *
+ * Copyright (C) 2018 Icenowy Zheng <icenowy@aosc.xyz>
+ *
+ */
+
+#ifndef _DT_BINDINGS_RST_SUNIV_F1C100S_H_
+#define _DT_BINDINGS_RST_SUNIV_F1C100S_H_
+
+#define RST_USB_PHY0		0
+#define RST_BUS_DMA		1
+#define RST_BUS_MMC0		2
+#define RST_BUS_MMC1		3
+#define RST_BUS_DRAM		4
+#define RST_BUS_SPI0		5
+#define RST_BUS_SPI1		6
+#define RST_BUS_OTG		7
+#define RST_BUS_VE		8
+#define RST_BUS_LCD		9
+#define RST_BUS_DEINTERLACE	10
+#define RST_BUS_CSI		11
+#define RST_BUS_TVD		12
+#define RST_BUS_TVE		13
+#define RST_BUS_DE_BE		14
+#define RST_BUS_DE_FE		15
+#define RST_BUS_CODEC		16
+#define RST_BUS_SPDIF		17
+#define RST_BUS_IR		18
+#define RST_BUS_RSB		19
+#define RST_BUS_I2S0		20
+#define RST_BUS_I2C0		21
+#define RST_BUS_I2C1		22
+#define RST_BUS_I2C2		23
+#define RST_BUS_UART0		24
+#define RST_BUS_UART1		25
+#define RST_BUS_UART2		26
+
+#endif /* _DT_BINDINGS_RST_SUNIV_F1C100S_H_ */
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
