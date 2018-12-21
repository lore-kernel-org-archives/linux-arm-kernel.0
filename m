Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DA7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:29:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B938621903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aZsX6117";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rrBrVyti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B938621903
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=efXuaLgrj+t2Z9LT+ngDFG+fsea98JbHS0zkKenE1Yo=; b=aZsX6117rNd60u
	b4eKmy+ej2wbdNu1tYor8sWJytMkxAwV4jPkc+3zuoG+uTGCDlPWm1/ngUyRYyBVUVTOTk2rWZeIB
	H6OrVg3pD3439k5OlvMN5oCpvawcxqWjXuy5xaAyAgIEXhmVhlhh18U8SI9UUQHqC6TE0icdyVsTg
	MWVD+EgXRWQHXFqi+Bi3KIrL/LEM2xf3xgwgpcWkq5DQlzPAMr3lLM5vYJwx0lgvcUy9hZiP5IMMr
	YOHnx8okVmxDIfgvyBgn8eclQ4WTZ+cDPepPg0Ck7ESqh06uXknCbEx/f9Di7rjzlKpdsaT3TVCo8
	bHi3sS+F2hMOyQWAHsBQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaFEw-0002mq-Hf; Fri, 21 Dec 2018 07:28:58 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaFDx-0001et-J1
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 07:28:02 +0000
Received: by mail-pf1-x442.google.com with SMTP id y126so2186931pfb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 23:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fltZQbZSIQgUXi/Z+xP/+nOzCe8SxwJBjLTLp8RDlGA=;
 b=rrBrVytiDnat/KCHZDBMlr2Q4rK7dzYqetel/FN3IPPM07pVdKgmLf2nl+yaPN4i6h
 reGL4tQFU2bZ2oANOA6ueS9c2dh55HWlgZu+eJYLmRT+yoJI/NuEDPdgVEbbYr3z7b58
 nxs3DDTX2GiLuvPhpBByWtA/l2/F+7TZ2BxmRRt/Qpv5mkJFlQ0iSkk3imIeRrJdRmzA
 1bvBZEkw46EzOinWphj81lvnvNm3BzQxrRSAV3xEDW7IalBojTLDVV9IdQJTEhExudwK
 h6SmNPoY9y06VaT8Ed83PqIHZI7LcknkWGdqsoy6aaZIqqg9wFMsiXq45cElV9ur7Vz1
 z4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fltZQbZSIQgUXi/Z+xP/+nOzCe8SxwJBjLTLp8RDlGA=;
 b=Q7GEMcPBBocImfhcoXEtHWtQnCyHnJm6IDTeqJsRdeYX5UIJrMTyPaZbW2ILW3rpd3
 y5KKap0GM9pzFCrx7tL5uS291yL6HCTKjtc/DXOhNaV9arAuc3wOGc1d39fWchtCn2fN
 Wa2voWD5sdneNfCjz1V4hRMpo0BMWRoN9YU2ZqjhfPy2xoBIdO0CGoq9pSslydsB8PJq
 0VIcxnzYNsswGjD7cPOUgCq+EYuiWlNv1U+BvJIkA/SkPifF0VRtzTfvyaatwdix3dEl
 pTXOMnNLj6vTfuokKyUj0XK0EImde0J2tu+4kFmPv3B8JETUqTK6Z0Q6vBogb3vx4+RH
 qojQ==
X-Gm-Message-State: AJcUukdOMGiVVjr6jkdJVIn2CiRyFO/ygOfD8fJYLyygwsTZMX9vwgRW
 M0si35vAoVi7aTaqxDY+oM4=
X-Google-Smtp-Source: ALg8bN7so8dNzKUeH8NV9oDrLTu7hCW6lX/cL+aAyLv7GoPIg1L2wuobljjFpsXFADTv8zZvuVc/Sw==
X-Received: by 2002:a63:ae01:: with SMTP id q1mr1321976pgf.402.1545377266708; 
 Thu, 20 Dec 2018 23:27:46 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id t90sm44971921pfj.23.2018.12.20.23.27.44
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Dec 2018 23:27:45 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH 04/21] PCI: imx6: Remove duplicate macro definitions
Date: Thu, 20 Dec 2018 23:26:59 -0800
Message-Id: <20181221072716.29017-5-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072716.29017-1-andrew.smirnov@gmail.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_232758_029954_F0B86F06 
X-CRM114-Status: GOOD (  10.60  )
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

Both PCIE_LINK_WIDTH_SPEED_CONTROL and PORT_LOGIC_SPEED_CHANGE are
already defined in pcie-desingware.h, so drop duplicate definintion in
pci-imx6.c. No functional change intended.

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
index e990030564d8..2265f4b40e39 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -100,9 +100,6 @@ struct imx6_pcie {
 #define PCIE_PHY_STAT (PL_OFFSET + 0x110)
 #define PCIE_PHY_STAT_ACK_LOC 16
 
-#define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
-#define PORT_LOGIC_SPEED_CHANGE		(0x1 << 17)
-
 /* PHY registers (not memory-mapped) */
 #define PCIE_PHY_ATEOVRD			0x10
 #define  PCIE_PHY_ATEOVRD_EN			(0x1 << 2)
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
