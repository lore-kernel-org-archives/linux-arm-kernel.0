Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BAFC282CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:35:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 673472148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pxWfCffx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qJ03L7XD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 673472148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=idt2Iu9oDRxeTMCPSldIcZgoYJCQPnxOuGSYt52UirU=; b=pxWfCffxDbmH0f
	d+lAfJoTWaEOqx8k2NlMd4dMbllYlcCO9mmvxhyqn0vf0mY1GaQ4kkpnKevJbVCMn4AMRAssMVut4
	7jrONwR4aojgZqNmSeIzv0T/Imtyc3h368ww3Uwq/5xipNWyFWi494odQo9c8acWWNA5oofymLhhq
	v9f0QpwTgHUEEWkh+WtFqXFVOmLrB8GeYnnabvNThHUMh44oRFtqWBs4mFv6EkZqurzMmsd5S1Er4
	6itwc5q2PMwe0K6CKUsSpdI+2i3Nn7pYJYRjg50YmXXqE9+MmvucY6C11gZlELrWtSLUjHbli+7P2
	WCaQW0jB6pL+HF6JuVeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goFVB-0002oB-Vw; Mon, 28 Jan 2019 22:35:38 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goFV6-0002n3-M7; Mon, 28 Jan 2019 22:35:34 +0000
Received: by mail-wr1-x443.google.com with SMTP id v13so19909508wrw.5;
 Mon, 28 Jan 2019 14:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7TrALtjK5VfQJXLM+noL+eRhCYVQ0l+5KwWNGeNwvD0=;
 b=qJ03L7XDrgyYkc/aj/jLu6NnmCt24qMLraxKCmOxeOXp8wWa8hd6L+NBITwoJ0donr
 1MVD9IBdF5WSJBexWFNsq2R/4cE19IgKqZAiG1L3kkz1rTu6H2heLO5JQPW0RvT+ibny
 5fzwnHqZ77BS14GF9HZr0BSw0fD+2hUfKD+geBukCPHEhwH9msyec0wzc4HWndlSMs8Q
 D94YYuWo5CJBBrFMjl3lQpel59ZaJ8Y8nlZzDzhRVNJVjW/ocFvX37wF7QnsxAdbHJ/C
 07ZntzQseC3r7TI6o50rL4vmI1nAgsx5j0Dj690FVSCl5dEjfBaZHTN1tLlDCN83oxQW
 9zmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7TrALtjK5VfQJXLM+noL+eRhCYVQ0l+5KwWNGeNwvD0=;
 b=J/td/CJmMuknQ9RF67q66maXlRo9rlhKRr4pICDKtq/4a2IBO2/iZQnQsZfgBaqm6T
 C5g+UtM6VbtEbX4i01FszGnNzkSz3vCD5k5ze/DIKXjoqOkid2NseHdf4Uz5Dx2KUYmu
 Vlr4PwLqbD2FMHyLuDKejgrkwAzeSbh6VclPWl/kO2hEJ0wNjdTLZQk18R1JIZRD4eV2
 gVkF/DaicGodWVK+3RsQMfBHnJgjiAB/xZnst4OLd9EQKWTdCBdJ8Aj5xB307rC5dtZG
 //Fo49nEHQW0iqFf/cZMsELJwRoL4OYAAwB6c03taldPBeBMFTHEU+NImdLkF0oSjs0O
 NFYA==
X-Gm-Message-State: AJcUukfuDQ1EsCkOAi76jAWxzFcIfw/pdo83iodjSGstF70n7yAMyiWw
 P7a+sf1JVGD+tfK6CsYjL6k=
X-Google-Smtp-Source: ALg8bN5dCnJy0Q8vUXfM/10/WRekOKJiKac+KCGvETwHMy/BivdcImQRkNBrEbpZ+f/1njCHF7/Okw==
X-Received: by 2002:adf:f605:: with SMTP id t5mr21831988wrp.229.1548714929708; 
 Mon, 28 Jan 2019 14:35:29 -0800 (PST)
Received: from voyt-hp.fritz.box ([2001:16b8:a0d8:9300:66d8:3ba:de17:f9bf])
 by smtp.gmail.com with ESMTPSA id p5sm414641wmh.16.2019.01.28.14.35.28
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 28 Jan 2019 14:35:29 -0800 (PST)
From: Dmitry Voytik <voytikd@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>, Sean Wang <sean.wang@kernel.org>
Subject: [PATCH] pinctrl: mediatek: fix dependencies for PINCTRL_MT76XX
Date: Mon, 28 Jan 2019 23:35:21 +0100
Message-Id: <20190128223521.2690-1-voytikd@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_143532_774808_4A65AD45 
X-CRM114-Status: UNSURE (   8.11  )
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
Cc: Ryder Lee <ryder.lee@mediatek.com>, linux-kernel@vger.kernel.org,
 Dmitry Voytik <voytikd@gmail.com>, linux-gpio@vger.kernel.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

How to reproduce the problem:
$ make tinyconfig
$ make menuconfig
then enable:
 CONFIG_COMPILE_TEST=y
 CONFIG_PINCTRL=y
and any of these:
 CONFIG_PINCTRL_MT7622=y
 CONFIG_PINCTRL_MT7629=y
 CONFIG_PINCTRL_MT7623=y

This combination causes build failure.

Fix the problem by making PINCTRL_MT76XX to depend on CONFIG_OF=y.

Signed-off-by: Dmitry Voytik <voytikd@gmail.com>
---
 drivers/pinctrl/mediatek/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index 1817786ab6aa..a005cbccb4f7 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -45,12 +45,14 @@ config PINCTRL_MT2701
 config PINCTRL_MT7623
 	bool "Mediatek MT7623 pin control with generic binding"
 	depends on MACH_MT7623 || COMPILE_TEST
+	depends on OF
 	default MACH_MT7623
 	select PINCTRL_MTK_MOORE
 
 config PINCTRL_MT7629
 	bool "Mediatek MT7629 pin control"
 	depends on MACH_MT7629 || COMPILE_TEST
+	depends on OF
 	default MACH_MT7629
 	select PINCTRL_MTK_MOORE
 
@@ -92,6 +94,7 @@ config PINCTRL_MT6797
 
 config PINCTRL_MT7622
 	bool "MediaTek MT7622 pin control"
+	depends on OF
 	depends on ARM64 || COMPILE_TEST
 	default ARM64 && ARCH_MEDIATEK
 	select PINCTRL_MTK_MOORE
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
