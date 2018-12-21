Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55EBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:29:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51FD721903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QGgcWJuX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+v8BjIw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51FD721903
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d7Ol6tZ2odoTI0biw30JYoaPmPAjPyQtsBQ61tPAF7Y=; b=QGgcWJuXEv/LkT
	NOIGHyNQrfasXtBtrEWtk4S+3cRyb7pLxnlDwsH/Pp3h/ztcu6KEethqDtiAmZ1os77Dp0VBpoTIu
	sUSddym2nCZZ5Tphe74+CmGrkklSIuu/cMTTzbGSAFC5gV0gSnsjq3MEI2uSIQWbrLDIZQH3cSgkk
	CKFaR0GROZ5HIXPFvDVsVmCKZ+yLpBmxxkBhDzWrJTRWCz3gRfblrLUC6on8QaBt4F84PKB1qEkkL
	mBgPasi8v6rEcfhylQqxC5Ka4wPIIL5je0FMMaVlqwEUxRzSs5NTFApK+4Sk7x9/n5mon3NqD4/PU
	AuIiKoxAoIBCrd1n+qrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaFFd-0003UO-Cw; Fri, 21 Dec 2018 07:29:41 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaFDz-0001fD-Rq
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 07:28:06 +0000
Received: by mail-pf1-x444.google.com with SMTP id i12so2177882pfo.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 23:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=J1XPUyhdugQdjD1RjA8TcbqShFQ6vNfPgtVDRPKD26M=;
 b=D+v8BjIwaeBkHWCUn0SIc9Vauqh6k/EcRAx/6NL+x5IkPsPR441bJb8zpvorrru7tf
 WQpOaXEz0F1I4yQjIp9cCpkZZstdoQUvPF3cliFgyAXSrybbqb/8LC1ZPsZ/pgufsNk1
 AqoNPMrKD5/PZcnFX859gEz7gy30NgnwpnnDc2apCYY1C/yyrzFwKlpvRbN19PuE17mw
 +WDInCgOVD3V4o4MLInCLYjY7gnhvqx71hXA3y/rOjwfCq96gemXDtl252k3YS+E2Rbb
 76bKO8WtEZwQ1BWm8+h7aJDHIQopoRuLzD2zYjXfyDwD9usA8s80o2WQvuznD7ZxgcER
 j7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=J1XPUyhdugQdjD1RjA8TcbqShFQ6vNfPgtVDRPKD26M=;
 b=hCthartdhE1sKTNscIEGKmvcw/50oCs6NDEPyFJbFnW86+6gLiSPNvVTK+xVaLLxOu
 1LoJnl8i4wYUbFi4YlNa0SVRcybIADVild2VCiI9y2j2aIbs7zP/ZJzEof2A56VNLFVu
 dyq+JcNDg92cJ4OJ7b3NjqxxboOJLCZvXPcqVq1K/nUkQPDZtLfP/425JP6BBc3kGEOI
 alizq9oiHPphEY/v1RIAusi61PSV2fK2NeVKrV97Han+2ivDr6T4ZE+gyAmJ00QmHK6a
 B4MD2JhGvT9M5ukDhO9/kwqFffnbUl+1ppID0FG7KUqi65H/Z+Gdxu1wm/Qof+62vQ2p
 djfQ==
X-Gm-Message-State: AJcUukf1g9vu+WdZIWxnk1sPb0biJgK4Zq42gHv+2QcBFBlEgr2UwEFW
 tPBM4AM7edJFdB/Qt9Ev0gQ=
X-Google-Smtp-Source: ALg8bN7DefFb9r+kRTFCRUxMnRCb2jxCddzSWYYkcXZREmCl0oq4M1VuRrjtSzH7qve+8RIUv4nlxw==
X-Received: by 2002:a63:70c:: with SMTP id 12mr1315807pgh.352.1545377268946;
 Thu, 20 Dec 2018 23:27:48 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id t90sm44971921pfj.23.2018.12.20.23.27.46
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Dec 2018 23:27:48 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH 05/21] PCI: imx6: Remove PCIE_PL_PFLR_* constants
Date: Thu, 20 Dec 2018 23:27:00 -0800
Message-Id: <20181221072716.29017-6-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072716.29017-1-andrew.smirnov@gmail.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_232800_560952_EE26AF73 
X-CRM114-Status: GOOD (  10.21  )
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

Code using these constants was removed in commit a71280722eeb ("PCI:
imx6: Remove LTSSM disable workaround"). No functional change
intended.

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
 drivers/pci/controller/dwc/pci-imx6.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 2265f4b40e39..60803f1f16f8 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -82,9 +82,6 @@ struct imx6_pcie {
 
 /* PCIe Port Logic registers (memory-mapped) */
 #define PL_OFFSET 0x700
-#define PCIE_PL_PFLR (PL_OFFSET + 0x08)
-#define PCIE_PL_PFLR_LINK_STATE_MASK		(0x3f << 16)
-#define PCIE_PL_PFLR_FORCE_LINK			(1 << 15)
 #define PCIE_PHY_DEBUG_R0 (PL_OFFSET + 0x28)
 #define PCIE_PHY_DEBUG_R1 (PL_OFFSET + 0x2c)
 #define PCIE_PHY_DEBUG_R1_XMLH_LINK_IN_TRAINING	(1 << 29)
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
