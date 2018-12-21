Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3545C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:28:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 852BE21903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DgI2iJTR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0RQ48qV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 852BE21903
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=l3vHIY6xFeD20S7W9D4CCuwv6ZCWyhiSCwJaXSi+5qs=; b=DgI2iJTREL4rBT
	3/K0Amz71+aRS67beHxG7Y15Si3n67UJCondOk7+Kk8rHEuwPd3JpiwWT7tY4ahVkQHUDT4Hv5RBR
	K4SIRhpKM59+8puNZFsNQ1motDuX43iIYBa7wI0Tyt2s4I2GCMgArGbhQda7dQirWt1VL17ECx0EI
	GtmU78fmYYOFDZ3S61rHshIfV+moJx4pchL9fbI4p1FEirioZW68sivTR8pUNhnly9ln6kjMNAV1g
	XYLxAMyDfG2Bx/SRHRQLtrfxILfbhADN8eFPfOAV5sxsdVtd/X+iEpSiyrDUUpGmuTLCP+d1THXZp
	zUwE4Nurm6n8+9GSQXIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaFEV-0002HL-IH; Fri, 21 Dec 2018 07:28:31 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaFDt-0001eE-RV
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 07:27:57 +0000
Received: by mail-pg1-x542.google.com with SMTP id c25so2114809pgb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 23:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ztf5h/VWPT7ArQCZI10FTS3FX1Is4iZLXtzrxnewglA=;
 b=Z0RQ48qVC17QilVa8yi3aGpnZwguKR/WyE+4MBjNXYtoiFkEn3DbOkzl8eTrDH8SrC
 hJxXDFDktmaS/zbBB7u4k4n89JoZKkbpYgQpZ0x8yEWuP+8XT9bZudbtFTtRBq1Nj4k4
 q98upDxxo743ASCAc0YT6fzWT6US+YxYF/TmvELJXb1oNidOjrDrU9sDCceGlgxfThCw
 RePdxCZi4zJC+0ftJoX8+WDBYlZ23u8Z3mt/pA0mLyqp7DHFWYYzRmUWTHmYPZZuPvNk
 diXoM5kSofwsbhYNkV8FmyIQzIhmnu7lH0P/NhWmVTh+RP56PJtGN5SwEohDLdQgYU7g
 hp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ztf5h/VWPT7ArQCZI10FTS3FX1Is4iZLXtzrxnewglA=;
 b=A7EtFntYok3prhlDBJPrDj/9sZIPMfyotBb6s5aukANuGDcVXAU+X304LLUI05fvQX
 VaoVra+YVv54UV3KSfCNGQULP2R6E03Q4DEvjRbZ0pv1AycGaetJ3HjIiblze11R8R6f
 Ix6kNY6sfE83WQs08+TB5/s/PYpySI8JoiENlEtMbWBJ1diipgU8SKSJ5FwhS2eMB60u
 7NZnqv372kqgEvVJh00bkwu6MQzU1M1S8P0bxrFyXt0d6Pvca5LzwhkjbzfyP4vIOxGB
 tlcGLo2KsE7VbOadPUOpAThwnlYvleupxF9MjybRIozqw3qB3w98hUwQ8iQX4rtutJPn
 M3Cw==
X-Gm-Message-State: AJcUukd7sRZP6dPzU0NdzHQFiDK5P65CLQinqyU8N2DVjDX7h95IYf9R
 t0mwUPw4YWoqSkLAtdO0wpQ=
X-Google-Smtp-Source: ALg8bN4kuEkoNrTKNB0wpF/5vWQcMC7fRyxDCmjDgx2qgcgkIg7lFa/THiq5EvaaYM5XXMW22MMbpQ==
X-Received: by 2002:a63:9712:: with SMTP id n18mr1307291pge.295.1545377262911; 
 Thu, 20 Dec 2018 23:27:42 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id t90sm44971921pfj.23.2018.12.20.23.27.41
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Dec 2018 23:27:42 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH 02/21] PCI: imx6: Remove redundant debug tracing
Date: Thu, 20 Dec 2018 23:26:57 -0800
Message-Id: <20181221072716.29017-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072716.29017-1-andrew.smirnov@gmail.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_232754_133007_9FB41EF9 
X-CRM114-Status: GOOD (  12.88  )
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

All calls to imx6_pcie_wait_for_link() share the same error path and
the state of PHY debug registers will already be printed there.

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
 drivers/pci/controller/dwc/pci-imx6.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index c87ecc305dc7..6ffadc29d21b 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -603,16 +603,9 @@ static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
 static int imx6_pcie_wait_for_link(struct imx6_pcie *imx6_pcie)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
-	struct device *dev = pci->dev;
 
 	/* check if the link is up or not */
-	if (!dw_pcie_wait_for_link(pci))
-		return 0;
-
-	dev_dbg(dev, "DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
-		dw_pcie_readl_dbi(pci, PCIE_PHY_DEBUG_R0),
-		dw_pcie_readl_dbi(pci, PCIE_PHY_DEBUG_R1));
-	return -ETIMEDOUT;
+	return dw_pcie_wait_for_link(pci);
 }
 
 static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
