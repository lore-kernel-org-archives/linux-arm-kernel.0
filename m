Return-Path: <SRS0=YQjL=OY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01195C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 03:02:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05DE92086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 03:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O9Tq1jZ7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N5girEMf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05DE92086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=jL8nSvxy1rzHS+o3QmGU51C2rgWTazPJyEusH4+d1Ow=; b=O9Tq1jZ71bD5Pa+NNa+kNrxTcE
	bMkx/49hBoZpY2adOQHOuDDxyugXu8c/uNxzRmcQ76QIXjWSKfXV0hBhzsgEdvxWGaUHWKHEPkxcZ
	kbxSfxWa1BEKSCW6zK7LZM18W719Bb8NaVSaTOWB5qXg7xHD4vB3zhWnVBMabistAzu3IF1kqvlx8
	dtjNvPc8Xn80pUQqtwJNrCRFdSFPLavBgyGamcJQuMcEvkLoXldWA8+EyfZ2+2aaJJ1G6KHNdgUGd
	LyR5LBgVk2RMgmzlzCkBFreSWc/LRh6vgcf8/knbsEF4ADvx9G2deUU+81Gx0Kf4zcvsZUwfGWeIm
	qcoZg4mQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gY0E2-0002Dh-HH; Sat, 15 Dec 2018 03:02:46 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gY0Dp-0001yJ-El
 for linux-arm-kernel@lists.infradead.org; Sat, 15 Dec 2018 03:02:36 +0000
Received: by mail-pg1-x541.google.com with SMTP id d72so3514987pga.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 19:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=IA4f8trOcC05mppHip2IfoM8w5YdU8xupgECA60alGo=;
 b=N5girEMfNekJHYTVKfmiRezC2W4eSPNeKQlw00k7eI97yCnAcMD49sZTFDWfg3NRD6
 0BRcUD59sRfQGsixEFRnLNzYJpKBN+21eTcsk/EMHY2wRxlvW1Zcl6E2UXFAIl7uvdEr
 DNxWIQUORP815yIKfIm9J6NSw98Rlwhi+2XPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=IA4f8trOcC05mppHip2IfoM8w5YdU8xupgECA60alGo=;
 b=jz4QbaDBcY16XtA1TetFXdnB7FsbWeQjMqP8VbF3rj/6jlbe2eYpfeOXRvWHTccs2f
 JhzOUZoTvqiwGRZMwta1yMw5rN0e/9FoymvAM/3iGtfXhcz3Eo8Fz8uB9eCCcw4dQEra
 7BLlaYx1jgApTLQi8jDVEcq9Ft++wYq/bdP03kMcxapSPtyT125F+WM1DbDaOTFOVusk
 1ao3dqFP3UnDD62ttRMlZVSt3GhKLmDxmLmszV3pNOiHJ+50QlRx9QIvDfEJll7xA2qz
 1BnsNT9M9BvORaUcdkUPtFg0KdpfjnI1t2Zdtngn44v+WYpIm9wgziRX1wqi0WHIrUl8
 BamQ==
X-Gm-Message-State: AA+aEWYoMEweDl2WqV311woXuN01HlYJsDpfe9PcvoS8x0rtXuL25WXM
 nw4ExxNvwoUrvqHPh83VrQqn
X-Google-Smtp-Source: AFSGD/UFtsfZW6LjpCWIDfSSRzZt0VO4Qz1tjAEFi1wFtIV0tnGhOk7O0/atqGDgrUKyuoXiWQh8DQ==
X-Received: by 2002:a62:1043:: with SMTP id y64mr5260161pfi.78.1544842942629; 
 Fri, 14 Dec 2018 19:02:22 -0800 (PST)
Received: from localhost.localdomain
 ([2409:4072:6301:5419:f1e8:77a0:59f7:2cb5])
 by smtp.gmail.com with ESMTPSA id h15sm7309534pgl.43.2018.12.14.19.02.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Dec 2018 19:02:21 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: dinguyen@kernel.org,
	robh+dt@kernel.org
Subject: [PATCH 1/2] dt-bindings: vendor-prefixes: Add Novtech Vendor Prefix
Date: Sat, 15 Dec 2018 08:31:51 +0530
Message-Id: <20181215030152.4386-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181215030152.4386-1-manivannan.sadhasivam@linaro.org>
References: <20181215030152.4386-1-manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_190233_721169_141419B8 
X-CRM114-Status: GOOD (  11.23  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, nazik@novtech.com, yossi@novtech.com,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add vendor prefix for NovTech, Inc.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 4b1a2a8fcc16..ac182966249c 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -270,6 +270,7 @@ nintendo	Nintendo
 nlt	NLT Technologies, Ltd.
 nokia	Nokia
 nordic	Nordic Semiconductor
+novtech NovTech, Inc.
 nutsboard	NutsBoard
 nuvoton	Nuvoton Technology Corporation
 nvd	New Vision Display
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
