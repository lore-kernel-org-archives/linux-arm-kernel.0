Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DCFC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:08:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F5E120811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hyqdkY/q";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KdtqZvMB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5E120811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=F0sLGbexEoBCW/aHMa8zUFyZ9w9nOCuTySYMcq6BLS8=; b=hyqdkY/qTdrfUo
	oG596t/abb2VSJug7HVdMHzNLVY/ZB2cy9vhj/3J0c+HHT0YgBSnfdU7Dj71yoSV6+L3V56K50jYm
	YrgO3XWwrHFCEpyMp/5Tb74E4UqvxaqdCEmUocRe3dyVqEicn866AsT26Y7tCmlvGumXl5sk97GwW
	yvUrLaGiES4jkrjT5tT0RAyV3cg7U+Qvqta+xQJ3kBeOKUFuOdN2KD0fgKjxrLwRcMqqpWyhuuv5z
	BEXl3AJg8efzPOg0oGon74w947m6/GNqFlx8q0rKO4Q/jpuWc4ZzUbxcgct2A0Qq/MXbg99vAKpsz
	j6aL8HjHUBfUnE9YgidQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWd5Z-0004h6-CF; Tue, 11 Dec 2018 08:08:21 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWd5W-0004ge-AB
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 08:08:19 +0000
Received: by mail-lf1-x143.google.com with SMTP id i26so10089763lfc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 00:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BKKIzmCvPC7OdyCPGn9DmBs05yvqPdXPFG7FUkPkzig=;
 b=KdtqZvMB1til3JVn/xTnS8jE8gRXUe28oDoeVLOQjBjwpuy/ZoGCijv/I5xL6ceyaP
 EwrP7n5Ov79kJOx4TsW0BthCJ7Sn2jF+EQLnsQx1XssVzmopiXR2bocSVXkrSJLpAtoR
 3if67DI9PjrGdyg7R0oOknSKFlb8AjGkTCWU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BKKIzmCvPC7OdyCPGn9DmBs05yvqPdXPFG7FUkPkzig=;
 b=BJZ/+in7q2O2p9tX/6voh4AsvirUpz2BH9chxJodoBcDfHLVvfaU4lZNWPx3r9K5BP
 AnOmF7gT/2wf/etjrpPAGaDQhdOF9MD74vg4XmgBB5G1BLkTjvJEtXMjNjVzOMQS5Dvy
 bhU98UMnviGVWKskXmA59aySpePlY19tewunCUX2W3/yiVCgnu7pDo/pkyC5gTwZ/xo8
 vxkPyLGJSGZcz+TSYhsuZBxoatXc9Vsz5E5N/hkuoqluwTUSsIR+rOdnwo21OmP42Fgn
 yymfo5NF+RdRWmVdasYEaoTfMpMnoiZGAhn2Q0oPxEWH0gWlVe5Fy8nZ02i1dV2JZeVy
 M6CA==
X-Gm-Message-State: AA+aEWbpeQgMjm9b8k4EIQhAVvGpK1I+V9PwqbY44GZlZCRySrFGAPkw
 qQLGd9rzSTO5Ht0vNXmJIL7PKA==
X-Google-Smtp-Source: AFSGD/UeA9ldInU3dW/PMGBBgj+VFqKis7OxSUeLphq3ljp1dS6gtFSMzL7RuJ1Sh03Un52pAI3kMg==
X-Received: by 2002:a19:c7c2:: with SMTP id x185mr9061641lff.123.1544515685995; 
 Tue, 11 Dec 2018 00:08:05 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
 by smtp.gmail.com with ESMTPSA id l21-v6sm2524424lji.6.2018.12.11.00.08.04
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 11 Dec 2018 00:08:04 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/5] ARM: actions: Put OF nodes after use
Date: Tue, 11 Dec 2018 09:07:55 +0100
Message-Id: <20181211080759.3150-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_000818_354879_BE422413 
X-CRM114-Status: UNSURE (   9.36  )
X-CRM114-Notice: Please train this message.
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
Cc: Linus Walleij <linus.walleij@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

After using of_find_compatible_node() we need to issue
of_node_put() on the node to keep refcount.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-actions/platsmp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-actions/platsmp.c b/arch/arm/mach-actions/platsmp.c
index 3efaa10efc43..02d17ed0ca31 100644
--- a/arch/arm/mach-actions/platsmp.c
+++ b/arch/arm/mach-actions/platsmp.c
@@ -122,6 +122,7 @@ static void __init s500_smp_prepare_cpus(unsigned int max_cpus)
 	}
 
 	timer_base_addr = of_iomap(node, 0);
+	of_node_put(node);
 	if (!timer_base_addr) {
 		pr_err("%s: could not map timer registers\n", __func__);
 		return;
@@ -134,6 +135,8 @@ static void __init s500_smp_prepare_cpus(unsigned int max_cpus)
 	}
 
 	sps_base_addr = of_iomap(node, 0);
+	of_node_put(node);
+
 	if (!sps_base_addr) {
 		pr_err("%s: could not map sps registers\n", __func__);
 		return;
@@ -147,6 +150,7 @@ static void __init s500_smp_prepare_cpus(unsigned int max_cpus)
 		}
 
 		scu_base_addr = of_iomap(node, 0);
+		of_node_put(node);
 		if (!scu_base_addr) {
 			pr_err("%s: could not map scu registers\n", __func__);
 			return;
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
