Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795CDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:30:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 483ED21906
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SV2FBu+r";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuJydmjO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 483ED21906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VWlBJNDCC6LaCyJMp1i54jbiyo4WO/mOycoQQzd45pA=; b=SV2FBu+r/jV0TJ
	UB+Fty2slJKXGex0ZZ0G0pjNB8J/roQa/WVwp1qdsXqMsSaJvuBv4PqT0deV6EyXELVTpkrs+ZXpt
	r5jQxW3qQFnqRJSf1KylhJICNrI89ZQQz7qzSD/WusAB9J6KbN9jNonjGjShwjpQiKcCxjShCzT4J
	H/hEmPhjm2ML2Of+t8QM4g4ptT2OJ0/XY/q9XceDRY3ZAYgi5n7YLBZiEplqOu2x4FgwASivT+3r+
	TCBF2NOenGpGQf7mTlgpl4dRmrn/JlrEJectMqKGbwbTZzYkMAv2Yw9dx9BUBRdvpl/Er5uiVD8LT
	VRF0EwbkiJ5oas15iN+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaFGQ-0005U9-VO; Fri, 21 Dec 2018 07:30:31 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaFE5-0001la-FG
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 07:28:08 +0000
Received: by mail-pl1-x642.google.com with SMTP id b5so2109850plr.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 23:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rMjeSwqTVYgU8Pkh3tt+I27KOANJIXmBbqHJEBxidRc=;
 b=fuJydmjOCe/aNVUWccFNTUhSXJgPFuBevZ0KZvetPIaHuw3xlUcl1eRP/w46kKKE8H
 yP7FYF5virlsp+ZnSFEKDQ1atdLjHEi+O3vIDrOEFdN2QYO6mklcZhp/ex5ph7RE01pL
 0Gwg1LqSMmTRXF904GVVqjBxsUL1Xt6hDuuGqCUL+txnGNrUGkSmjeK+BJcTl2+PbTxY
 8LGsxFT3yTx9d7RMDAfPC6cKVhI34UwfG7WPgF7tzIyelnarJzSMRPkfhod74r7LT7qz
 8JieMinuEVFwP/GO7Y+hVCWAusX1EJ/qrKjlPEBhQdnPRrQPEZzJdRNr3jgHXHUoyKOj
 bREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rMjeSwqTVYgU8Pkh3tt+I27KOANJIXmBbqHJEBxidRc=;
 b=SMSquGxTXFlX5lXL5gIRMDxAFx3LcjwTHKP0JRwmfKqvS0UrJxt2xvZjtbbSoHMeO4
 cPzpI1KJtVCMnF7++T+rbLFPg0v6NxQjRS05C4IRCecOBmWQnsSJFMVcqZVu+5n7KsZs
 xsN98X/jUwvun4cWnapltjXuk09sIMmMDy54yXpNBJr6UlD430Wtheek4x3sI+r1y+Fk
 +2hD5NX+eMgTDEh7/daZfdgsVu9/d1P0Vztacour2A522uOzc82igt0hHBgQjNYO2cBp
 XY8djuSCLbfPJUXFFCkqLxhHweGTWCw86k39jdlWjjQu+NwyELQ68mkykIKgXV32WAIf
 JjTg==
X-Gm-Message-State: AJcUukdSUY/TRvo8ZL0bqROjruu2FVj79fH3zIOYwOshfmJ3ZKGgRXyC
 Pb2NMfPEvyHQ78U8HsfMun4=
X-Google-Smtp-Source: ALg8bN6q73Q1NnW5DO0vkV8WUnO939ff0oDQK8QdIco6O92Xhm1cJd9Vi5e7YSWBjPhBUsepla/bug==
X-Received: by 2002:a17:902:d01:: with SMTP id 1mr1435404plu.127.1545377277849; 
 Thu, 20 Dec 2018 23:27:57 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id t90sm44971921pfj.23.2018.12.20.23.27.56
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Dec 2018 23:27:57 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH 10/21] PCI: designware: imx6: Share PHY debug register
 definitions
