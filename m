Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BDBC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:04:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA28D21738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WBLIpxxv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kis3oj3j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA28D21738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EYOvOyCpKApWKd0XQW0IpeStcpDXWjbXsPlYu5gc+8A=; b=WBLIpxxvNi6eNE
	u3xU/V2XLkMANqcorHrqDYzLePltGtw13VtRUxv5AcYhmt1imb6OcLE6cyL2kDMbXLTuglOe1bjmE
	22iM/+Tln98+mpCy3+KOzwRSc1vDjuRbv7v2tRf0IbkQJyQmZx+XcJvMk7j0yNVz+Zae2QuC8S861
	gy3L26C2Iwbf9I5X4qlSqCQkOfU76o9RhXhdQ1ICsyV06yPRanc/5wvEJ0dXA3OS34+HBBrW0XqH7
	Dvl34PB9XyTKiQI4g4prfODRNwMZl0eVEQOgkKmiHZDCsFv5cS7iAHXncB6fxkWyw0mkf1DJwMXhn
	5bmqBOkin09GPlTtpGHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwBdE-00034t-6K; Tue, 19 Feb 2019 20:04:44 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwBcn-0002cx-Lm
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 20:04:21 +0000
Received: by mail-pl1-x643.google.com with SMTP id y10so10960327plp.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 12:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7zn1Jso68+ps/Kh/7DAZgNR71SoxjfHsFyh8div2Ihs=;
 b=Kis3oj3jXF0ANwB2G41FeWJeyQ3FdHxBIWM0FTBwP+kFYfsg5shhl/pt+bCNZtts82
 JXVXQjuk/+GmIT7vIK7jy+DHL2JZ61oN6Oz8gL+iCPMvTkTTiSFi1F8wiNFMriPtSTA0
 FB4XorGN65UHlmL4APKsDHFzHH22QcpGC5/GSQpWgBk5jJLPv/iSQmJnobB9Mi0izBLQ
 e+oaJN/yHK2bztEA4p+/bc+FCKisdGIZbFvzhMCjY50Z0qIUquXAifTamgUG0n5HfbAv
 3YOl95z1V12U49m2byrz2VuBsP2QarpW6ZngGjosIJzwGXnuzLf2ZAGnh88fsc5Cj+Un
 9v8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7zn1Jso68+ps/Kh/7DAZgNR71SoxjfHsFyh8div2Ihs=;
 b=EpJrIlXnrID9Dy92hfabJCTHr5baBcQOm9TwxwoANa5pw62EQM3gtkyg3jWQnb2zUS
 e3ZoZtJppPPBEnsbFWw9ImPavJrGLcLKflceVY2f1oRCFMMQtHl9yH8G2ODmislFVEcb
 rJdgeBbkgyblSJzvX2fOKwYPrnVJzkKEyxWoJUwrBwMHU0TZVKhHkqCf9Lmwdn4z2GPO
 2KDSMU1AU8dolWd49WTR5xhYIsq7PZuLzIokpcf9hw+WBBnkGY+hblTQbGtaefDZxWQC
 S+oeNKKo71csKzQvEPFKqoK+3qsMHCct7B2OnmDd1m2IuZuRiO4OmRNbAd95FWg2oNdY
 zQBg==
X-Gm-Message-State: AHQUAuZHELrTu2ibTD/nEAXhdHcNZOvJ3Y5KnFALS5/CrBSr1AY3Ofna
 m0/CF2ZnqaX+M2dth/tTx7w=
X-Google-Smtp-Source: AHgI3IbRI7q9KYAp9AZ8+6shmYkfxaKhV7eDpmJIN3SeblXin+Rif0oznINJYKHkn6jfsdsfVIvo8g==
X-Received: by 2002:a17:902:e409:: with SMTP id
 ci9mr9313567plb.221.1550606656725; 
 Tue, 19 Feb 2019 12:04:16 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id e63sm31519622pfc.47.2019.02.19.12.04.14
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 19 Feb 2019 12:04:15 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 2/5] PCI: dwc: Share code for dw_pcie_rd/wr_other_conf()
Date: Tue, 19 Feb 2019 12:02:39 -0800
Message-Id: <20190219200242.17243-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190219200242.17243-1-andrew.smirnov@gmail.com>
References: <20190219200242.17243-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_120419_971419_BF49CC93 
X-CRM114-Status: GOOD (  14.01  )
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

