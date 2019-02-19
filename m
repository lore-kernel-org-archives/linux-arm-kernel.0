Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844D0C10F02
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:04:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4902321738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RmuIYmfS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExGmZZHM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4902321738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TV8mTdx5tniguZV+AEoHYkW5BmG0blglw9zlanEckeI=; b=RmuIYmfS6NkfCN
	IzovLs09OlIWtdMpLeAVr4KqXj6XVFvavNJa8CAY3wgjWAsy+KwuuBvlSlXen60bxIQhnthn3nu8K
	+RVhn3TVtfSITBSRLIrVFOaDWEocRlgWYighxf1wVnDaiuH7XpDL/lncUlH0+5d+f3kWj6P3a4uBn
	cJbq8RrZc2QQe1gD/oAXEvbIhzPVOzM9dGUxSLB8bqRmcUDkPmAOb1ILhgE+Jmm9OH9fyyCZDlE2Q
	Q7JyQ95awR0j34uLa0ImMcJm8cFCHAe7oWu3oNeuN5UTn4GtUSYGCXLOM6Kr7cNMlGF4+6RdiiKOE
	woKVq7cZ3gSE95pxUmLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwBcs-0002ea-DG; Tue, 19 Feb 2019 20:04:22 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwBcl-0002cg-RJ
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 20:04:17 +0000
Received: by mail-pl1-x641.google.com with SMTP id y5so5373865plk.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 12:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eOrFyuS90LqtoruGZQ65onq0a4QdxsrTnhK0HpBAldc=;
 b=ExGmZZHMJkg3u9OTKDoU6CCkSbgS+0X12DwR4A9Kul4Uc9A4dJMK9tC41OY6d5a9Aw
 aglv0JYk/EC04WF1sZDFpRcUzT920K3kqaF3OTvXmaPgQakA8Lxf0n2CHy2zZFUJOH1P
 ZdGLnpsVsX9j9xJVJaiWHxNAL1Da9ACaADQVn+kS5txtuer1F5e5fg0ImOotxr7syKmU
 Zg0PkSB55QlPBaNkBjnM2LtTtjQSOm774p+m3Ru0am6yp72tcDrP8dNiUh8EVoG5Kzj+
 vb9NJKu5Wj3ED3Ylgy3n7yEiUJxkSN5ebyMQ6EgsjdWnVUp3nYXagfA8Mt6ILQEvTpII
 RqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eOrFyuS90LqtoruGZQ65onq0a4QdxsrTnhK0HpBAldc=;
 b=kPFmD/t3ldtW0zSYDJI9JO4uyCgwUyRcEhzt2hzyIt1aUormLWzSlbHzIw6BOFZK7v
 VP4HTl90YQV3pf7p7tcxey05IKDEFuFGcz1i1JADnXWIyMKGIAdCmuuPmC08eyjxraq6
 uOn/7kEv5QrNkNANsL08xA14q9cIowtX/UQwV78l8+SrfURquplOzpFcwCKJniheg4X8
 JMCTUOpk/8DAOjU6UVMzKRbEOoDEGoqp1Hsy+2+2Rr+wU7G919aInkxGFnO7JrMWt4Gk
 Nj2Z38ddNrYKt7Llt2jK7unrsAYmryJcZ2xadSDrYUjcUl+M6Cv5U1OFLw2s7SDvLjBL
 02FA==
X-Gm-Message-State: AHQUAub8UXlGgVuauwK2VDUBCWBG4GGmT8zjU2s/BOb6zstWAFNACRER
 qK02K4kuXUHQPrrhBJWz20Q=
X-Google-Smtp-Source: AHgI3Iaok4AZgi6TJpw48i3eaqZf3u11jkTAsAOrUkZ2mXkf+ku18NlCOMapd64px1h1GQ/s2/axCw==
X-Received: by 2002:a17:902:9a95:: with SMTP id
 w21mr32430815plp.118.1550606654870; 
 Tue, 19 Feb 2019 12:04:14 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id e63sm31519622pfc.47.2019.02.19.12.04.13
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 19 Feb 2019 12:04:14 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 1/5] PCI: dwc: Make use of IS_ALIGNED()
Date: Tue, 19 Feb 2019 12:02:38 -0800
Message-Id: <20190219200242.17243-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190219200242.17243-1-andrew.smirnov@gmail.com>
References: <20190219200242.17243-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_120416_038286_7C06B3D0 
X-CRM114-Status: GOOD (  12.54  )
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

Make the intent a bit more clear as well as get rid of explicit
arithmetic by using IS_ALIGNED() to determine if "addr" is aligned to
"size". No functional change intended.

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
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
