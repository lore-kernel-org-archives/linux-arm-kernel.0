Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E31C282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:51:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A02962080A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uQT19Gau";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1JnCf7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A02962080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZNezOQNjtBBYDZ0ATeflAswmp3JoVNmDZqUVwMBsqaU=; b=uQT19GauriB48U
	mYlB9JHE9qq1EVGN80Rz1si3BKjwM0jZR2oUT7puhS33dsNVebXedUkhksK8nUowrxJj6Yk300Pj0
	4rbKu6pvJ5HFTQgk6NQs9Vm6F6CKM7aMtHKm04HTvG6t6pCSeHZdPONTs+E/D7YZCNB6qehnBk14g
	NAhtR9B5lbWdZ52kK58+pxg2OgH+PuaKzv6vbTtLgQRwe9JTPczTF3b2fY+uDx8QtVLrw3a2dF4uT
	LdLBhnfZ9pHCA1m6aAWZL9juiipdrS6NtIup8bisz5t8fBH7Ux+Bm/X7tmzt6AWRtvHCDW1IjXUon
	RcobMSC6jvWDsnI/4+bQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtNEU-0000oC-T7; Tue, 12 Feb 2019 01:51:34 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtNEK-0000fi-NX
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 01:51:26 +0000
Received: by mail-pg1-x541.google.com with SMTP id r11so451803pgp.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 17:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XhYeWLJELbBbIY+70J27USkrt28o/PdkHlXxy2828Aw=;
 b=e1JnCf7wRHTPnhwqCvYmVDpF+ygXKWJ2X9sU1PuTUICG57IYl/wersw6LE1ZZfRoSP
 z0vNsZmaF0uvzQlUM2wVJrDWPDDYEAiw1hsgZqeA2Jz48FjbGU06Mf5XA3BLgaJYfwyU
 O4qKgpjJY21YjRjaIDHYPgE5rnbltPt3d1eUj8DFG22XmG1JDUkpfU1+rw3UrZLDyVub
 FFc5dKMDXIYwWazjMLiipCd4n/ZqGlUGo1GZAg0F9mdlhAdkVPL0iHa5AJ8FENM70Yuq
 Cg7yl6zbTGWWU7EFD9lvhVC2wAfMAfG5rp62ik/Q9AIkqWMG3jdp4mDthl589sdp9N8O
 a37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XhYeWLJELbBbIY+70J27USkrt28o/PdkHlXxy2828Aw=;
 b=f0KxL9e9cdtBlQ0aKSMdr0ketep/zfFVYvWVUqjW7ncLY5ZQutInXscTy7vszzIBVE
 iJUtAOhpIXZalgXd3tFvPLqKnDCjU9zU9E8xNE/2El0+AVJgcy8PG/Zu9PakQ8lcamGD
 ZnSAQXutcV5x5ma2PwCmLUivtKxrgt7rJgXrtaXZker/UIOpWZSbCIzJQ98DdzpDEBga
 LW9zi1NRAjXeQ9G07KRIF6TUYrN8WxjDAGJ/pkhxwnkcj8u0Nzeo0myvWtT+Izf4zZhW
 gcDREqAN0Y1xbMeCzrQnoi1DlrP9o7GWgfHho8eKpGqxgssu00ukA1XtGN1+iJvlltBn
 JDJA==
X-Gm-Message-State: AHQUAuYmdEmhJ1p5mq5vOyLawJmdqk8xlppXBvB/OhE8/9gJs/6s0/LB
 BG+aqJDfnBEza2F5TRRZlFY=
X-Google-Smtp-Source: AHgI3IbTde5HeivFm3ljicLP4d2ZWPVCAiISH6/qQT+zjCtH9wnU2D75DjAI9R26IehpTVqfat5T6Q==
X-Received: by 2002:a63:2bc4:: with SMTP id r187mr1282560pgr.306.1549936284040; 
 Mon, 11 Feb 2019 17:51:24 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id h64sm17146941pfc.142.2019.02.11.17.51.22
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 11 Feb 2019 17:51:23 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 1/2] dt-bindings: imx6q-pcie: Add "pcie_aux" clock for imx8mq
Date: Mon, 11 Feb 2019 17:51:07 -0800
Message-Id: <20190212015108.16952-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212015108.16952-1-andrew.smirnov@gmail.com>
References: <20190212015108.16952-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_175124_763499_37170802 
X-CRM114-Status: GOOD (  10.20  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Rob Herring <robh@kernel.org>,
 Richard Zhu <hongxing.zhu@nxp.com>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, Andrey Smirnov <andrew.smirnov@gmail.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fabio Estevam <fabio.estevam@nxp.com>, linux-imx@nxp.com,
 Bjorn Helgaas <bhelgaas@google.com>, Leonard Crestez <leonard.crestez@nxp.com>,
 Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add a binding for an extra clock required on i.MX8MQ.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
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
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index 920ca93870a8..933d98328e07 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -55,6 +55,10 @@ Additional required properties for imx7d-pcie and imx8mq-pcie:
 	       - "apps"
 	       - "turnoff"
 
+Additional required properties for imx8mq-pcie:
+- clock-names: Must include the following additional entries:
+	- "pcie_aux"
+
 Example:
 
 	pcie@01000000 {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
