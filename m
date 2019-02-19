Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BF0C10F00
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:04:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3122F2183F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gcMqoK1/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7EeaW7x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3122F2183F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=S5aVYnwoy4WeXXC/kAJ4JvqWsJ8tJX4I3ZTs1/i5Tx4=; b=gcMqoK1/icQAes
	38RPkxu71gj1EWQBSKNFRt6Qo3OAIOxM0tjtFHwu1ifcBcc6+fjN8LSmu4FNhkbOkzyaLDQAvTcf1
	xkylD5fOtb52WLPaI3TyJQKVwAqRlN3yT6ZzMJdxaCKZLt4sgyohzoqt0uUo+w8fZyuj4jEXFKHtL
	S1Sv8JJIJn24bKBURYKIOgGtdUEtjwgGLkzBVzaIQuXzMQYyYAKGAsmcetNDzIPa+POL8FLT87QYB
	tU24vkao5zpPOzeNKTWkiQtb2hvUXxexdN7aLaXy0rqqRGBr5yHqmCJgMsbunOwi5el3GIl2vaHuc
	DBKH5Lt92vfm6ubq3/dA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwBd4-0002tU-MP; Tue, 19 Feb 2019 20:04:34 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwBco-0002d0-Vo
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 20:04:21 +0000
Received: by mail-pf1-x441.google.com with SMTP id n125so3443296pfn.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 12:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jp5F1KPWJWW598c9kjTLRM3hJfIiNreNpkLqMBLWLxc=;
 b=j7EeaW7xx5pdrl8h3qI/gaSy9x13j2SUiv58eh+Lzn7mlEzP+JjRgZEe3Y2gQiBKtZ
 EqQWvD/mCqfo9Bw8gENUWyEurkocFtx1oOfhg0hqJ+Ha0ppP4F7VkR0fkLa6Md5iZ9gy
 xvdW/FRtssuFz8hkCE2ey2Td2u4KwOcIH+9ERLIXm6XZMWI8MumsDQUXnhHGTzMsESPO
 I3aW6tY6PtsQWXb5RMz/KOskKtoCDatfTfy2SKJDinMCgeLnZi3S7CCqsDahyBmN68A3
 f5LfnDRQpJH+dC7PEv1pk8qzW5pWtFQeZj9HtYkFjBBHN+OSueBS7Er1/69aX8+LIsYY
 YWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jp5F1KPWJWW598c9kjTLRM3hJfIiNreNpkLqMBLWLxc=;
 b=jKxBykk8APHpWoH2xqYfzI7yU53jQfuPUM4TB4bNuXiPwuAqoltpodTUA0Tqp/9ctr
 9d+zCchfWKbZhqp5nsaHdIP0BRyZGiEnvbnF2H60jS/8HnxN5W7GhYSduRL5U4S2/pw5
 xlRlNIuv44wjwv0ZO8upFZBciHK/qrOswl9BUTjGeadWp+qT0uoePorCidxEgAl+RhLF
 maDOBOfkXAfi2febPkCYCFDWvQMs/VWzapjCAIJReSTo8gM6WsO7dsKfCAkEDFnhh15I
 AGbWkEmgOMsoS4D1P66FmFUGRysEKFqP/x78RCAwvESYsChF1JXq/xcw4Sr6ite6b8XV
 XljA==
X-Gm-Message-State: AHQUAuZUiMYQ3wmkN0GZYtqLBomfYQf8pOZuI7cOo6RJR2fvK0epgD4N
 uNLd4YVhWy+sKm9WM2Msf2g=
