Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5922C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:32:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 852C621903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NL4HbwFK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9+tbe7C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 852C621903
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cB7tTwVnXfuWOx2xVyj+41RIFWc+6+HMfIVvEv2BiTg=; b=NL4HbwFKXEzClL
	9nxj/yxn1aD38aYOTdfxRheVFN5nwTuN89pn6KOx0SFNj1CCCAJrftYIHfnAif2tT+eWdpUCyVPIk
	ywNgs9bHN7/F4wPNfxuOUsW8qXU5Aqbw9IIt5QydT1hLRDcBxVB4PXo6pjBEjLHS5wmHJbV0MGscU
	UFvc7l/EQ1vc6yFUjPd5Yn6RX6GomBDT96IPUQPMuuKZRb7pMq9+y7RWNYvgribiNrX2Yy20cVrer
	sg0hJgfO1JTuTRTja/xWc5ev1y3sxAaQA9jOzw2pnMNTzUERb53OT/Pz/8/5oOwLajOVShBqnKv7B
	OM9d43z466drlWt4ddBw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaFIk-0007KI-22; Fri, 21 Dec 2018 07:32:54 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaFEQ-000235-Cv
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 07:28:33 +0000
Received: by mail-pg1-x541.google.com with SMTP id j10so2120847pga.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 23:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TOnTTJb5k0hJqk9drUFS28Vo1VkvNAjAcTVESkJjprE=;
 b=a9+tbe7CR5UO46XozmMgmDfw5gfEdE1Cgh/dugA1o/gngbng/PNMICEPKMOiEGVoE/
 S0Ury7jhXQ3IZSU3XOlfgsUgm3Gm+r8Y+T9uVMR0xWRL3q11dZRUJOauZzRLcULGHUDT
 GpL0O2KCZ5lokYMl7OSIMwYg3ON5jlbc0hYt1mPV854yc7ORVA2U7BrX2O2Ygl15xElB
 KG5R7F6pXhg1WnrRHBZX+ZeX6Jqp6JTXxB5Ze8oqeWbYGxS90UMK7DbyjxWWs0yV8CQd
 xqSncCapvzUcfhyzzvyqVR+ZpsNwczR1ZHh/6rZbf++CF2o6d/rgeCQd2yNlpaPcsYd1
 Gqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TOnTTJb5k0hJqk9drUFS28Vo1VkvNAjAcTVESkJjprE=;
 b=WlaSf07Mp2YMvAA/b1J/USWCQt9G88wVPYq9Pz1tIk5ffhoDVKBxQO5UdP70bH8ZdV
 92F3FQL1ymdl17NpkDWRdkKKifIxyzXAk6Vms/ofgAA0aaFt6EvoAedht46St+wlAyZm
 KBFYnXTSGZUL1UaNBLrJs5S/0kY4v7IYOsO2hpTEBWSSAhhaA0LDldW1thqZZ/rVTw7g
 SA3FsV8wH/ANcXO6/+9VLjvNVzWc1zUVQ9/0BwQ1mD6K+yzZyqsJagg7mF0uO1cuQMVP
 ZrfxJoJbHmHiyyBZJzHmX8WiI9HtqiSe+2B2ufAzcmz0itR773JZ7sfkEO/XscfIFOfq
 VOSA==
X-Gm-Message-State: AA+aEWY5iIi35gKvaZM2TpmGpkzRBCquVD69i8a9My9CxxQAe195FYEu
 VheN6WMh4uy2sBMznSs9Be4=
X-Google-Smtp-Source: ALg8bN50gFFgY3nBEzPGNZnloJzl5Z8OSiIYjw1gQKEwJYi3/td0fh6QxZjdAqqMWVWlHBHpzlhj2A==
X-Received: by 2002:a62:15d5:: with SMTP id 204mr1421947pfv.103.1545377295233; 
 Thu, 20 Dec 2018 23:28:15 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id t90sm44971921pfj.23.2018.12.20.23.28.13
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Dec 2018 23:28:14 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH 19/21] PCI: imx6: Remove magic numbers from
 imx6_pcie_establish_link()
Date: Thu, 20 Dec 2018 23:27:14 -0800
Message-Id: <20181221072716.29017-20-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072716.29017-1-andrew.smirnov@gmail.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_232826_938567_7F186ABB 
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

Explicitly define PCIE_RC_LCSR_LINK_SPEED and remove magic numbers
from imx6_pcie_establish_link(). No functional change intended.

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
 drivers/pci/controller/dwc/pci-imx6.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 678f5fa85e12..2b312f287fd7 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -79,6 +79,7 @@ struct imx6_pcie {
 #define PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK	0xf
 
 #define PCIE_RC_LCSR				0x80
+#define PCIE_RC_LCSR_LINK_SPEED			GENMASK(19, 16)
 
 /* PCIe Port Logic registers (memory-mapped) */
 #define PL_OFFSET 0x700
@@ -688,8 +689,9 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 		dev_info(dev, "Link: Gen2 disabled\n");
 	}
 
-	tmp = dw_pcie_readl_dbi(pci, PCIE_RC_LCSR);
-	dev_info(dev, "Link up, Gen%i\n", (tmp >> 16) & 0xf);
+	tmp = FIELD_GET(PCIE_RC_LCSR_LINK_SPEED,
+			dw_pcie_readl_dbi(pci, PCIE_RC_LCSR));
+	dev_info(dev, "Link up, Gen%i\n", tmp);
 	return 0;
 
 err_reset_phy:
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
