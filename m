Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D5DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:33:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB38921903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M24D3bI0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLSqRc9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB38921903
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PVj/Zy6jo7vo6vFZ6j6oHNz1vpQ1coAl29wa8i4zyUA=; b=M24D3bI0ca5f1R
	vsi4ytWmwJFKxSjJnQSVXYV5XEI1/I9ySGPN7iPSb7mIZ0oBCSXQHYrIfqw4YNwq9uKZxbfEIeCoC
	o3BK/59ycBIECssiRtUspUrY4z5qSRW5WQ5dzPrl124fCjhcdrUw0kCGz9ozkdtRrpz2soiSVSd6x
	qv4OFsFiCjKY3nuJNF/DkmFZyDjGgDO9zDf3BhwmfaQ6sEsm8NcmVBm1IfPuRCuIE4IsreYZv2uhE
	gf8zWxgvgT2OgpSL2HcI5G7kdf7fUeHSq84pMnl9i4oxASlUDnV67IHJCe/ppjAaxPPnHe5h7JZmo
	VFOtfuL2r9lgaUkBdqJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaFJ5-0007qc-Me; Fri, 21 Dec 2018 07:33:15 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaFET-00026u-7l
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 07:28:40 +0000
Received: by mail-pf1-x441.google.com with SMTP id u6so2172468pfh.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 23:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8dhLzSnPx3HKyxwtCcSuNx1W6yfU30Y/Wfx+1/N/Vew=;
 b=bLSqRc9dwd9ei5Ve+zw/9pLETxqpu8pBnK9BeL8a2X3DonypYSPOmVeYpocbvhAmZi
 OblCtyzJyjuoDulFLvvONYRpinSVdrHXiYRe7vPro4Eq5n7SH0FsQcTZiOh9xsv09uYF
 yroXC7ScFFbGTjW9qaa+z67bAKFqMkdzQZvLO4G9Z2Zw2JfJKj2ypNX5GlKIhEuhKqWw
 JUO1ml2sFBMha9Tp2dl9KpDVUqhf9mTY5MutviY1sIP6RFa3R3fuUL+F8d4h5J6bl6A/
 JFkOcIQwYFNHwR61CL2e4DT/DxT4PmmtA8Hct8PEsbpyqA/QxKlMlYUPa5xeMvs1twYZ
 dGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8dhLzSnPx3HKyxwtCcSuNx1W6yfU30Y/Wfx+1/N/Vew=;
 b=Dh1+kZ187WYfS2bJKfDQScGrqALaYl/juqXVj61aftwU9DmENdeILHI38b91JKC227
 DGCW8zcFEkpazaYocCABFCUeyJSkq4+5+auCMKpeiWEUKdUBFRpGmEAMbv1u2mRPAfrv
 xtvU3e/aKxD76S7/Mp2laVNpJRdMKD8LPrpC68tSE5WuXL4sDOGDcrr1KD3ibH94Vhq7
 T/osC5KFLBE/LSgvZm5HUVFJt12ye6lNJLcpgyJVGamEYg4LphW/ZOJZvIAp43aqIqFb
 +sPeg8dNgo1KJapM7i+8saU90awu53n+SI+bQ3GdfoFbL00N8q6yM9s12qxe00sMujIP
 Lmlw==
X-Gm-Message-State: AA+aEWbRecDJCAjKXYmutFH1ihWZuiZmY9pLVeDB7gubmaKphFrr3zYP
 oeJFuXDo+Bj11n67/n8NEZg=
X-Google-Smtp-Source: ALg8bN7J7z15Vw9jy9SjMTeALt7WAUznlJJWop7q8AhJdKts8Qxw224THgFRSQek6rXMFVsm083Vkg==
X-Received: by 2002:a62:34c6:: with SMTP id b189mr1424691pfa.229.1545377298459; 
 Thu, 20 Dec 2018 23:28:18 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id t90sm44971921pfj.23.2018.12.20.23.28.16
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Dec 2018 23:28:17 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH 21/21] PCI: designware: Remove superfluous shifting in
 definitions
Date: Thu, 20 Dec 2018 23:27:16 -0800
Message-Id: <20181221072716.29017-22-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072716.29017-1-andrew.smirnov@gmail.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_232830_086481_30796F1B 
X-CRM114-Status: GOOD (  10.27  )
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

Surrounding definitions no longer use explicit shift, so "<< 0" here
serve no purpose. Remove them. No functional change intended.

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
 drivers/pci/controller/dwc/pcie-designware.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 0de653284fca..636689fd4ee7 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -63,14 +63,14 @@
 #define PCIE_ATU_VIEWPORT		0x900
 #define PCIE_ATU_REGION_INBOUND		BIT(31)
 #define PCIE_ATU_REGION_OUTBOUND	0
-#define PCIE_ATU_REGION_INDEX2		(0x2 << 0)
-#define PCIE_ATU_REGION_INDEX1		(0x1 << 0)
-#define PCIE_ATU_REGION_INDEX0		(0x0 << 0)
+#define PCIE_ATU_REGION_INDEX2		0x2
+#define PCIE_ATU_REGION_INDEX1		0x1
+#define PCIE_ATU_REGION_INDEX0		0x0
 #define PCIE_ATU_CR1			0x904
-#define PCIE_ATU_TYPE_MEM		(0x0 << 0)
-#define PCIE_ATU_TYPE_IO		(0x2 << 0)
-#define PCIE_ATU_TYPE_CFG0		(0x4 << 0)
-#define PCIE_ATU_TYPE_CFG1		(0x5 << 0)
+#define PCIE_ATU_TYPE_MEM		0x0
+#define PCIE_ATU_TYPE_IO		0x2
+#define PCIE_ATU_TYPE_CFG0		0x4
+#define PCIE_ATU_TYPE_CFG1		0x5
 #define PCIE_ATU_CR2			0x908
 #define PCIE_ATU_ENABLE			BIT(31)
 #define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
