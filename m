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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5185FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:51:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D06521872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YuqU8Aj5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZRJ3v8f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D06521872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6awoPxhoSoAPCMnXGWhS5jZhhihZivHl26/w7trteOo=; b=YuqU8Aj5YrrhD1
	8u4RRpS1PN0ei99d81KGgThk9aXC6GNIpTZmCkMIZSMXP5O6Rrw6X7qLPU+fZcWWyH0PcioM8I+pM
	swPbM9wZ9tpohHFncvk16OnojTtg2gzl/UNguv29KUTu3Ci7/FduD9pV9CeKNSWzruCMnUuUiVP9f
	J6QBLOS8omL8OH2840vIi+GFhLyTggvqNVKwo8unY7kYwR0EyIrUG3nLVr4V9pwb36z/cgXJcFtK3
	+BwcxoDy3GH2tIVbHB7CJJHCNVlUs3hIabkVLHjFzncU2hCris17WjbgjXlfLOTjHqI+hEKG+WSjl
	T1sMAXgWCCnxmG2/0BEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfTca-0006a1-2g; Fri, 04 Jan 2019 17:51:00 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfTbR-0004Ac-Pg
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 17:49:56 +0000
Received: by mail-pg1-x544.google.com with SMTP id y4so17766696pgc.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 09:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BTd99CHE5iLaVoOAVJd8WfMcBFC6tGpgGczKpbbc3Sc=;
 b=KZRJ3v8fnd9guo51anuzyHME3XTBHLulXCoUd46xXupoa9GJBDDSahPQaeaI6PLGVr
 8WGYsbFLDSaqyj4vvuSYG5SYiOJLBRczG4BTCT412zHy0aHlx67BJF/5bkIB3ajth8M3
 j0DOWvO/vyFVPj9cdvQt3pkHf/p2UMnt6OUkI2HKxtpV20UXZk5glYy6iKg5mDpqKjxi
 hcAFFzi7QNbmQbGsn3A0vnbCTD4Xz1FWDYBl9/cDKuzVr5ZdDGbup+l0Yu9qrXJK/XMo
 W0iKa/8vKbVIyT/WW+X1irJAlhyfyKoLZGtxCaBxnthGEZW6chT2vwCL5iJJ7SR4zOqo
 /rqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BTd99CHE5iLaVoOAVJd8WfMcBFC6tGpgGczKpbbc3Sc=;
 b=lfU7cH03Io0UHj/zadvnE58F4m1K1ezKesZDFcMus5KeAMmSdrBSL4KV2F6FPTzg4V
 lM0bZDn2qLVvDzDGIEm2Y2Yu0L2HXO8tK4aAOjgn2pj4uR1+do6TBYQpSWcML5LrJI/O
 rQEuV6cX/Df4ZkqiamJOHlT6xNScBlKruAvQMyZK2MtvQpl6erfBFduZt3RM1MCyJZuJ
 U52cQsS4ZDn99JyL05NnvF+qnJ3n15/9IMGEnu0jl4l+sYPpzfl30EiJDkNzmBr7bWt9
 x+02JHxnis+CzDvoTfi3RI7h8KVKjapnwvM/+HtOk/qg+7747IudXu4pYJCbz378Hfdx
 rk5g==
X-Gm-Message-State: AA+aEWaeYp4v68SfXShdySNLK04rGPGWN9w/9miQoq6f49gUNsVT6A5U
 tkrgmueDlLOYLvOjbvhLh8g=
X-Google-Smtp-Source: ALg8bN4Qb8qQMO7TZhcNjLcZcF+mDwHVBnDykUSYqKB+NrSY3NbwaLE59uALn6HrKRe517RVcaaUeQ==
X-Received: by 2002:a62:520b:: with SMTP id g11mr53858019pfb.53.1546624189099; 
 Fri, 04 Jan 2019 09:49:49 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id i193sm100699632pgc.22.2019.01.04.09.49.47
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 09:49:48 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH v2 05/20] PCI: imx6: Remove PCIE_PL_PFLR_* constants
Date: Fri,  4 Jan 2019 09:49:10 -0800
Message-Id: <20190104174925.17153-6-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104174925.17153-1-andrew.smirnov@gmail.com>
References: <20190104174925.17153-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_094950_783357_1A51D22B 
X-CRM114-Status: GOOD (  10.00  )
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

Code using these constants was removed in commit a71280722eeb ("PCI:
imx6: Remove LTSSM disable workaround"). No functional change
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
 drivers/pci/controller/dwc/pci-imx6.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 5090a618c3e2..a7192b9e0e71 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -99,9 +99,6 @@ struct imx6_pcie {
 
 /* PCIe Port Logic registers (memory-mapped) */
 #define PL_OFFSET 0x700
-#define PCIE_PL_PFLR (PL_OFFSET + 0x08)
-#define PCIE_PL_PFLR_LINK_STATE_MASK		(0x3f << 16)
-#define PCIE_PL_PFLR_FORCE_LINK			(1 << 15)
 #define PCIE_PHY_DEBUG_R0 (PL_OFFSET + 0x28)
 #define PCIE_PHY_DEBUG_R1 (PL_OFFSET + 0x2c)
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
