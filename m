Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCCBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:29:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E76821903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nJSY1CgN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShvpZPrv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E76821903
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VcqoTDE5gALEDwe4pQgKXjU7n2F+mCr92gSOlWOnWqU=; b=nJSY1CgNexINlf
	iDVT3UQv3LZ2XcPvfnTFtPiEfp52O5hy25KJDJ5bWPpLtCYuRGjOAcaeSOATdAOhfNOJ1Fy6TX/78
	+DJ1H8c5N/ERg4hb/3aWmx0q2H+X4p144NPeNAQO0SNgqT0souBWWnwYDVfj3FA8WzzU+FJn6CjP4
	e073/sIhkVaCpuNbkOwB6eBEWFl7Z3OIRClm7bQ3Bv1bP+MWfV4oAa0MHWDZZYj4nKPNSiwCFTzbs
	QuNChj4C0V6QzD9pUhSek8qgIf9DcCF0BgtJAghfbY5O+s8dfNEw7wf2aAMb6sw5BQEse9Yz5AyIE
	A1d1Mosd8oyHpeUBlFqA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaFFS-0003Hh-4v; Fri, 21 Dec 2018 07:29:30 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaFE2-0001g7-6w
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 07:28:06 +0000
Received: by mail-pg1-x544.google.com with SMTP id z11so2122192pgu.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 23:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dUwToKhhL89vx1LjgzipUu4yk4Mqqx0vIAofTHjHZac=;
 b=ShvpZPrvcZfDw0J1ASzD0s3YT+jY0oS1MadiUlCWWjzz5X5zDssoIvCHAloq9QV5xC
 NjF1rpzikWkybtHcGu4YjiZKY4KAoohtfSZsMzW1qJB+ZSiDdNcHxyug7LkwUWD5OpTk
 qmksrnvAHxMg9bf3m5lOM4e7opmqBfi2JuMtRoBinthmsui86Y5DvN1TzH8lKSWPBgWh
 xCjIGY45Q6rwEo5Bm/5Vo8c6WxKZO2lCzUp0tchyY/Odxeyts6XvWLZjmlZhEtuekZCE
 UlTYTDThf99GmmFa6/nTdxRaY+Jr7AJymU93pMSI6FDUAjJHf3J/K4+4q5TDxLV9RDrS
 PerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dUwToKhhL89vx1LjgzipUu4yk4Mqqx0vIAofTHjHZac=;
 b=tKrhsQS7L64Dk44jLEtWDFm0rQUDiyvhMxgdtIh2swDk0V8Us3OnPvdIaktcNnQEW3
 UDlgU8NhxK5GuhPbD65b/SyiYXd62h8RrRgOyMKNg0fAbLuRokMzoUPZkc1efTGTY2IO
 CdH6ZRglvm7d/8DbmSuhOVTlaE1BfuhA8QrMeKDUeuOptS1tC83g+QP41cQkl1MOpq1D
 pnk+dLy4+ZBI5FAOjk80nfQoSNmlv/FdQVJub1cyztCTedDqPEjs7Gbw3BCOdZwzXWTL
 W5J4KDyxXFo6pn4oeI+ZZbPPmKUPLtp1JUo/hvbu8WKhfBEm4hv9uhUhsjPOIFp4mtFa
 O+pg==
X-Gm-Message-State: AA+aEWZCi2svezFOyGUpHysqIJhHg0/1f/d0fXRNo10LCPnXWWRTX+YH
 kzCgWKqniFr1g0e8I+Ork5k=
X-Google-Smtp-Source: AFSGD/VUQQi8yisb9aoewB9+qE7nuQLuYz8kYTpt3NojM7V2vPNF3ZlRLRnTQ6Sz6/Yix3QYYdtGqw==
X-Received: by 2002:a62:a99:: with SMTP id 25mr1380678pfk.121.1545377272845;
 Thu, 20 Dec 2018 23:27:52 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id t90sm44971921pfj.23.2018.12.20.23.27.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Dec 2018 23:27:52 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH 07/21] PCI: designware: Make use of IS_ALIGNED()
Date: Thu, 20 Dec 2018 23:27:02 -0800
Message-Id: <20181221072716.29017-8-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072716.29017-1-andrew.smirnov@gmail.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_232802_815052_F63AC461 
X-CRM114-Status: GOOD (  12.80  )
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

Make the intent a bit more clear as well as get rid of explicit
arithmetic by using IS_ALIGNED() to determine if "addr" is aligned to
"size". No functional change intended.

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
 drivers/pci/controller/dwc/pcie-designware.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 93ef8c31fb39..67236379c61a 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -22,7 +22,7 @@
 
 int dw_pcie_read(void __iomem *addr, int size, u32 *val)
 {
-	if ((uintptr_t)addr & (size - 1)) {
+	if (!IS_ALIGNED((uintptr_t)addr, size)) {
 		*val = 0;
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 	}
@@ -43,7 +43,7 @@ int dw_pcie_read(void __iomem *addr, int size, u32 *val)
 
 int dw_pcie_write(void __iomem *addr, int size, u32 val)
 {
-	if ((uintptr_t)addr & (size - 1))
+	if (!IS_ALIGNED((uintptr_t)addr, size))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
 	if (size == 4)
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
