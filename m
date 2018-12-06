Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBD5C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:36:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CB2D20878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bbQKFIbv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6NliBIO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB2D20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bp461rKOvLrwFLzDscklOYCeQHrbUGWJH/q8ZUjVBK8=; b=bbQKFIbvg6DjwZ
	H7Zr3ya2LuFx1pHedArYATGMRfZ866djfuHcynHN6fOb9Js0ADMFApP7x0QGiSUXoFCfmMgHaLu12
	q9Nc3Zix0+WxkQqRN3bcyimUobdk/PzLmY5dnTMXUpcjCEPTMaJQ3GdjrVKkRPguN0/NsIkrjfbcP
	esaPFJViwMkgtd1Xhbbu6UKaWW2EhFZ0MNoVYt/ftN4T5AmztbZB5yx2lL9IUdsT1qpMLUN+fSuSg
	EKVgcwh8SrRt+72P+YYXym+gNwIIiYvN3gywOSD2vS7fCC8Pb3jtpSAfxoYZGtYg/piEqaKr1nw3P
	oCgiT+fyB25QsAaWitOw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUoD5-0000yI-9r; Thu, 06 Dec 2018 07:36:35 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUoCe-0000X7-6e
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 07:36:12 +0000
Received: by mail-pg1-x544.google.com with SMTP id t13so10235177pgr.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 23:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Rr95nKWuiBKL9zj7ZRZZsfvYCE/2bA6VDwAU3HZE0ss=;
 b=q6NliBIOs7fYEWBDM0uB2PcJ8j5oxCac/VLQ/MYHoSPFT/e7kWzbM/2tPjh53qLUH4
 uu6j6p2IH71/FLH8irPa1ml0WUWJBr7P9GjeUH3n7GRSi2eT1Y34Au9/4NwBPk6n61V1
 yE6PuXCQxBmj6VUP4qNZkBMEToayNfNadl4Tn7+gPSYMTMZbsngK3lLQH4avJ8fdnna0
 xneZ+xxnvzNCzwSX7ZPZ4jJKag82dA5F/DZIhSI9wxV/RGsG1yKLa2cB9/FZMBt0v5VF
 TYuKh+oMk2KTKYmQLwWZdEHISNiolEeIa5Xs/duzzd7SB8h7m9JaRuJUzWHKvVMUgGUy
 Lagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Rr95nKWuiBKL9zj7ZRZZsfvYCE/2bA6VDwAU3HZE0ss=;
 b=qqH/ML0Dua4IajH5DKlNKd3Xy5/nBwcDZ4vQ+8aJmTSEZ7mckMDezd5Z8xFVqSuedJ
 q5PeoWewaLQAWp4PkUTp4IUr2wgjp7W2Qbyl8zewTrOPs18ulmrmm+fP8h6o+OkCtaeU
 sWcxAeXMca5KWRpWpa+Gv8qQ4EnaYsxa0yarpicKk4o2TFprNETIF5ejiIPdareKfSV0
 1p2IOUIDnLbmLSCQUxuIkv/wQCwk3l+2C6FX4wbYf6tmeaYQua+L598APHf0vKdnPw9N
 CYBUIc0D2+KQs5fisalsXVh4eblFvWOwIOEgAMZthldnnhoQXJ8ocQD7iLGIEIibDsuw
 okIw==
X-Gm-Message-State: AA+aEWbDdWoR171by1tqXF4OQkFHpCSl6w3cV8MTCYTnfiEZEV6y1ft7
 ZMty932n46ZFDdM7cacX4Yg=
X-Google-Smtp-Source: AFSGD/Uj+Z4hxzshIa52t3yofWiY0beMqFci5+lTEddAfHdRvJb/ul6Jt1iEqifzbsgwGNZeHoAwQg==
X-Received: by 2002:a63:588:: with SMTP id 130mr22895466pgf.273.1544081757518; 
 Wed, 05 Dec 2018 23:35:57 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id v15sm33035894pfn.94.2018.12.05.23.35.55
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 05 Dec 2018 23:35:56 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH v2 2/3] PCI: imx: No-op imx6_pcie_reset_phy() on i.MX7D
Date: Wed,  5 Dec 2018 23:35:44 -0800
Message-Id: <20181206073545.10967-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181206073545.10967-1-andrew.smirnov@gmail.com>
References: <20181206073545.10967-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_233608_239321_B509B848 
X-CRM114-Status: GOOD (  12.63  )
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
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-kernel@vger.kernel.org,
 Fabio Estevam <fabio.estevam@nxp.com>, linux-imx@nxp.com, bhelgaas@google.com,
 Leonard Crestez <leonard.crestez@nxp.com>, cphealy@gmail.com,
 l.stach@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

PCIE PHY IP block on i.MX7D differs from the one used on i.MX6 family,
so none of the code in current implementation of imx6_pcie_reset_phy()
is applicable.

Cc: bhelgaas@google.com
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: cphealy@gmail.com
Cc: l.stach@pengutronix.de
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Tested-by: Trent Piepho <tpiepho@impinj.com>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index c140f7987598..3c3002861d25 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -245,6 +245,9 @@ static void imx6_pcie_reset_phy(struct imx6_pcie *imx6_pcie)
 {
 	u32 tmp;
 
+	if (imx6_pcie->variant == IMX7D)
+		return;
+
 	pcie_phy_read(imx6_pcie, PHY_RX_OVRD_IN_LO, &tmp);
 	tmp |= (PHY_RX_OVRD_IN_LO_RX_DATA_EN |
 		PHY_RX_OVRD_IN_LO_RX_PLL_EN);
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
