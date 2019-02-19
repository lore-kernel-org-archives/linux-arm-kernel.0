Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2FFC4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:05:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B7CE21738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ak20/IBh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLn8k50K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7CE21738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mrwqwAUfWEbLHhYey3QhP1aRd4GBEYxWa1P0OVuGC4o=; b=Ak20/IBh+9av0G
	OiucUQHRdjYMARaFo8HHX8ASItiGrjNVzhvH//2nYqgA5mK/p3UdGH7CvjYG8b9OpUOTlCS9a3rqR
	0jqaLXTtCM61bzV3Suc9DlnW2YtybzBVPv8oU6kVPqkJbmoNNCRE5AoM+7ikGLO3npYcfSsTxaUXC
	qobQvZlDOtwGMqcv4Xf66HFSNT+0m1WMB9Fv/LDKzXmg8VvF84+98pluHlcG30H4UL5q2AK7aM5mk
	8deeco8m0b/OAh16e2eUfpZPTxqXJ/0DnqTpAesszwAJiBoGOtQbroqB49xKmsGasqUACMxBeRhrO
	uhJ1pWspgDYL/LO4F5Dw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwBdQ-0003M7-1w; Tue, 19 Feb 2019 20:04:56 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwBcq-0002dP-7i
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 20:04:23 +0000
Received: by mail-pf1-x441.google.com with SMTP id q17so10714826pfh.10
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 12:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BZi2w8f57gOm3gFQ8UGMMY60waRhbgxhlftcvIngYdk=;
 b=DLn8k50K04WUEg8VKTvya93AQofVWYeFWRQz7bWvjzLLN0Wd8V8DxubI+t+I1QVspL
 UioKOnR03EfgqqlIWdFmCv2+l2xLBpwABpTcHSNUrlGVJBfVzEbV1dV44IStOjfG+36G
 GVLYkbRlBsJjXSA/IsokZBdbqtUqbvf6KGLLcpMiM3o8USZ3CrZdeFPyjOaAXL/vlsZR
 1WIipNvw2ieVcyKUottu7TeHg84Ucvlp0UZSXRtMo3+3NuUghzdaWdJtqE6W7nzFpmjy
 uF+esZmk12ri7Ewl6tfaQu/omAIabWWEl+prmDRokPYZPmmt67EkV/nyvKk0ViVgCJWt
 j31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BZi2w8f57gOm3gFQ8UGMMY60waRhbgxhlftcvIngYdk=;
 b=kNsHqL9ffGe8JOxwDL9YckiFvCep1D6JZv/IxEqK/3GN7tGWhfKn9d+XK1bqIFi5xa
 idWH0COIJUM6zUZQ499kZphVQrm9HGnn/NPozosj/Qn6MBA1QuZW94AVvySzs8HxB3jI
 vBKgUywFM40Y8bc2zmi0w59locYZd6wwd0zleEFS6FOEP8XYCVggr/ljV1ZmllgzwYsZ
 W58h4vsVr+CTE3yOtkE67rNMC8c2vetUeBLN4UymcJ5L/BTmCQAEMSjl9NE3YOzwyHR5
 BMRht6DqN6T+5wKV6kHD18f2vIhPRV2CxJ2qIYFNGUfC/dHfcgcMU22wvnOETNZ3A5UE
 8grw==
X-Gm-Message-State: AHQUAubJqs/6NqPcPRshLvgI8vc7DhuwgIT0AtRrRaKDqMacz5oIocDJ
 heAerb4/sZRIw4sI7KQ6Wtk=
