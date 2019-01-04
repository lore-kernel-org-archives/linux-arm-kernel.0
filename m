Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CBBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:52:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E174021872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TBATgsyi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbIy6QxQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E174021872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L0yzBWFZ3XBgbvN/rMWCJvU+5OEkrUSYPRmkMAn4050=; b=TBATgsyibXbVy3
	dK8ZvRlyYN9JW20Gn9HQHzf3PLSp6iC0QNM9wM2Wziu/yiS9737OyffL/xr/ijAiblmkfZrDfnVLu
	k4znvioGZ3xtxBmF+ecCsC2pnzTmE/tEfuB1Ehb3IY2tfF7ZVTaJQ2QTITi79Tr8QZGrx5k7BhmR9
	o4sAfTx7ZRvHtpofkelNYgh4to6QNxonglLa78VLIBorZAEVXNqGXeaMzknDMRBGqag851urQB1BS
	Xi9SMIxNHWbZRvF2aNNTKYwoiMUnwI/TK+mdBWcDETbqeQKjDIBrPFOWcAzJ9RbcfjMSvqxBIlgtA
	UE+17pYIBQR7vv0uRYHQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfTeF-0008Oh-SS; Fri, 04 Jan 2019 17:52:43 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfTbi-0004eh-LO
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 17:50:36 +0000
Received: by mail-pf1-x444.google.com with SMTP id h3so18633719pfg.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 09:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GIZtkIt7F6fxURYaK6v1S5ghisv1YvKa7oaIjfa51B4=;
 b=RbIy6QxQ4n6nLxPbvAynBbX8pf4uJ3NYcuGkNvB7KF8kscdYTdyKmRtNArPL2pDcSA
 iTQhHQ0y01l4EQ1Vi1g8EdSB2ORRoI4qVgtOEehGATgzveaMve0i3uvUkyGua+1impAp
 z7wVNs9/xNj8ZRp8BHTrPX8jVaXgc6ilSMzKjB4ME2ibriLmPWbzbnO9Xod9UH7Qp+rm
 jSFg706OlVopTyG8KdrTFVkQ1FHKblrb7x9YtVpMng5TTL5DXnpvRhjoBSk54mgJ9RxT
 gDjcfNdR41pZHNcgY0/EKccsyg0FEXnUE4Fr4FlSaHVfotexHSoyh2V5rLKFH7VaNZCa
 6jcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GIZtkIt7F6fxURYaK6v1S5ghisv1YvKa7oaIjfa51B4=;
 b=sOQQkNyIyoylhLan8SaZRGzKpKOrRqjw6MLdYOch4NfcAWoLwY7mS/+9vmUBEvhBBn
 HZSu/l+awf5PCYt/r/IsFiyk1EsQ+kGaOUpxJeLF+/DBe0Wug7CJ8oIhR2YGG4tjAqdw
 6rG8Dd8SkflR77r4XpxDQqGCNRiPMr85yGQ8WnM6LRFWWB8oFA7eYjx6u1G55wGf6gm+
 WOBmbP6oO1MiztfkQ6jb66hS7moFyoVLVtDvUzU4G3kYEapRVxJHbz7630YM7eeT1qHU
 NyZzYAmZF12YZ6KWifQSgmtlB8MbsUJs4AFYrRYOcOC7LWbGwkS11zxtsrtmsExiY0Gy
 vK8Q==
X-Gm-Message-State: AJcUukdVcytkaMqwqeXOnxFk6LO4f3p4VV8vgDcgKVTHqO60nX7UbGv4
 kXYcJOMH9fghYU2qJaLlyws=
X-Google-Smtp-Source: ALg8bN5jrhYevzmE+NEUJvgXp4+NCs5ehGhkPFepwPChUleu0X3pnfm/f5l65XdV6q4QeM5GgnVf9g==
X-Received: by 2002:a63:3703:: with SMTP id e3mr2397705pga.348.1546624205986; 
 Fri, 04 Jan 2019 09:50:05 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id i193sm100699632pgc.22.2019.01.04.09.50.04
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 09:50:05 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH v2 13/20] PCI: imx6: Simplify pcie_phy_poll_ack()
Date: Fri,  4 Jan 2019 09:49:18 -0800
Message-Id: <20190104174925.17153-14-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104174925.17153-1-andrew.smirnov@gmail.com>
References: <20190104174925.17153-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_095007_814905_FD532DEC 
X-CRM114-Status: GOOD (  13.92  )
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

Simplify pcie_phy_poll_ack() by incorporating shifting into constant
definition and convert the code to use 'bool'. No functional change
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
 drivers/pci/controller/dwc/pci-imx6.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 672332483324..2a7075a9cba6 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -108,7 +108,7 @@ struct imx6_pcie {
 #define PCIE_PHY_CTRL_RD		BIT(19)
 
 #define PCIE_PHY_STAT (PL_OFFSET + 0x110)
-#define PCIE_PHY_STAT_ACK_LOC 16
+#define PCIE_PHY_STAT_ACK		BIT(16)
 
 /* PHY registers (not memory-mapped) */
 #define PCIE_PHY_ATEOVRD			0x10
@@ -125,16 +125,16 @@ struct imx6_pcie {
 #define PHY_RX_OVRD_IN_LO_RX_DATA_EN		BIT(5)
 #define PHY_RX_OVRD_IN_LO_RX_PLL_EN		BIT(3)
 
-static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, int exp_val)
+static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, bool exp_val)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
-	u32 val;
+	bool val;
 	u32 max_iterations = 10;
 	u32 wait_counter = 0;
 
 	do {
-		val = dw_pcie_readl_dbi(pci, PCIE_PHY_STAT);
-		val = (val >> PCIE_PHY_STAT_ACK_LOC) & 0x1;
+		val = dw_pcie_readl_dbi(pci, PCIE_PHY_STAT) &
+			PCIE_PHY_STAT_ACK;
 		wait_counter++;
 
 		if (val == exp_val)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
