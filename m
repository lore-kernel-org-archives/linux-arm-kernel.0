Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DD6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:34:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CAFC2147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g7n0fag5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RmlccQeC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CAFC2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=++MsDtHZ/lnxUs6pJ+xDHshejnFz2fXj55TDiN2uCpI=; b=g7n0fag5tKl8yJwickWlSPEBFp
	uMDFQcPnomx3+IgzcfhljebBTIti82wBMRYl/TNwKYe3gs9ESsRSye0dit8BGIi0M6aRcZLEPHcXr
	EAuR98kyBmpGH99bhpFgwIIq+zqWUJOjH7y1MK29kKKXTcdKZ0KSvso/cF6C7t1pTkhdeGlA98HdE
	gKIa32VTW6sQxGSkxZ9KTJ6RpJP1h3j+W86l66gBs/oer/xQCiIboSMIG4mk+OlzVvff0NTTTYHNk
	RwU/7Iy2sngvhskzIPQAE4gjmc/NRKAhpY1clD/Yq3cOH3ZZNoQm2pqTunKZabN0nqRhUbcgGJlq0
	kDpGbsag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwUpH-0005Vd-Pk; Wed, 20 Feb 2019 16:34:27 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwUp2-0005DW-6h
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 16:34:13 +0000
Received: by mail-pl1-x641.google.com with SMTP id m10so2810379plt.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 20 Feb 2019 08:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=5JMpbtJFok6NmyP09wHWoeTClnCNAZoek3gSUOSs3x0=;
 b=RmlccQeCYowaxbJ7ccWoPEOLRf/t0oWGtdbuaYzv+WOyd9XtLfEjlHPhzZT9uyTbsy
 ZMB4mcyyQn/rwdJnS5z3g6L6BxV/EdbgUBowBsNpsUH5zS3JouwtPVvIi8QXrp5+BIQq
 hNf1+ASiQ2Z1/AYpTJBwW2GP83LFjCRPr39s8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=5JMpbtJFok6NmyP09wHWoeTClnCNAZoek3gSUOSs3x0=;
 b=We50FjjxI3M27UkyoYwe+/X07HhkedXY2Sz3daSiLNe1vMdXcAt9JMsjf5DqGL1eQG
 F4M8+YEwWZyF755DZ2EcfgHZASOmKzCwukhoy331DPfSeGJhPoKxZ9AECtvVnz+Rn988
 xSZNTGIbwPQWLa3kYd5dlf9F0O/xcBWwosfuWGoOwCnZz5WEmivQJWDNsegJSW298ZBv
 0wPdGEkug4gz2xTbfajxRvabv5c3DOBbPhmqeBTVBAlgo/z8vzlpsrjuLqfAgKGbZ9WF
 C4d6hivaT8k+atq78x/PdK5yJz7Bghgkt6CdKYjtrAGly9Xqqssx4UYfI4rKKOr8a+lM
 KkoQ==
X-Gm-Message-State: AHQUAubD7cQZpZqhc0QHO3AwpzngoPBVJOD2QRySkExDtL44WBNaDj9j
 u173UXpECqPiTclOt0lSqsCPQg==
X-Google-Smtp-Source: AHgI3IY8WjyHVjXGBqE+g1rHOxfoj6OPgU0zvCl8moah1jJaqkXrjklULWWDfZcULwCmIUPaJhEeVg==
X-Received: by 2002:a17:902:6b4b:: with SMTP id
 g11mr36696005plt.92.1550680451148; 
 Wed, 20 Feb 2019 08:34:11 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
 by smtp.gmail.com with ESMTPSA id t10sm26556717pfa.151.2019.02.20.08.34.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 20 Feb 2019 08:34:10 -0800 (PST)
