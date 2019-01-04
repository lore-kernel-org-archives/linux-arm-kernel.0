Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FA8C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:51:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 107FD21872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OU/55XQL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o0FDJgev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 107FD21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yQwxqhcXCocFPPwphep1vt0FJqVXQ/wKjpTpXonvQHA=; b=OU/55XQLDgZYC1
	6iVxLEL9rdkmehxWQ4yQRr7RrCOw9SuKvkU4fc0KKbUG/sJtc9zQFGHLXHNotMo7ivLk5uABsjhsz
	z1JQdxNTonKHiVwIBU1WqmxGNYZq/eENPU8mHh2+ZnfDPJ/tu3t8dY5P7qdBBvQRdQm6WkguMScBR
	+k+NcRacB71C9X6/58sZGcb1PdXeOTBvUd2ZwEa8AWz92+/P20CPa5yl5Eop94Gtyplt4y/EsmK4V
	RCQIWhfK7kHOkXgLnFioRMKXc8nWKwhJX5vcqMHbPR3qf6s6CfLZfV9NM+946iFlhYAYSt4OxP7xU
	UVZU+FS8c3VqauKx5z1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfTdH-0007IG-3G; Fri, 04 Jan 2019 17:51:43 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfTbY-0004Ib-5z
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 17:50:13 +0000
Received: by mail-pl1-x641.google.com with SMTP id g9so17734282plo.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 09:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=x2fXdz4Ik0AFAzOQLJZdPMvlCQxR5gTcFSjR6Jns4ok=;
 b=o0FDJgev9btFmYYkveMGrkg/Hkmls0C8+1uS/nygLw4Uk7vy/dy9p8BKoV/YhfH3wp
 4vGK5MGwAkx10+ic3evz42ug6d/Sf5yOaTxPqhZP6wjJlVFYtP0ZvgwjLyd76mPsftVQ
 QerpaZdGIkOxN2mZxUgu4kvKEWGSVzRYWONCfW0jLa+y/mwm7G9rnvxe/X9e9xH/R9KM
 +csBimpxYMZfnbZTCSBBaXL2SJ6bER9uaFzg+3aO1jPf7xrzezyC3KP0t2ba2c8mrzHj
 LDoPufDPALnR77DADEmjBJJrrvChh2HBsXvzeZdSdx0YmmMFBczmk/udUxfQ7PZtoy4W
 USFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=x2fXdz4Ik0AFAzOQLJZdPMvlCQxR5gTcFSjR6Jns4ok=;
 b=Si3hplWh/sf/UkEt5t/6TV/DjjjHBL9ElSNeXUK+A3GVnOeZTUtqsTQyob335PoXTl
 MvIuk18QzzzqluAI+pWnB87HTmQ941Yj86tCMbBMU2gMVuwpCp2/ZyVwjw/+96RKS+5O
 OqY42utfZxD3w9Op9XWPVvskBG3CGYQbrIEp6xpy+ffXN2XZXr+lRpAbM6OSYbjhzEX3
 ar6DRIDy797Hb0zCrPyur53nIW4D9seiV32NpUrkkU3/6SbYswN0dRqmnT56jsVjkrTJ
 CaKEbhdDeaKLE1zA2tCeJ4Y78oDyNQtYsepZ51UlZBGCzkmkeGlgKEnYrkt0rBD+/aYH
 nXkQ==
X-Gm-Message-State: AJcUukc0jmHLqepcWbbiDeWwiFddbIFMo51JH9gcrftkv5tteqefsrbB
 78tHIGChN6bg4oW6Vq3yI1I=
X-Google-Smtp-Source: ALg8bN5ad63oBiClCtZSZLIALm9EAJPHW2K5pki0ZrSO3gi4fH5hTpIUwFEptho0YVi2j6ZqVHykMA==
X-Received: by 2002:a17:902:1105:: with SMTP id
 d5mr49894927pla.47.1546624195161; 
 Fri, 04 Jan 2019 09:49:55 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id i193sm100699632pgc.22.2019.01.04.09.49.53
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 09:49:54 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH v2 08/20] PCI: dwc: Share code for dw_pcie_rd/wr_other_conf()
Date: Fri,  4 Jan 2019 09:49:13 -0800
Message-Id: <20190104174925.17153-9-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104174925.17153-1-andrew.smirnov@gmail.com>
References: <20190104174925.17153-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_094957_410163_FB49A4EF 
X-CRM114-Status: GOOD (  13.93  )
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
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, linux-kernel@vger.kernel.org,
 Fabio Estevam <fabio.estevam@nxp.com>, linux-imx@nxp.com,
 Bjorn Helgaas <bhelgaas@google.com>, Leonard Crestez <leonard.crestez@nxp.com>,
 Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Default implementation of pcie_rd_other_conf() and
dw_pcie_wd_other_conf() share more than 80% of their code. Move shared
code into a dedicated subroutine and convert pcie_rd_other_conf() and
dw_pcie_wd_other_conf() to use it. No functional change intended.

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
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 61 +++++++------------
 1 file changed, 23 insertions(+), 38 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 721d60a5d9e4..8f957cd6901b 100644
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
