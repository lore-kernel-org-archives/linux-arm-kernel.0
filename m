Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FC6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:53:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5994121872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rmKjfYqV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="odqTjkGm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5994121872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=64r+i+n59/ey+vaM+vGKMb6tn1xSx3fvxvrrB4bKjB4=; b=rmKjfYqVmiChwc
	E/OurynZd+P/56H1p/H7biFIycbGlDQm1IuysKaZSkBRWZrFL6wjQQ82zPoKzJY3S1AiLzMLiRB4S
	6EJTXPBIZh0WzuCv07O5uaqOLpr7qN4ah0X5I/5tLayklPInv+plZo/dnHERFLeeq07p4CQDzcvtr
	UZY/pc4MBUnVKOynViXiI1VYW1AFTidnts4fX1X8HPOJ8/wV+wCrnmCNaT7uIczxgeSjcW2b6gfSz
	SqHVNnt8cj9BhSvoCazAXDAJucLMAUSoN7J3X23UcLwplNHDcVKzZjAuGW7EPvRQ6mjaMVnEudE/g
	s8j5Sc9xvms63yLEZc7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfTeu-0000fV-1d; Fri, 04 Jan 2019 17:53:24 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfTbq-0005AA-As
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 17:50:54 +0000
Received: by mail-pl1-x641.google.com with SMTP id gn14so17739537plb.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 09:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=smdD9M2YSE1AOghnOpWt9rwK4kDd0JsF0HnKCn2DuJU=;
 b=odqTjkGm12K4IG7dhiJR/Ldk4BrRbMGJwKZ5NN0FMikHY6exsnheg/PUKCX4tP/ZhO
 3OK8vBUSevmn55+OSq4+JSTdbaCmnMHVuFJXMrecrW1FJlRIGC0s2sxuD7v6ABcIqCz8
 zge2uOu/5aItwK/nFBEluYgZTJkQn+Gry4X2RRxlbLlYE1E1Rx7wMPuhQXu7FnHEpPzR
 6JcFr1VcaJJt5ed6yiqF+isMKu7jGWAiaJ4+RbgVmYOv3Y8IVCsUYOtZIlsWCrRPhx3y
 OANpKALDhlvo9X4nwvaJCniSuD4gR0FQ7yNQSxWh/8mlIFvMewVj3JQ4heyc7upI/oj/
 nlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=smdD9M2YSE1AOghnOpWt9rwK4kDd0JsF0HnKCn2DuJU=;
 b=ujeg9gWN54oXoGJYpbWqqRqaaKKccXAMxG8qXfcOHMZyFFA0skBOG/dxTFO59XJE2H
 yWgV9tnWTXDEmCMj1uvwvdRxvNl8p8yr+pA4kX3lAuD3V5YOfJ76yzrl9BYcBM+ANZL9
 zFnriDe2jnoId3ADND7asf5W/RHaiAthIUxg73Vi33nOLssjk9S7DGoNYp8kcDG85S6w
 FVBf6I74GNfOk1P0CeU0ew3leYjwSXAHPmDooXbHvO1ye2rdckmc4QTsQPm1PbEpbvNq
 kDVFt3v9/aYvMLqCU3qigFNzMI4M8kbODfOJ4hm4XwC1rOevgMSIQPG4FLxBTPilUpYp
 f60w==
X-Gm-Message-State: AJcUuke0ZlFjaFH7F64AJ+/KY66Bu49tjU0I9k45f8DyTdUzFtI4Nkme
 qKq8L9pfNSgCU+D8yyt1sREP5jPGHcI=
X-Google-Smtp-Source: ALg8bN5qQdMltuObfh6awk76R3n49OZJYHiTOTK09WcJejGUwexLIMohtoIHao0UtMQAlWHg3BT+TQ==
X-Received: by 2002:a17:902:8306:: with SMTP id
 bd6mr52122019plb.217.1546624213731; 
 Fri, 04 Jan 2019 09:50:13 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id i193sm100699632pgc.22.2019.01.04.09.50.11
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 09:50:12 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH v2 17/20] PCI: imx6: Simplify bit operations in
 imx6_setup_phy_mpll()
Date: Fri,  4 Jan 2019 09:49:22 -0800
Message-Id: <20190104174925.17153-18-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104174925.17153-1-andrew.smirnov@gmail.com>
References: <20190104174925.17153-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_095014_657560_1EB44A98 
X-CRM114-Status: GOOD (  11.20  )
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

Simplify bit operations in imx6_setup_phy_mpll() by using
GENMASK/FIELD_PREP. No functional change intended.

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
 drivers/pci/controller/dwc/pci-imx6.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 130f577670c8..d8aef9da476f 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -113,12 +113,10 @@ struct imx6_pcie {
 /* PHY registers (not memory-mapped) */
 #define PCIE_PHY_ATEOVRD			0x10
 #define  PCIE_PHY_ATEOVRD_EN			BIT(2)
-#define  PCIE_PHY_ATEOVRD_REF_CLKDIV_SHIFT	0
-#define  PCIE_PHY_ATEOVRD_REF_CLKDIV_MASK	0x1
+#define  PCIE_PHY_ATEOVRD_REF_CLKDIV		BIT(0)
 
 #define PCIE_PHY_MPLL_OVRD_IN_LO		0x11
-#define  PCIE_PHY_MPLL_MULTIPLIER_SHIFT		2
-#define  PCIE_PHY_MPLL_MULTIPLIER_MASK		0x7f
+#define  PCIE_PHY_MPLL_MULTIPLIER		GENMASK(8, 2)
 #define  PCIE_PHY_MPLL_MULTIPLIER_OVRD		BIT(9)
 
 #define PHY_RX_OVRD_IN_LO 0x1005
@@ -641,16 +639,14 @@ static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
 	}
 
 	pcie_phy_read(imx6_pcie, PCIE_PHY_MPLL_OVRD_IN_LO, &val);
-	val &= ~(PCIE_PHY_MPLL_MULTIPLIER_MASK <<
-		 PCIE_PHY_MPLL_MULTIPLIER_SHIFT);
-	val |= mult << PCIE_PHY_MPLL_MULTIPLIER_SHIFT;
+	val &= ~PCIE_PHY_MPLL_MULTIPLIER;
+	val |= FIELD_PREP(PCIE_PHY_MPLL_MULTIPLIER, mult);
 	val |= PCIE_PHY_MPLL_MULTIPLIER_OVRD;
 	pcie_phy_write(imx6_pcie, PCIE_PHY_MPLL_OVRD_IN_LO, val);
 
 	pcie_phy_read(imx6_pcie, PCIE_PHY_ATEOVRD, &val);
-	val &= ~(PCIE_PHY_ATEOVRD_REF_CLKDIV_MASK <<
-		 PCIE_PHY_ATEOVRD_REF_CLKDIV_SHIFT);
-	val |= div << PCIE_PHY_ATEOVRD_REF_CLKDIV_SHIFT;
+	val &= ~PCIE_PHY_ATEOVRD_REF_CLKDIV;
+	val |= FIELD_PREP(PCIE_PHY_ATEOVRD_REF_CLKDIV, div);
 	val |= PCIE_PHY_ATEOVRD_EN;
 	pcie_phy_write(imx6_pcie, PCIE_PHY_ATEOVRD, val);
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
