Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA043C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:23:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88B61222ED
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="clscpTSY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sr4lF3z8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88B61222ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=1/DziZi4IvpCJyuV734hsx9kCTbDbtTu1CPO7w1xueQ=; b=clscpTSYnAF7mhBMX2qPAxW6r5
	prUs8mG9y8+vYjQxXZt0HbNCvGHpLAiRGDMjJmPI/v18ojYsa2hZqcCEstvmunGtvaJfx9oKmWxJz
	rxFuokta9pHjegXiX1rPDqRSBoza/QAUt2eAguDH8EUh9RqfTsK/H+PF+XO5KoIqk/mlcQmEIfhT4
	94JlqVJEQ2h4cNNGV/iMCueuz2HxWfbhoBB0ECK7hRYg0bTHR84WmI/eU4rav/eNTTidCiSZoIg+o
	VMjRHyA5Xm1ZhBDS8JO671P1pQ/OiANDRU3ak8ttjf1tIclkZd5Ao/KINhzsz4IwczW6WhZmrJWxd
	QuSA7mhw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvPEC-0002Jq-Ah; Sun, 17 Feb 2019 16:23:40 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvPE2-00027I-9l
 for linux-arm-kernel@lists.infradead.org; Sun, 17 Feb 2019 16:23:32 +0000
Received: by mail-pf1-x442.google.com with SMTP id b7so7286653pfi.8
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 17 Feb 2019 08:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=EPBS2GhpwmpEDgTVr1WkimnFnbT2vpcS3OkFjG9Zg54=;
 b=Sr4lF3z8Eo0Yjl+jXh463UV/0xgjxSvWVaxWccrn8/t2BlKS3+NU3uAPnFngoNNJwo
 elfzOoAfOvf+85iumwEi63sApLylsD/KCPHPtXyY9723O2RQUtfrTCNAxQkxOuHbt6jr
 ldqrpQ01Nz/Xwy/Z01a+zhldxkTT1tEvsxgtPB6KXeD60ppfYv6C5kFhq/BJQ+MOQFNA
 IAeUDtaFwC1yCS/czWFtPK2zEEHjLHssbKowVuJIxylvA1PkllB8zHkDxD7lJqhN5llH
 1a37IlIPcBEkhjoA5x5KwuQmuwYOlGesg9I/UBwYt4Th8l70Ht1RqGoTi4K+7HUCNc3z
 il1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=EPBS2GhpwmpEDgTVr1WkimnFnbT2vpcS3OkFjG9Zg54=;
 b=DpX00kzMlAaeApMLPeEmds0Nx1DE78f5D9PXP7ZxXqiGqvJihmOaxh/r2RnYL5Ymm4
 46lWCpbWJ7U0OH6Ek0oNsJcUwKMuV4iPIbJSCVIKHAdSI83oeDdWj9nTQRuUG2wegZpl
 9AKi7ZsZXcxHsEuDtXJQacOguuuZfLbWhpsSEQAXXl3G6u6hBkIzwXOMA+gbChUzIzc1
 zvwtJ4vrT3VfJdgzJ4IAmIdRyr0P8ToMGmixAwA4z8z5K+eajraISXJTJF4tTxywCmIu
 cA35H55w+MeKwCrYt6tP8L9bz22uggIVQTXW/H7CECQ9UCeDc1qNLsKWrCEhoTDwKTHJ
 LRRg==
X-Gm-Message-State: AHQUAuZw46uU7K/cuHylA5R10hfjZX85fYOTev7NH8DPphuqnidvvpP4
 nFdT7eVqRmPG9QX8nUp1jNU=
X-Google-Smtp-Source: AHgI3IbTN4cYherFmGvph39bWwD1EtdaeRVZCpQV3H51+TIeDB0ZWYBPmaHvkENyPWilGd6s89koYg==
X-Received: by 2002:a62:f51d:: with SMTP id n29mr12736853pfh.21.1550420609462; 
 Sun, 17 Feb 2019 08:23:29 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id l28sm18060247pfi.178.2019.02.17.08.23.28
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 17 Feb 2019 08:23:28 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: srinivas.kandagatla@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
 maxime.ripard@bootlin.com, wens@csie.org
Subject: [PATCH 1/5] nvmem: sunxi-sid: fix wrong description in kernel doc
Date: Sun, 17 Feb 2019 11:23:12 -0500
Message-Id: <20190217162316.14111-2-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190217162316.14111-1-tiny.windzz@gmail.com>
References: <20190217162316.14111-1-tiny.windzz@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_082330_584488_BED53BD8 
X-CRM114-Status: GOOD (  12.83  )
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
Cc: Yangtao Li <tiny.windzz@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

qfprom->sunxi-sid

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
index 99c4ba6a3f61..d37017e343b1 100644
--- a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
+++ b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
@@ -12,7 +12,7 @@ Required properties:
 - reg: Should contain registers location and length
 
 = Data cells =
-Are child nodes of qfprom, bindings of which as described in
+Are child nodes of sunxi-sid, bindings of which as described in
 bindings/nvmem/nvmem.txt
 
 Example for sun4i:
-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