Default implementation of pcie_rd_other_conf() and
dw_pcie_wd_other_conf() share more than 80% of their code. Move shared
code into a dedicated subroutine and convert pcie_rd_other_conf() and
dw_pcie_wd_other_conf() to use it. No functional change intended.

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
 .../pci/controller/dwc/pcie-designware-host.c | 61 +++++++------------
 1 file changed, 23 insertions(+), 38 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 45ff5e4f8af6..0c18ab63811f 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -512,8 +512,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	return ret;
 }
 
-static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
-				 u32 devfn, int where, int size, u32 *val)
+static int dw_pcie_access_other_conf(struct pcie_port *pp, struct pci_bus *bus,
+				     u32 devfn, int where, int size, u32 *val,
+				     bool write)
 {
 	int ret, type;
 	u32 busdev, cfg_size;
@@ -521,9 +522,6 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 	void __iomem *va_cfg_base;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
-	if (pp->ops->rd_other_conf)
-		return pp->ops->rd_other_conf(pp, bus, devfn, where, size, val);
-
 	busdev = PCIE_ATU_BUS(bus->number) | PCIE_ATU_DEV(PCI_SLOT(devfn)) |
 		 PCIE_ATU_FUNC(PCI_FUNC(devfn));
 
@@ -542,7 +540,11 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 	dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX1,
 				  type, cpu_addr,
 				  busdev, cfg_size);
-	ret = dw_pcie_read(va_cfg_base + where, size, val);
+	if (write)
+		ret = dw_pcie_write(va_cfg_base + where, size, *val);
+	else
+		ret = dw_pcie_read(va_cfg_base + where, size, val);
+
 	if (pci->num_viewport <= 2)
 		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX1,
 					  PCIE_ATU_TYPE_IO, pp->io_base,
@@ -551,43 +553,26 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 	return ret;
 }
 
+static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
+				 u32 devfn, int where, int size, u32 *val)
+{
+	if (pp->ops->rd_other_conf)
+		return pp->ops->rd_other_conf(pp, bus, devfn, where,
+					      size, val);
+
+	return dw_pcie_access_other_conf(pp, bus, devfn, where, size, val,
+					 false);
+}
+
 static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 				 u32 devfn, int where, int size, u32 val)
 {
-	int ret, type;
-	u32 busdev, cfg_size;
-	u64 cpu_addr;
-	void __iomem *va_cfg_base;
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-
 	if (pp->ops->wr_other_conf)
-		return pp->ops->wr_other_conf(pp, bus, devfn, where, size, val);
-
-	busdev = PCIE_ATU_BUS(bus->number) | PCIE_ATU_DEV(PCI_SLOT(devfn)) |
-		 PCIE_ATU_FUNC(PCI_FUNC(devfn));
+		return pp->ops->wr_other_conf(pp, bus, devfn, where,
+					      size, val);
 
-	if (bus->parent->number == pp->root_bus_nr) {
-		type = PCIE_ATU_TYPE_CFG0;
-		cpu_addr = pp->cfg0_base;
-		cfg_size = pp->cfg0_size;
-		va_cfg_base = pp->va_cfg0_base;
-	} else {
-		type = PCIE_ATU_TYPE_CFG1;
-		cpu_addr = pp->cfg1_base;
-		cfg_size = pp->cfg1_size;
-		va_cfg_base = pp->va_cfg1_base;
-	}
-
-	dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX1,
-				  type, cpu_addr,
-				  busdev, cfg_size);
-	ret = dw_pcie_write(va_cfg_base + where, size, val);
-	if (pci->num_viewport <= 2)
-		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX1,
-					  PCIE_ATU_TYPE_IO, pp->io_base,
-					  pp->io_bus_addr, pp->io_size);
-
-	return ret;
+	return dw_pcie_access_other_conf(pp, bus, devfn, where, size, &val,
+					 true);
 }
 
 static int dw_pcie_valid_device(struct pcie_port *pp, struct pci_bus *bus,
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
