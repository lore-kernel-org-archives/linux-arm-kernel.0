Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEFEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:30:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E88721903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="exrIUR7R";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igx2pbzC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E88721903
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LN2CmLllGcbkvLHCsPbdFbUvIEabr7yZA4MnSgIYnIg=; b=exrIUR7Ra7eAtJ
	hmugaBdaF+VrZuSo+WKQpL1I0apgHtccuEG6q/5gaUhYkWbzvul+QzqM80RUtBl51jyeWJb34Nk+1
	b/qpRmmfKt2kbfRtgurRGJKWMHvDDcdIQsIBN+4aONmJHtHWKKYBrg/C4JAj3m43HnLIgiporAVOq
	Pwp6R9Gm1/iI22iO09DmoJgo/Zop9XCugxf/y/DXknYSoI/aSh5b6hqJCvHSBAAGEpvP0aUXCN+Tr
	ZWpaPquo/OO4F9H08IAkwi4i2ead14X0Mpb9c4GNhjHWkPAbh9IuN11KSWUXh2Q2+c2fOcBjTg3PQ
	iE8Uk5+F2xcu0LiTe5Tg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaFGg-0005kW-Tr; Fri, 21 Dec 2018 07:30:46 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaFE7-0001jf-7d
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 07:28:08 +0000
Received: by mail-pg1-x543.google.com with SMTP id y4so2097241pgc.12
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 23:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=u1hnIy8vmdV/yZX7E7Jm64Qo+GuGNv09m6Pi4D4/jFs=;
 b=igx2pbzCncxfVAQhjH9xaI/FCAIaddYLG9x2Ieuc5tdWQzv3z0MRHJ2KIenPF8WV63
 27/RiEAvf91QtmM/jEQgI9eyV+NhU/PU18Q+py2Gp/j37fvH+i7GGtwxWIlty+PHFvUH
 Va3uTUJCjPQxAdkVT3b86nHZOSfjjGh87OT09JNdzIzMwJ6rphof1OdaYiYbySpiUTpY
 /3tS4m+UEU3uqZpKCzV8LgRTqXfSsJbbfzqS45E8uxSx7JbCCH9NfWFb0bDhoUjtRHPB
 gEQLQacnRuVmTtuv4k4vSBTCWnooTZxxj4CgWe1mV3aYE2toxh040AN136AF8Qv97XbR
 JeeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=u1hnIy8vmdV/yZX7E7Jm64Qo+GuGNv09m6Pi4D4/jFs=;
 b=I0F6pBxOyvKuw+Kyu0GdRq+MmoBc+bUEgcR6yB2p6d41m4ZWWCW3IcNUvpn5i27LmH
 uEyX6kklOJFwVbucTjzeY+3x5MLchYxUHuCtxe5/iaDkMpFsOiPWX+Sjs/1XYZx7Z5rD
 64xc1TCxk42BF4y7UDHPGeBHLp0wzmqFkZkyZc9Kmzsi1vbw82J3YpH5t+iEBTkkUgtt
 n1H0kDg/iJxO1HSXOvD3FKLuxXGDnT7NlbgGEVzi3ShrVNJKGIRT0oWJU4dyUriF0/sD
 tj+5cKgeIDZBQURPxf+Y/MRfeUAvb/oZmUAMS6ZdLgM39hQwOI80EeeopTSnQE0ORatv
 8xQg==
X-Gm-Message-State: AJcUukfIKH+3j6kfwOM+VvLDh/VaJ5nQOJmayfoU/ewBJYNOGTEfeTaa
 3bBZPlK7b1NVhDOd2s54ev00FgQb
X-Google-Smtp-Source: ALg8bN4vox9LZebHZGx5bOBLDLief4pJfhpahT2U2GmwxOnNKMv9alUCzjnwm7VG02285/dOUUeVLQ==
X-Received: by 2002:a65:4381:: with SMTP id m1mr1327155pgp.358.1545377276324; 
 Thu, 20 Dec 2018 23:27:56 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id t90sm44971921pfj.23.2018.12.20.23.27.54
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Dec 2018 23:27:55 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH 09/21] PCI: imx6: Drop imx6_pcie_link_up()
Date: Thu, 20 Dec 2018 23:27:04 -0800
Message-Id: <20181221072716.29017-10-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072716.29017-1-andrew.smirnov@gmail.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_232807_452488_45ACA0D9 
X-CRM114-Status: GOOD (  14.14  )
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

Until commit 4d107d3b5a68 ("PCI: imx6: Move link up check into
imx6_pcie_wait_for_link()") the driver relied on both LINK_UP and
LINK_IN_TRAINING to determine if PCIE link was up.

I can't seem to find out why, but code using LINK_IN_TRAINING seem to
disappear after commit 886bc5ceb5cc ("PCI: designware: Add generic
dw_pcie_wait_for_link()") and from then on only LINK_UP seems to be
tested (dw_pcie_wait_for_link() -> dw_pcie_link_up() ->
imx6_pcie_link_up()).

At the same time the default behavior of dw_pcie_link_up() went from
using just LINK_UP in commit dac29e6c5460 ("PCI: designware: Add
default link up check if sub-driver doesn't override") to using both
LINK_IN_TRAINING and LINK_UP in commit 01c076732e82 ("PCI: designware:
Check LTSSM training bit before deciding link is up").

Given all that it seems that i.MX6 doesn't really need a special
.link_up() callback and imx6_pcie_link_up() can be dropped.

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
 drivers/pci/controller/dwc/pci-imx6.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 937d630f8c9d..74faca11eeae 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -84,8 +84,6 @@ struct imx6_pcie {
 #define PL_OFFSET 0x700
 #define PCIE_PHY_DEBUG_R0 (PL_OFFSET + 0x28)
 #define PCIE_PHY_DEBUG_R1 (PL_OFFSET + 0x2c)
-#define PCIE_PHY_DEBUG_R1_XMLH_LINK_IN_TRAINING	(1 << 29)
-#define PCIE_PHY_DEBUG_R1_XMLH_LINK_UP		(1 << 4)
 
 #define PCIE_PHY_CTRL (PL_OFFSET + 0x114)
 #define PCIE_PHY_CTRL_DATA_LOC 0
@@ -732,12 +730,6 @@ static int imx6_pcie_host_init(struct pcie_port *pp)
 	return 0;
 }
 
-static int imx6_pcie_link_up(struct dw_pcie *pci)
-{
-	return dw_pcie_readl_dbi(pci, PCIE_PHY_DEBUG_R1) &
-			PCIE_PHY_DEBUG_R1_XMLH_LINK_UP;
-}
-
 static const struct dw_pcie_host_ops imx6_pcie_host_ops = {
 	.host_init = imx6_pcie_host_init,
 };
@@ -769,9 +761,7 @@ static int imx6_add_pcie_port(struct imx6_pcie *imx6_pcie,
 	return 0;
 }
 
-static const struct dw_pcie_ops dw_pcie_ops = {
-	.link_up = imx6_pcie_link_up,
-};
+static const struct dw_pcie_ops dw_pcie_ops;
 
 #ifdef CONFIG_PM_SLEEP
 static void imx6_pcie_ltssm_disable(struct device *dev)
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