X-Google-Smtp-Source: AHgI3IYggCXb4ggn0uNchQ1s7xq2ZhI++jGaZDTAUqENU/DRFsKCpY7ZpdJ52mJt9s8XPDcEWcITKw==
X-Received: by 2002:a62:6e07:: with SMTP id j7mr31841489pfc.135.1550606658265; 
 Tue, 19 Feb 2019 12:04:18 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id e63sm31519622pfc.47.2019.02.19.12.04.16
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 19 Feb 2019 12:04:17 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 3/5] PCI: dwc: Make use of BIT() in constant definitions
Date: Tue, 19 Feb 2019 12:02:40 -0800
Message-Id: <20190219200242.17243-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190219200242.17243-1-andrew.smirnov@gmail.com>
References: <20190219200242.17243-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_120420_029993_82D346F5 
X-CRM114-Status: GOOD (  11.09  )
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

Avoid using explicit left shifts and convert various definitions to
use BIT() instead. No functional change intended.

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
 drivers/pci/controller/dwc/pcie-designware.c |  2 +-
 drivers/pci/controller/dwc/pcie-designware.h | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 67236379c61a..31f6331ca46f 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -306,7 +306,7 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
 	}
 
 	dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, region | index);
-	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, ~PCIE_ATU_ENABLE);
+	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, (u32)~PCIE_ATU_ENABLE);
 }
 
 int dw_pcie_wait_for_link(struct dw_pcie *pci)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 279000255ad1..070382869685 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -41,7 +41,7 @@
 #define PORT_LOGIC_LTSSM_STATE_L0	0x11
 
 #define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
-#define PORT_LOGIC_SPEED_CHANGE		(0x1 << 17)
+#define PORT_LOGIC_SPEED_CHANGE		BIT(17)
 #define PORT_LOGIC_LINK_WIDTH_MASK	(0x1f << 8)
 #define PORT_LOGIC_LINK_WIDTH_1_LANES	(0x1 << 8)
 #define PORT_LOGIC_LINK_WIDTH_2_LANES	(0x2 << 8)
@@ -55,8 +55,8 @@
 #define PCIE_MSI_INTR0_STATUS		0x830
 
 #define PCIE_ATU_VIEWPORT		0x900
-#define PCIE_ATU_REGION_INBOUND		(0x1 << 31)
-#define PCIE_ATU_REGION_OUTBOUND	(0x0 << 31)
+#define PCIE_ATU_REGION_INBOUND		BIT(31)
+#define PCIE_ATU_REGION_OUTBOUND	0
 #define PCIE_ATU_REGION_INDEX2		(0x2 << 0)
 #define PCIE_ATU_REGION_INDEX1		(0x1 << 0)
 #define PCIE_ATU_REGION_INDEX0		(0x0 << 0)
@@ -66,8 +66,8 @@
 #define PCIE_ATU_TYPE_CFG0		(0x4 << 0)
 #define PCIE_ATU_TYPE_CFG1		(0x5 << 0)
 #define PCIE_ATU_CR2			0x908
-#define PCIE_ATU_ENABLE			(0x1 << 31)
-#define PCIE_ATU_BAR_MODE_ENABLE	(0x1 << 30)
+#define PCIE_ATU_ENABLE			BIT(31)
+#define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
 #define PCIE_ATU_LOWER_BASE		0x90C
 #define PCIE_ATU_UPPER_BASE		0x910
 #define PCIE_ATU_LIMIT			0x914
@@ -78,7 +78,7 @@
 #define PCIE_ATU_UPPER_TARGET		0x91C
 
 #define PCIE_MISC_CONTROL_1_OFF		0x8BC
-#define PCIE_DBI_RO_WR_EN		(0x1 << 0)
+#define PCIE_DBI_RO_WR_EN		BIT(0)
 
 /*
  * iATU Unroll-specific register definitions
@@ -105,7 +105,7 @@
 		((region) << 9)
 
 #define PCIE_GET_ATU_INB_UNR_REG_OFFSET(region) \
-		(((region) << 9) | (0x1 << 8))
+		(((region) << 9) | BIT(8))
 
 #define MAX_MSI_IRQS			256
 #define MAX_MSI_IRQS_PER_CTRL		32
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
