Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C331AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:31:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9068D21903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MoBWwfz2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLiKURRB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9068D21903
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JSPJSUzSDctkrq57O5v4IKquwZpMfm3lcDF3SLjaD78=; b=MoBWwfz2QvcMq5
	Vo2Rx2l7gwjMQU/u1t/qyN/tMXRRkRaSYBS6eyiUG+o2GwKRAwI5qv09GAB0z5F5Z+aZap+bPNbBt
	2bHFLZhn3UTpgSaNBYYKbNrE6+iYlo1k4cEIO/cHxNWXQraauAaNK5H2a0rYnHnAhTufwU7atGHHt
	BsTDG/5S7UJo3prPxYkYvb1MicFeqzx5/uESfPJ91CWDbr7oQQ+pQ2uz5J0trpQZR4StfjoJq3mEV
	vaedomrUnTwA+1h6Tvh9dWhSApCWmStrXs2X/e8nsbZdhx4KgGP0j/ZKuemroFlP1ZiuYimD2I/Ww
	HUkItGRaFpw68Qu9EAxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaFHl-0006jB-EQ; Fri, 21 Dec 2018 07:31:53 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaFEI-00024u-5u
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 07:28:25 +0000
Received: by mail-pf1-x441.google.com with SMTP id i12so2178520pfo.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 23:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ceA3OOHkrp0/rBgfzfMs4oo9EwOqW1+SB1EA7e79xlA=;
 b=TLiKURRBbXaznllUhiqXzwJmMzNw9zNpxqRqosDaxG7rXC5+tiqPlP5vHq/TDxHkEg
 pivODxC1imDMsSrrqPKMbzS25+VaONbZAm834Vt+t/7BONwc++ZWNO1HVALX+Lseh3gf
 RUX95M11hEaQ+QrCxmaJ+pwo2VgmV2oPxHMhKcmnkkRq7Ry/1roNPNKdKif5NZO0XfRk
 xWbRoeFMmOltYYW0BV/y0jri+x2f01mptdX6QMsJ5tqWAQqgMQWl6BGaePye33jHOyoZ
 S1P8Cj2+BuNOwzltRmfkJTTq6DwqwFyAIt1AV/OJOECI0EopA5qGxpV+2/74tMSoSBZi
 jVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ceA3OOHkrp0/rBgfzfMs4oo9EwOqW1+SB1EA7e79xlA=;
 b=W36+brqSKalwh3YWq0M63qazUF1QfmReEIQhkMTZ1HK33tFVhkyLoONy7XKog+aj+d
 HuH1QKmL9LfkSBN6C7W4DVS2CMPd+0Q5N6azBlfh3l+WsvH0x+I1f2cTLVETURYF5pvI
 ROV61Sawt6kD7oKbRVcEwAgNxUrUzvPuAh+yd8p91VwBjmt5CNS7iPBAn/Niiv3TDUiE
 Xmkh1nUctvtAx27hynBJCAca323V1zCGjeM3UbHAd5Kmi+Lg94PG3JoVJuWOH3/5Kkuv
 6y1Bu+oUFyIvVBgWHXAa99+2wt4aeCarQwyDz21ZMdn/z+f9NScJzDRZgO8Fjbg4H+Pr
 EOag==
X-Gm-Message-State: AJcUukf5gKBucAP7iLrZNLrlN9jPzipKImrKSUbs3CO39TkXz6u2z6oD
 wjGd2fqBiOvlK7ao/YB0pSk=
X-Google-Smtp-Source: ALg8bN5zSz1wxg+PBVvIZ84CcYmXtIjNqUGxU8XxDrd1F6hHjuSlR1HFpP0O4hXHsxF4/BZSSjKQxg==
X-Received: by 2002:a63:a611:: with SMTP id t17mr1326464pge.338.1545377296834; 
 Thu, 20 Dec 2018 23:28:16 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id t90sm44971921pfj.23.2018.12.20.23.28.15
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Dec 2018 23:28:16 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH 20/21] PCI: designware: Make use of GENMASK/FIELD_PREP
Date: Thu, 20 Dec 2018 23:27:15 -0800
Message-Id: <20181221072716.29017-21-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072716.29017-1-andrew.smirnov@gmail.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_232818_796484_0B435638 
X-CRM114-Status: GOOD (  12.14  )
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

Convert various mult-bit fields to be defined using
GENMASK/FIELD_PREP. This way bit field boundaries are defined in a
single place only as well as defined in a way that makes it easier to
verify them against reference manual. No functional change intended.

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
 drivers/pci/controller/dwc/pcie-designware.h | 29 +++++++++++---------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 348e91b6daa2..0de653284fca 100644
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
@@ -45,11 +47,12 @@
 
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
@@ -75,9 +78,9 @@
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
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
