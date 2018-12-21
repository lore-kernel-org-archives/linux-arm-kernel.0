Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4453EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:30:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 151B821903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WxgbXqF8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTqzBDIw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 151B821903
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qiTCPYDxEOKKzMh/3ApVlegHJf5VdQrLj+lflnfiejw=; b=WxgbXqF8nLbP9c
	Wlg955hzPiCwOuRLvefGcmMK4yd8l4DQ/mdlD2J+/S+rj3h/+0I+OaXpheriL+YTLZ1T+olzXW1OU
	aa2T0AGDtvcgpKbYG82HR5gZ3jHo4J6bO/99v7v4btR3CbZYERtuFgxHHaHtyq6YKUDzwuKpOx3zu
	FT6a8iHTfeMFQ2rA4t9S38kc1KJaFDDbtaGSv9wOM5Tk0Rj0GYxRm8Kcag+vF4vw2GHayM8B/19tt
	pjq6W5+3DleIz/tIQujCr9frNn5agWW1LavMxP2jIGz7SgAzkxJDM/ekpwFwPuJSL/sy8/k5It6sQ
	IAbvOySfEr5pCPnHwueQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaFFt-0003lq-Cd; Fri, 21 Dec 2018 07:29:57 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaFE5-0001hY-FZ
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 07:28:07 +0000
Received: by mail-pl1-x642.google.com with SMTP id 101so2106728pld.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 23:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HjLeQTWp5O7b44WjnLWHOp2yQfeZyWOrOmzsZ5Uzh4Y=;
 b=KTqzBDIwbk8ZHx2tP5xo+RJ6k0Rtiom1wUPdSfWrQLfmWAWIcDeb9pZBilfkdAy0L2
 16e1Y+iBEIA2ewRbwsdjFjZj2+cvI0wWoN1bCikxwzltvLQVp0WzC+ehLcBuf1qQqpIK
 HKwGJmRDYq8XLNMn76kI2T7ZeB174SgVkSwl0FiwW7Wnt/HKaEZ/qL1HcOQ2VtlAzwAR
 JvyZdIN5aklji9Ik6z01yKMCx0d22urVSNlTu9nIJMZ3rTgYFacEs7JiEqfbEMHPYxMr
 09UD9dXs2keLcKMbiFFjm22Hle8Px1eR5itAbRLp5WIhADejfBAm94pbaChoH+D3M3fJ
 1u9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HjLeQTWp5O7b44WjnLWHOp2yQfeZyWOrOmzsZ5Uzh4Y=;
 b=QTZUMm+C0KdXf61INYnZ5isGYBSTmxPQRvXKfns5pz8AuBTpYwnp9GpQd5bBQrSWpY
 fOLJQMn9WoPTEkq4qV1LZeTzfE5Frt8Ok+UzRO7Dk59+0vDtcQ9o+ujoS98NZronASFi
 ihLiynovtIBqqvtsKsEoK1GV+nZrWgXMqaxNcdGfWHGM+5Jmz4372z/mDVkW5YfFJqzd
 4IoSuvBx4aaSxqJJIeFYAqoB5SMP+lCDihme8qzPwIpgA/EtF4PpV9Uyd2vPWRDpxXHN
 gpLFD8a+ZDdUKLFFlKxPJGjJXb+X/nJixahYR3lDlQCE0V99KYVYBqzLqqyufPM983tF
 T6AA==
X-Gm-Message-State: AJcUukfxWJbLM31nFN7mPiJpDkp4mx59fb6BJZiqe1SWJf8H1rW5gK4f
 YgMpfrpdYaCT+E2sxlVhO+I=
X-Google-Smtp-Source: ALg8bN7D4v9/OXU3SC/7OBc9bHk3mU9wKahu3Y3BLBBhoK5P7vGe6/FObat6UBE2nlztKwrrrd7oAA==
X-Received: by 2002:a17:902:f64:: with SMTP id
 91mr1437737ply.132.1545377274451; 
 Thu, 20 Dec 2018 23:27:54 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id t90sm44971921pfj.23.2018.12.20.23.27.52
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Dec 2018 23:27:53 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH 08/21] PCI: designware: Share code for
 dw_pcie_rd/wr_other_conf()
Date: Thu, 20 Dec 2018 23:27:03 -0800
Message-Id: <20181221072716.29017-9-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072716.29017-1-andrew.smirnov@gmail.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_232805_746813_167FF3C6 
X-CRM114-Status: GOOD (  14.26  )
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
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