Date: Thu, 20 Dec 2018 23:27:05 -0800
Message-Id: <20181221072716.29017-11-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072716.29017-1-andrew.smirnov@gmail.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_232805_734701_AC846A14 
X-CRM114-Status: GOOD (  12.64  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Richard Zhu <hongxing.zhu@nxp.com>, linux-arm-kernel@lists.infradead.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-kernel@vger.kernel.org,
 Fabio Estevam <fabio.estevam@nxp.com>, linux-imx@nxp.com,
 Bjorn Helgaas <bhelgaas@google.com>, Leonard Crestez <leonard.crestez@nxp.com>,
 Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Both pcie-designware.c and pci-imx6.c contain custom definitions for
PHY debug registers R0/R1 and on top of that there's already a
definition for R0 in pcie-designware.h. Move all of the definitions to
pcie-designware.h. No functional change intended.

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
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/pci/controller/dwc/pci-imx6.c        |  6 ++----
 drivers/pci/controller/dwc/pcie-designware.c | 12 +++---------
 drivers/pci/controller/dwc/pcie-designware.h |  3 +++
 3 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 74faca11eeae..c0b073cf20c0 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -82,8 +82,6 @@ struct imx6_pcie {
 
 /* PCIe Port Logic registers (memory-mapped) */
 #define PL_OFFSET 0x700
-#define PCIE_PHY_DEBUG_R0 (PL_OFFSET + 0x28)
-#define PCIE_PHY_DEBUG_R1 (PL_OFFSET + 0x2c)
 
 #define PCIE_PHY_CTRL (PL_OFFSET + 0x114)
 #define PCIE_PHY_CTRL_DATA_LOC 0
@@ -706,8 +704,8 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 
 err_reset_phy:
 	dev_dbg(dev, "PHY DEBUG_R0=0x%08x DEBUG_R1=0x%08x\n",
-		dw_pcie_readl_dbi(pci, PCIE_PHY_DEBUG_R0),
-		dw_pcie_readl_dbi(pci, PCIE_PHY_DEBUG_R1));
+		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0),
+		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG1));
 	imx6_pcie_reset_phy(imx6_pcie);
 	return ret;
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 67236379c61a..d123ac290b9e 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -14,12 +14,6 @@
 
 #include "pcie-designware.h"
 
-/* PCIe Port Logic registers */
-#define PLR_OFFSET			0x700
-#define PCIE_PHY_DEBUG_R1		(PLR_OFFSET + 0x2c)
-#define PCIE_PHY_DEBUG_R1_LINK_UP	(0x1 << 4)
-#define PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING	(0x1 << 29)
-
 int dw_pcie_read(void __iomem *addr, int size, u32 *val)
 {
 	if (!IS_ALIGNED((uintptr_t)addr, size)) {
@@ -334,9 +328,9 @@ int dw_pcie_link_up(struct dw_pcie *pci)
 	if (pci->ops->link_up)
 		return pci->ops->link_up(pci);
 
-	val = readl(pci->dbi_base + PCIE_PHY_DEBUG_R1);
-	return ((val & PCIE_PHY_DEBUG_R1_LINK_UP) &&
-		(!(val & PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING)));
+	val = readl(pci->dbi_base + PCIE_PORT_DEBUG1);
+	return ((val & PCIE_PORT_DEBUG1_LINK_UP) &&
+		(!(val & PCIE_PORT_DEBUG1_LINK_IN_TRAINING)));
 }
 
 void dw_pcie_setup(struct dw_pcie *pci)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 9943d8c68335..58735fd01668 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -39,6 +39,9 @@
 #define PCIE_PORT_DEBUG0		0x728
 #define PORT_LOGIC_LTSSM_STATE_MASK	0x1f
 #define PORT_LOGIC_LTSSM_STATE_L0	0x11
+#define PCIE_PORT_DEBUG1		0x72C
+#define PCIE_PORT_DEBUG1_LINK_UP		(0x1 << 4)
+#define PCIE_PORT_DEBUG1_LINK_IN_TRAINING	(0x1 << 29)
 
 #define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
 #define PORT_LOGIC_SPEED_CHANGE		(0x1 << 17)
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
