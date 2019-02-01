Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36050C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:59:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E99C1218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="goGsI+qp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ssacKsO3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99C1218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J/jlxFJEDUI5MS08W1UJl7z3duS8jSYF6Zd/9qCnDNs=; b=goGsI+qppP/Oiy
	WeHgH0mkW8YuWcX87DRRu16Q+tuKq988nXEZW8z+buj1fpE3qfoTT+Q61NoTIlWkyxoKVcIMDbUWP
	ZahFgLN1oduS6npKzjOZ28TE7vM5aeN7dYuLC4sel1ftHxR+j8Ids3YVK/gchGEQh3YUSa7Q03qqG
	d+QiY9e1HxObZ/MuGpA+n6KgE2xrG1Cg+NIQJWCg/3dxWYoybRJS+FpdWqOuKJzn5Wi/CGDNDROxC
	fLbG3BSeb9oNKzr/L0HzSxgx9I5jnzrw55S4DpY8j66FLp30E0WapMpf/oxWfW/OLh8myYlObVLvy
	kUGgQBeg1LINU6xKyBBQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpYPZ-0005lK-Mu; Fri, 01 Feb 2019 12:59:13 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpYPB-0005NT-SF
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 12:58:52 +0000
Received: by mail-wm1-x343.google.com with SMTP id m22so6138506wml.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 04:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hmkxltlF7dcc/tNm5bkNIJRJUm+2VowEALm8V9t6Ca8=;
 b=ssacKsO3q9tzcUuoUi9VaWrdAZwzbfexbKYr81JP0GpitsTmAQwb1nPNDzZjv1NS3w
 63WGqfMWtkEWtiCO41gORVfFUKDYt/+KJyi/dpJ9h5nMdiUL1cTXR1wziIn6ZxB4DLkh
 kdzbwxXhObsLnRbJ5CcxbjgiKeJQ88hi4vSpbZTIGmP9IycFLB45rA5ChDvnQ5SZhDko
 iBcHr7yxHG16BitnViaLtvOTuicMKWrh3hCxtS/DGBcsA0QNgw1B8DkQOKK7//MgvYJS
 w7RU8gX5pR6/mL7CziTa8WD2oNUQTSPtzDCijziMTqIs3/LQ6ZwAO/dWENhB2qvLOmBQ
 MIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hmkxltlF7dcc/tNm5bkNIJRJUm+2VowEALm8V9t6Ca8=;
 b=p6UiM0bCOoWstvh98Hf4V/YiFK6x/nILHl+c7OUaSsqrstAX2hYyqZmjQlLTogxmjX
 BGQkrJE3edLfgYHTrpO+5d77/94+/FODUzFttJQR4StsTiQTf0UvGb27rWuXlZqQXjxM
 68MZ3VFzpPFOTVnJ97tpaNjyyrozUCk69A9Z+soKOJFmr54kiKxqMRC2WJ8FEc00BivH
 mzBpLiDCu1hb/nar6mv77YW5R6mcgzxwt1bX/laZ6E1wH6l/e8B2SHFSBaGGOIvqqn0K
 WnLNxw2qhtmaOZq4TLXhPeegOuCN8Vm95se3xIwrTbTL5eMQlgen3aYamyLcHyS/vgq/
 S6Tg==
X-Gm-Message-State: AHQUAuYFOQSuxVBWvvdxwd0mfxvWAbVylJpilxY0MhWlRa8TP3bvWbYx
 Q8ElTeeuT6oN/HpU+Tz4m4faQg==
X-Google-Smtp-Source: AHgI3Ib9FUGyo+Wb/YTZo6Pq2xG4N3LjYpjPce5rb6H1DhGWsmtem+5r1MCyDSRHTTHq0NhVIrD+OQ==
X-Received: by 2002:a1c:2804:: with SMTP id o4mr2469106wmo.150.1549025928566; 
 Fri, 01 Feb 2019 04:58:48 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
 by smtp.googlemail.com with ESMTPSA id w16sm8709750wrp.1.2019.02.01.04.58.47
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 01 Feb 2019 04:58:47 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>
Subject: [PATCH v2 1/4] clk: export some clk_hw function symbols for module
 drivers
Date: Fri,  1 Feb 2019 13:58:38 +0100
Message-Id: <20190201125841.26785-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190201125841.26785-1-jbrunet@baylibre.com>
References: <20190201125841.26785-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_045849_907393_62BAE7E1 
X-CRM114-Status: GOOD (  11.77  )
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
Cc: Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

clk-provider.h provides clk_hw_is_prepared(), clk_hw_is_enabled() and
clk_hw_is_prepared() but these symbols are not exported for the
modules which prevents a clock driver using them to be compiled as
a module. Export them to fix the problem.

Acked-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/clk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 6ccdbedb02f3..6d86dbb72602 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -394,16 +394,19 @@ bool clk_hw_is_prepared(const struct clk_hw *hw)
 {
 	return clk_core_is_prepared(hw->core);
 }
+EXPORT_SYMBOL_GPL(clk_hw_is_prepared);
 
 bool clk_hw_rate_is_protected(const struct clk_hw *hw)
 {
 	return clk_core_rate_is_protected(hw->core);
 }
+EXPORT_SYMBOL_GPL(clk_hw_rate_is_protected);
 
 bool clk_hw_is_enabled(const struct clk_hw *hw)
 {
 	return clk_core_is_enabled(hw->core);
 }
+EXPORT_SYMBOL_GPL(clk_hw_is_enabled);
 
 bool __clk_is_enabled(struct clk *clk)
 {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
