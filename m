Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104AAC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:46:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA2EB20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c2kuQ/r9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="c3EZTtYw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA2EB20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=XdBFM8KBeDM4+0pO2jOjohulzFq18J0aEYWZ1fvODY4=; b=c2kuQ/r9lxlmiJAXovhPyr24vq
	6AI83djZB6RR1gxktEPeC40CndquRIfo1f1QA7Hn5ve5wRR8jrGQm9L67eLXAaWW2RaCPKeLjITH2
	xjpRjjstI+aPfzMnYJZIeYCGB2oC5DDd5IrWHi84dBVS4Oj9cQEAceJpFuFiYq5U9nRKVgYpoNIsJ
	dA2MchxpoO2+ek7WM1imN+cBQqQ11VEEicyqNzNYo084xg7MXKcd8Vx3oTbHCvawtIXElq94Sx/NA
	7fJg4N19oOkOyZjCzGCh10WUqSam38lD9c/2H3oJ/LpsQlOmCgNNyyGQJtHu7Pafrl4ECLgyDJCQA
	DnnKjoRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWRVg-0007fT-CP; Mon, 10 Dec 2018 19:46:32 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWRVP-0007OL-8r
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 19:46:17 +0000
Received: by mail-wm1-x342.google.com with SMTP id a62so4797865wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 11:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=9sGcynHRDayWT0bdEoEQXYHjCHQPwGXVBs+kG3yXWuo=;
 b=c3EZTtYwtBQxZl3VbklgD5HZtnwUEAu48aEHItHudHijdbLgQU8FI9pEeU/2dIBweD
 IZ3uuuO/9lEGUDf6E2JmOak1Fsx+PUueRb935pwOmUQGioGVivxfrFe+Crm4u2ePGTs0
 y98nlbMKroMUgjufy3gO7pr4Sv9T9vN/Xhp/KvMOb8bJSwMR5bffW3w2Kw1OZKmFcRet
 5Nn1khAX0QNzORkEcBIEqWXlEFgVrAiPK8aH4SfJnNIHKu8ZEsAAewhdfr+zkQ5wknHH
 YV9xA9MavholJKPcMGu5F/y7jsB6Ld1CRaL24Avnd79YijP3YWRKO09gxfeRYo94F2pq
 75mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=9sGcynHRDayWT0bdEoEQXYHjCHQPwGXVBs+kG3yXWuo=;
 b=jfvlv9D78kmUtCGdpP+jy7W7RO9Uq3e0mUhxkH1TfplC+eo77JpCQMYaeYI5/z4tjw
 rxO4XkbDaTjjun9NiEY33m2Icpp7LyaH7ifmOE5poA82+x/reKki9Ic5DvjJZXi7Y0Ed
 scW+wN5M7zp8j312kUEuuZG7OBKB4COj+Xw2age+8x2Oufc8nxRzA2r/IQM6wl7zESI1
 6PCqwypnAOoVLDxAMGSjyryLxF6W+IwP+w8bnRDfHEhCAYL9Uj5+m6RCE/iWoF3xwSw0
 sROf5aXkYnR/XifWOqX3PK3gc9pKAxYsxgIyG2kBZeUQM9BAeKlVoKLchFFJLtt4+iqT
 Qk7g==
X-Gm-Message-State: AA+aEWYP9xfBQZXNjSkMaH7Hdel+dpoFVidmWoNtguWDGu7CjcG7yE5m
 LXhGKga8Q2lgCv09FoMZW9GOMw==
X-Google-Smtp-Source: AFSGD/UE6w6dfOa14BeLOL+C4y6fua+sIoB1LWLFufJpEFjPhTpsYXKmfws3QvIzIT5kYgHHSz3jdQ==
X-Received: by 2002:a1c:e484:: with SMTP id
 b126mr11281831wmh.119.1544471163666; 
 Mon, 10 Dec 2018 11:46:03 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
 by smtp.googlemail.com with ESMTPSA id 202sm18808915wmt.8.2018.12.10.11.46.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 10 Dec 2018 11:46:03 -0800 (PST)
From: Corentin Labbe <clabbe@baylibre.com>
To: khilman@baylibre.com
Subject: [PATCH 2/2] soc: amlogic: meson-clk-measure: Add missing REGMAP_MMIO
 dependency
Date: Mon, 10 Dec 2018 19:45:55 +0000
Message-Id: <1544471155-26661-2-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544471155-26661-1-git-send-email-clabbe@baylibre.com>
References: <1544471155-26661-1-git-send-email-clabbe@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_114615_305554_6E550FF9 
X-CRM114-Status: GOOD (  13.46  )
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
Cc: linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Corentin Labbe <clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patchs adds a missing dependency on REGMAP_MMIO.
This cause the following build failure on SPARC:
drivers/soc/amlogic/meson-clk-measure.o: In function `meson_msr_probe':
meson-clk-measure.c:(.text+0xc4): undefined reference to `__devm_regmap_init_mmio_clk'

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/soc/amlogic/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/amlogic/Kconfig b/drivers/soc/amlogic/Kconfig
index 36633bb..5501ad5 100644
--- a/drivers/soc/amlogic/Kconfig
+++ b/drivers/soc/amlogic/Kconfig
@@ -11,6 +11,7 @@ config MESON_CLK_MEASURE
 	bool "Amlogic Meson SoC Clock Measure driver"
 	depends on ARCH_MESON || COMPILE_TEST
 	default ARCH_MESON
+	select REGMAP_MMIO
 	help
 	  Say yes to support of Measuring a set of internal SoC clocks
 	  from the debugfs interface.
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