From: Srinath Mannam <srinath.mannam@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>
Subject: [PATCH v3 1/2] PCI: iproc: Add CRS check in config read
Date: Wed, 20 Feb 2019 22:03:54 +0530
Message-Id: <1550680435-9706-2-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550680435-9706-1-git-send-email-srinath.mannam@broadcom.com>
References: <1550680435-9706-1-git-send-email-srinath.mannam@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_083412_245371_CB576B63 
X-CRM114-Status: GOOD (  16.21  )
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
Cc: linux-pci@vger.kernel.org, Srinath Mannam <srinath.mannam@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In the current implementation, config read output data 0xffff0001 is
assumed as CRS completion. But sometimes 0xffff0001 can be a valid data.

IPROC PCIe host controller PAXB v2 has a register to show config read
status flags like SC, UR, CRS and CA. So that extra check is added to
confirm the CRS using status flags before reissue config read.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
---
 drivers/pci/controller/pcie-iproc.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index c20fd6b..b882255 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -60,6 +60,10 @@
 #define APB_ERR_EN_SHIFT		0
 #define APB_ERR_EN			BIT(APB_ERR_EN_SHIFT)
 
+#define CFG_RD_SUCCESS			0
+#define CFG_RD_UR			1
+#define CFG_RD_CRS			2
+#define CFG_RD_CA			3
 #define CFG_RETRY_STATUS		0xffff0001
 #define CFG_RETRY_STATUS_TIMEOUT_US	500000 /* 500 milliseconds */
 
@@ -289,6 +293,9 @@ enum iproc_pcie_reg {
 	IPROC_PCIE_IARR4,
 	IPROC_PCIE_IMAP4,
 
+	/* config read status */
+	IPROC_PCIE_CFG_RD_STATUS,
+
 	/* link status */
 	IPROC_PCIE_LINK_STATUS,
 
@@ -350,6 +357,7 @@ static const u16 iproc_pcie_reg_paxb_v2[] = {
 	[IPROC_PCIE_IMAP3]		= 0xe08,
 	[IPROC_PCIE_IARR4]		= 0xe68,
 	[IPROC_PCIE_IMAP4]		= 0xe70,
+	[IPROC_PCIE_CFG_RD_STATUS]	= 0xee0,
 	[IPROC_PCIE_LINK_STATUS]	= 0xf0c,
 	[IPROC_PCIE_APB_ERR_EN]		= 0xf40,
 };
@@ -474,10 +482,12 @@ static void __iomem *iproc_pcie_map_ep_cfg_reg(struct iproc_pcie *pcie,
 	return (pcie->base + offset);
 }
 
-static unsigned int iproc_pcie_cfg_retry(void __iomem *cfg_data_p)
+static unsigned int iproc_pcie_cfg_retry(struct iproc_pcie *pcie,
+					 void __iomem *cfg_data_p)
 {
 	int timeout = CFG_RETRY_STATUS_TIMEOUT_US;
 	unsigned int data;
+	u32 status;
 
 	/*
 	 * As per PCIe spec r3.1, sec 2.3.2, CRS Software Visibility only
@@ -498,6 +508,15 @@ static unsigned int iproc_pcie_cfg_retry(void __iomem *cfg_data_p)
 	 */
 	data = readl(cfg_data_p);
 	while (data == CFG_RETRY_STATUS && timeout--) {
+		/*
+		 * CRS state is set in CFG_RD status register
+		 * This will handle the case where CFG_RETRY_STATUS is
+		 * valid config data.
+		 */
+		status = iproc_pcie_read_reg(pcie, IPROC_PCIE_CFG_RD_STATUS);
+		if (status != CFG_RD_CRS)
+			return data;
+
 		udelay(1);
 		data = readl(cfg_data_p);
 	}
@@ -576,7 +595,7 @@ static int iproc_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
 	if (!cfg_data_p)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	data = iproc_pcie_cfg_retry(cfg_data_p);
+	data = iproc_pcie_cfg_retry(pcie, cfg_data_p);
 
 	*val = data;
 	if (size <= 2)
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
