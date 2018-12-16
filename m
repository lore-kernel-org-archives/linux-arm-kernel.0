Return-Path: <SRS0=d92h=OZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5023AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 23:10:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09E422082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 23:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uLB3YS4R";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXYMqlK3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E422082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=p+mI6djn6UL5ZLTLdwkMb+fPkUniT0+GnB8REreRx9U=; b=uLB3YS4RH2mcSc
	MhfCiVBJj5kqKpHCXGdoBiJ8xE6dM8otMeGIp/TRsFnOq0vblRgtT9SHdUWRRUtE1nolzXZVCmgU3
	pry128FJNca6mDIdmr6Q7Vf/308vho53cOnmArV9V1thgZnPUNJ47xRJP5r51RINQXEhQEoBpVwpK
	aqAsTFlg0rSqRkhgvNA58WrvAF8z2TChMl7ok8E8a7Z0z5zgXK8HC+OEzH5rBcVaHf5dLN+El3+ul
	czVniH3vjhNG6SQ6QMfYkTIHO5LLWbmjFKWKmEm5azkem1esizclWA2+8EVuGFCXw+VdLxdsqi+Qq
	Uw87enEd1PYHre/wpqqA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYfXt-0000K4-LR; Sun, 16 Dec 2018 23:10:01 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYfXi-0000AF-Sv
 for linux-arm-kernel@lists.infradead.org; Sun, 16 Dec 2018 23:09:52 +0000
Received: by mail-pf1-x442.google.com with SMTP id i12so5395850pfo.7
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 16 Dec 2018 15:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ThdCHGx7HMeXDSODXXhk1TA+McwuEBwFRrEXyBqC4tY=;
 b=QXYMqlK3GSzfXI7WNRhf3Lz0lj8ztycPnCZijolGGZxyteGhEryVwQu+wNKPAUY+YP
 fo+Tg1U2Uo8OzVLtxtxMbZeWIeoOFNtkWQa3txQbNhbx5isGQaM31MOeLS1EG1V2/Aw/
 PgkX2upipOZOjpz/GhPPaHJ6s4ZBQtHsmZfdAKG7vakzIsckbF/66owIY2jK4U9jH8Gx
 3qTVt5orgN7K0HlBrnD6gTv+hcgH6OBftgBrN9nG/GtjXuyVwCp7aZVSGqBjH/inSNVw
 hNfD4FhGss5YL3gZJRrvma3EFKIvfSU4ng5gKPqww+mXYicev6szBieKPoA833+I0QdV
 OKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ThdCHGx7HMeXDSODXXhk1TA+McwuEBwFRrEXyBqC4tY=;
 b=fJ/eM5ea3w1NTbk63C3lv8hfLRmpp9rli0oC3JlVF8rPKI6JG/SR13gbk/QcxLMuvj
 69bU/uhCkYDl1vjU8hBSd4OJWWiLg1dKyp0TriF4pnDMBSTSPsSRNy5s8ghRCp89gVsT
 hhnX8fPCNZVXEeWEIgqhmcK9FVGwdWkPtCnZEmR6IoWGg04PRkYYLyB3l5tZ8a9IyUw8
 CroD1dlvSWvJ1ngIZxnDWYfOuWPGWp5eLq5rOO+9NUT591/leFOYcKPWH+t0m+rIPjnr
 9cFLFCsdrPLCA3gJ7v450hPOR0GWiGm+Qljvsl3bJHtPUMaCukMTwxJ0p8D5RJp3/9Cv
 91ng==
X-Gm-Message-State: AA+aEWYs/l8+L97ggboVrU617Hzv34J9TvL5gu/qheFIMPXtxSBrukCE
 3aGeeWHe7FHEegxNw2xp7To=
X-Google-Smtp-Source: AFSGD/W1bNEAwXlRjNa/wfgL9IEzOfuTo7fwcKylCFfKncceXmLpYw3zP057F6Lfib8rOiNANa1KIw==
X-Received: by 2002:a63:1013:: with SMTP id f19mr10316563pgl.38.1545001779866; 
 Sun, 16 Dec 2018 15:09:39 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id d18sm13837878pfj.47.2018.12.16.15.09.38
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 16 Dec 2018 15:09:39 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 1/3] PCI: imx6: Fixup Kconfig and #endif placement
Date: Sun, 16 Dec 2018 15:09:14 -0800
Message-Id: <20181216230916.22982-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181216230916.22982-1-andrew.smirnov@gmail.com>
References: <20181216230916.22982-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181216_150950_928120_9B7AACC0 
X-CRM114-Status: GOOD (  12.96  )
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
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>,
 linux-imx@nxp.com, Bjorn Helgaas <bhelgaas@google.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Chris Healy <cphealy@gmail.com>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Fixup Kconfig, which lost SOC_IMX7D during merge as well as move
"endif" to its original placement to only imx6q_pcie_abort_handler()
when building for AArch64

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
 drivers/pci/controller/dwc/Kconfig    | 4 ++--
 drivers/pci/controller/dwc/pci-imx6.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 0c8142529241..b5202ed78762 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -89,8 +89,8 @@ config PCI_EXYNOS
 	select PCIE_DW_HOST
 
 config PCI_IMX6
-	bool "Freescale i.MX6/7 PCIe controller"
-	depends on SOC_IMX8MQ || SOC_IMX6Q || (ARM && COMPILE_TEST)
+	bool "Freescale i.MX6/7/8 PCIe controller"
+	depends on SOC_IMX8MQ || SOC_IMX6Q || SOC_IMX7D || (ARM && COMPILE_TEST)
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index e563ca9bdb78..4b7f638b8aff 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -311,6 +311,7 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
 
 	return 1;
 }
+#endif
 
 static int imx6_pcie_attach_pd(struct device *dev)
 {
@@ -389,7 +390,6 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 				ret);
 	}
 }
-#endif
 
 static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 {
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
