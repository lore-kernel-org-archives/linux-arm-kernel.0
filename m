Return-Path: <SRS0=d92h=OZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932F3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 23:10:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 353282082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 23:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pbFVyLZ5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X672KZFE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 353282082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jupzvMuK1hb+BgqBlCPaVEJMeWqP0kzKRwzz4vPfV0Q=; b=pbFVyLZ5gkW3jI
	KpAuxvdhhkCByyECveBYFFQUU3TjzZQl+8uvlkXosz29p1XLTTYQdoek5jU0aEoxUzJPBUPeqO1Gl
	P7jbgu+zF+/uAWu+tQlo078Djd82jl/ltX9rLMPgkKVJRGmBmkn5nzAywDyHe4Aod2pUBYm7wDE3y
	z1Uan0TvLJbBlskvey5HH5JpxMO+fs7zr5CkrfLGWX7Nx9W2ZLcajyVxlVPrTFpIGiYEmZYO6+dvM
	TCarsHZ9s3CCLmGwUM7pjipiqOyNvFYAGxic/nOkkVR7995D/mtLuTDRQMH5y7AWWdCcWT97oYMiq
	+51umTx5iUOmOby2ET4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYfYN-0001zr-2j; Sun, 16 Dec 2018 23:10:31 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYfXk-0000AL-Gr
 for linux-arm-kernel@lists.infradead.org; Sun, 16 Dec 2018 23:09:53 +0000
Received: by mail-pg1-x541.google.com with SMTP id w6so5174537pgl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 16 Dec 2018 15:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=630bTHnJjqwfGqvwds3Arb51H+EGehA9C94eFD613KI=;
 b=X672KZFE92BRla2JFSoPoNeUns+n7a5/84TFppsKFpoG4xa0SgdhWK8AWWfkhMkHUf
 Tj/yPBcGWr89ZoyZLwasu/T1alnt2F4nZCa34sH+suoZOLMbE4oLShOBIRE0MZd7SmoI
 d3IIbxbkRPGH0lEYUtGHcIXPu6Ay95GVWqTaPOdrPA0cF6MpUYNaTNxBNqxOAlUr0Ito
 SkTjXzuzycZI000LslYUSOnZCVjzODqSgL4tuyftG6HyktxtdJlPvqgYTckQeJ4ehaV2
 YgigRSDiq9dzgoKSnZgUP4CM4mBZHoW0K5/f0ZU+NgOm/GiqQP/U9HGZGgyQqJH/HnMS
 kufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=630bTHnJjqwfGqvwds3Arb51H+EGehA9C94eFD613KI=;
 b=iygKxabeOlCKDSwPd7Qsr4Fg4uvO6Pe6jgtRgPxx9Rdhl2C6etfxHT6U6xNMVJDyyR
 /+yOK4mrfuY715LvkzVY2c7h+jPRfJzv+jhFNkolmMxw7ew0QMqz2vLlq8+8Csb8q2Ls
 qfIxIQyaqJAxbnFUTnH2yArD/HxS/MlpBL2FGQS8thsFSMCJb4i160h6sF8+k7y8Zz/g
 hYuvplFP473fb8/hLDG0K0NsyissA9xmr8atboaF+pJGOT78s3XvV0onSETjH3lNiMvA
 k7n95KB02sPOXZXOpmesSLCBmOhJIxH8iv3QwGI7je1cb1gLrAulwz7P3kjefhvgaHs+
 HT5w==
X-Gm-Message-State: AA+aEWZGryM4XMC+g5faBX1Cg927UiTyXjf41U/84VR25NOxKic7FfBs
 1/k1VputZkt3uE/XyJoiuzY=
X-Google-Smtp-Source: AFSGD/UyHsKL9Qn3NP34DOD/KjQSdkrY6aB0QcpgakfwuqCeosmY57w6BcYvSr8IX1U0njnVsENeWw==
X-Received: by 2002:a63:a112:: with SMTP id b18mr10246376pgf.440.1545001781772; 
 Sun, 16 Dec 2018 15:09:41 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id d18sm13837878pfj.47.2018.12.16.15.09.39
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 16 Dec 2018 15:09:40 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 2/3] PCI: imx6: Invert checks in imx6_pcie_reset_phy() and
 imx6_setup_phy_mpll()
Date: Sun, 16 Dec 2018 15:09:15 -0800
Message-Id: <20181216230916.22982-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181216230916.22982-1-andrew.smirnov@gmail.com>
References: <20181216230916.22982-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181216_150952_557297_8AA1B246 
X-CRM114-Status: GOOD (  11.38  )
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
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>,
 linux-imx@nxp.com, Bjorn Helgaas <bhelgaas@google.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Chris Healy <cphealy@gmail.com>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In order to avoid having potentially ever growing list of variants
that don't support methods implemented in imx6_pcie_reset_phy() and
imx6_setup_phy_mpll(), change logical checks in the to check for SoC's
that _do_ support what they implement. While at it, share the code via
a small helper function.

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
Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 4b7f638b8aff..59658577e81d 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -256,12 +256,18 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
 	return 0;
 }
 
+static bool imx6_pcie_has_imx6_phy(struct imx6_pcie *imx6_pcie)
+{
+	return imx6_pcie->variant == IMX6Q ||
+	       imx6_pcie->variant == IMX6SX ||
+	       imx6_pcie->variant == IMX6QP;
+}
+
 static void imx6_pcie_reset_phy(struct imx6_pcie *imx6_pcie)
 {
 	u32 tmp;
 
-	if (imx6_pcie->variant == IMX7D ||
-	    imx6_pcie->variant == IMX8MQ)
+	if (!imx6_pcie_has_imx6_phy(imx6_pcie))
 		return;
 
 	pcie_phy_read(imx6_pcie, PHY_RX_OVRD_IN_LO, &tmp);
@@ -637,8 +643,7 @@ static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
 	int mult, div;
 	u32 val;
 
-	if (imx6_pcie->variant == IMX7D ||
-	    imx6_pcie->variant == IMX8MQ)
+	if (!imx6_pcie_has_imx6_phy(imx6_pcie))
 		return 0;
 
 	switch (phy_rate) {
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
