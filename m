Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21715C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:29:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3AE221903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DroVr5qg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4zvbexJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3AE221903
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=l7CdwRrgMX//CxKqBOU2z3XvUEyCGOdHI88KysFqUTM=; b=DroVr5qghZpl+e
	sedNYVxVx3V1e2qAD4ovq6Hqz3yjbgQSHwjzhzvtArOOLCldF1K2RZo2jkGU5q4PBS/OhBXOkyAX9
	O2m0ahIwHWAkRTdyinthTWTzOWFqtueJiffDlO2Fy+Rilqsfd6vRixeSZW+tJ/I+GfMCof6/9OSIJ
	GwF7sdYGi50RdN+6X1KFoAoU/kKjTuW93/ZUB2khXxbS+0iil+oC16Tec6ds6bVWXP6BMOIlMrA4z
	f5kBlf9vPEgYwGEW+P8I/l0aAqlk6yfDAq7JwCzLyOqkeLmuqzPqKP3ufqJBaQz+QSEJaLkpxy/iN
	PwYcW17F+awVa+JGpwSw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaFFE-00033V-1R; Fri, 21 Dec 2018 07:29:16 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaFE2-0001fT-6r
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 07:28:06 +0000
Received: by mail-pg1-x544.google.com with SMTP id n2so2116564pgm.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 23:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=d+ZYsrQDzgljKv7Hwi24dI5tor2oRWLv2kgiIeP0lnI=;
 b=Z4zvbexJFGJpGh32+7HGRQJGf6LTreqO/NmuvyBGVazPAY0h38tNQYijQDnyfi3QPw
 Zkvn54K8ava4sziwAA6w/Q9AIBKSE6lM0Bvt2NPsHGg9fRaMQZiJToJMqMBbbbfUgPwc
 99RndgkRnhG1ZyrXbhPws6Hag+v8/OXuDqa9EOPRpggP1oCMMTyzWzxkfd3agbv9dy+5
 TqMgrK6Ur0Xw3/mt6+GI7+RAa025bD/gDyK6eM7DBbx6BKGs5/XYjxEQVIabiwDDG5sT
 SyPVnhijHovEidUWEGCZH5O644uq161RRE5MNd2vCNtxe6JZ+wY+L1TtCLruPMqh001H
 ntlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=d+ZYsrQDzgljKv7Hwi24dI5tor2oRWLv2kgiIeP0lnI=;
 b=p/5IoOPyU/BJfqeDrrBhLUTclMLZmEd7Atjv7lZO4btQ0zwi4RnEO4WRI3oa6/ms/0
 HIo8/8l+fG0Y5fh1MF//UMLcyKBM7eA+RpYssLyleXXzrUinhUTk8nGq/0DYO18B9nYT
 fOW9TPArropi8cQqQ92f3I8r0xpV+MBcpk1PE+NaOvZ5eEmCjs4j1SoPVryMtPg7fbUq
 Lg6roZmCHPTovsShlLvhQwGRAK9UrxLJOGt4OZnMt0oH6pwdZmycjE5diicACt6UQWWK
 2i/ZpASBTB2C/9U0VnBxHi4/fltfqYRrEFjz+muhaRqxrtYavGXab5jt2sXstaQzCXug
 EpSQ==
X-Gm-Message-State: AJcUukf9RkdminUqGIXW63I74SOaeacp8GHeBEwIKLDuXYMxSdveOhrG
 8DL2Je3XZOwY1j9SJbClNkA=
X-Google-Smtp-Source: AFSGD/WzK6aotUaeFQYslS1ZuCcb0xGrM4bYW4RJdzTkpTf9ea02REhEidYhtufShyRIHnc/I9ASqQ==
X-Received: by 2002:a62:4c:: with SMTP id 73mr1424657pfa.24.1545377271247;
 Thu, 20 Dec 2018 23:27:51 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id t90sm44971921pfj.23.2018.12.20.23.27.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Dec 2018 23:27:50 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH 06/21] PCI: imx6: Remove PCIE_PHY_RX_ASIC_OUT* constants
Date: Thu, 20 Dec 2018 23:27:01 -0800
Message-Id: <20181221072716.29017-7-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072716.29017-1-andrew.smirnov@gmail.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_232802_837379_2DF27429 
X-CRM114-Status: GOOD (  10.01  )
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

Code using these constants was removed in commit a77c5422d758 ("PCI:
imx6: Remove broken Gen2 workaround"). No functional change intended.

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
index 60803f1f16f8..937d630f8c9d 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -108,9 +108,6 @@ struct imx6_pcie {
 #define  PCIE_PHY_MPLL_MULTIPLIER_MASK		0x7f
 #define  PCIE_PHY_MPLL_MULTIPLIER_OVRD		(0x1 << 9)
 
-#define PCIE_PHY_RX_ASIC_OUT 0x100D
-#define PCIE_PHY_RX_ASIC_OUT_VALID	(1 << 0)
-
 #define PHY_RX_OVRD_IN_LO 0x1005
 #define PHY_RX_OVRD_IN_LO_RX_DATA_EN (1 << 5)
 #define PHY_RX_OVRD_IN_LO_RX_PLL_EN (1 << 3)
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