X-Google-Smtp-Source: AHgI3IZInibU5Q4FBmodj59vvkLZQJoScZEM++EElmkNviJN23OVcpFqfexe7ksD15S1jtW4MRHw7g==
X-Received: by 2002:a63:4e05:: with SMTP id c5mr25940085pgb.393.1550606659627; 
 Tue, 19 Feb 2019 12:04:19 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id e63sm31519622pfc.47.2019.02.19.12.04.18
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 19 Feb 2019 12:04:18 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 4/5] PCI: dwc: Make use of GENMASK/FIELD_PREP
Date: Tue, 19 Feb 2019 12:02:41 -0800
Message-Id: <20190219200242.17243-5-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190219200242.17243-1-andrew.smirnov@gmail.com>
References: <20190219200242.17243-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_120420_316197_BC2EF037 
X-CRM114-Status: GOOD (  11.98  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 linux-arm-kernel@lists.infradead.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, linux-kernel@vger.kernel.org,
 Fabio Estevam <fabio.estevam@nxp.com>, linux-imx@nxp.com,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Chris Healy <cphealy@gmail.com>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Convert various multi-bit fields to be defined using
GENMASK/FIELD_PREP. This way bit field boundaries are defined in a
single place only, as well as defined in a way that makes it easier to
verify them against reference manual. No functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/controller/dwc/pcie-designware.h | 29 +++++++++++---------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 070382869685..8ebfb06584d9 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -11,6 +11,7 @@
 #ifndef _PCIE_DESIGNWARE_H
 #define _PCIE_DESIGNWARE_H
 
+#include <linux/bitfield.h>
 #include <linux/dma-mapping.h>
 #include <linux/irq.h>
 #include <linux/msi.h>
@@ -30,11 +31,12 @@
 
 /* Synopsys-specific PCIe configuration registers */
 #define PCIE_PORT_LINK_CONTROL		0x710
-#define PORT_LINK_MODE_MASK		(0x3f << 16)
-#define PORT_LINK_MODE_1_LANES		(0x1 << 16)
-#define PORT_LINK_MODE_2_LANES		(0x3 << 16)
-#define PORT_LINK_MODE_4_LANES		(0x7 << 16)
-#define PORT_LINK_MODE_8_LANES		(0xf << 16)
+#define PORT_LINK_MODE_MASK		GENMASK(21, 16)
+#define PORT_LINK_MODE(n)		FIELD_PREP(PORT_LINK_MODE_MASK, n)
+#define PORT_LINK_MODE_1_LANES		PORT_LINK_MODE(0x1)
+#define PORT_LINK_MODE_2_LANES		PORT_LINK_MODE(0x3)
+#define PORT_LINK_MODE_4_LANES		PORT_LINK_MODE(0x7)
+#define PORT_LINK_MODE_8_LANES		PORT_LINK_MODE(0xf)
 
 #define PCIE_PORT_DEBUG0		0x728
 #define PORT_LOGIC_LTSSM_STATE_MASK	0x1f
@@ -42,11 +44,12 @@
 
 #define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
 #define PORT_LOGIC_SPEED_CHANGE		BIT(17)
-#define PORT_LOGIC_LINK_WIDTH_MASK	(0x1f << 8)
-#define PORT_LOGIC_LINK_WIDTH_1_LANES	(0x1 << 8)
-#define PORT_LOGIC_LINK_WIDTH_2_LANES	(0x2 << 8)
-#define PORT_LOGIC_LINK_WIDTH_4_LANES	(0x4 << 8)
-#define PORT_LOGIC_LINK_WIDTH_8_LANES	(0x8 << 8)
+#define PORT_LOGIC_LINK_WIDTH_MASK	GENMASK(12, 8)
+#define PORT_LOGIC_LINK_WIDTH(n)	FIELD_PREP(PORT_LOGIC_LINK_WIDTH_MASK, n)
+#define PORT_LOGIC_LINK_WIDTH_1_LANES	PORT_LOGIC_LINK_WIDTH(0x1)
+#define PORT_LOGIC_LINK_WIDTH_2_LANES	PORT_LOGIC_LINK_WIDTH(0x2)
+#define PORT_LOGIC_LINK_WIDTH_4_LANES	PORT_LOGIC_LINK_WIDTH(0x4)
+#define PORT_LOGIC_LINK_WIDTH_8_LANES	PORT_LOGIC_LINK_WIDTH(0x8)
 
 #define PCIE_MSI_ADDR_LO		0x820
 #define PCIE_MSI_ADDR_HI		0x824
@@ -72,9 +75,9 @@
 #define PCIE_ATU_UPPER_BASE		0x910
 #define PCIE_ATU_LIMIT			0x914
 #define PCIE_ATU_LOWER_TARGET		0x918
-#define PCIE_ATU_BUS(x)			(((x) & 0xff) << 24)
-#define PCIE_ATU_DEV(x)			(((x) & 0x1f) << 19)
-#define PCIE_ATU_FUNC(x)		(((x) & 0x7) << 16)
+#define PCIE_ATU_BUS(x)			FIELD_PREP(GENMASK(31, 24), x)
+#define PCIE_ATU_DEV(x)			FIELD_PREP(GENMASK(23, 19), x)
+#define PCIE_ATU_FUNC(x)		FIELD_PREP(GENMASK(18, 16), x)
 #define PCIE_ATU_UPPER_TARGET		0x91C
 
 #define PCIE_MISC_CONTROL_1_OFF		0x8BC
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
