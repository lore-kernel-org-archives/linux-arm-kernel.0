Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED29C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:22:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89E7F20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ifdxAqzF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="i9fLMhyM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89E7F20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=maeoDlyw9jo/TjiUl4QWUvQgl/rNd0cEjDxkkh4Wdc0=; b=ifdxAqzFJE1/F8
	RLOMLLo2sAAzNCc/O8DQo5EojIMm9rOL0fs5sZqiOTpsS1WckHkPW0HmkdLnHDDglcttGy17BJXvk
	FNFdTXRpfWdL67VUBLYwRdn/j1u4L6bFvTRybuocGSGaDHBvGx4GwENLMboMK1gXrJo/YHw+KEdUv
	M9hv6Jd8LdgM9hrSmXpEuEqPXl09NfuKw0OnOPd1m553O+cncxTUsgt8K4z+KUZ6VC/TVTA14H0La
	JSvor/ItMq4YqoD5aZTPaqaoiJSajE61CU7d5CvzLghESIqeZSAr5Brgzpvo/daOZbzusZnKx7THa
	8vYcSRCxMxtQYHgOh94g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWOJt-0004lo-D0; Mon, 10 Dec 2018 16:22:09 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWOGF-0007th-3X
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 16:18:32 +0000
Received: by mail-wr1-x444.google.com with SMTP id c14so11138903wrr.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 08:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zSLZfhqj5LlgFfpYLOueILNrvF0k+OKE5voNHu/WFJA=;
 b=i9fLMhyMg+YgyHOHTvKZAa3yzDcRG1Q+CVmwCSS+wetlWyhZPoviQ01kR/cMaG/n0D
 IZGL21eOSqxq7ZGokDjFL49h8G1pVkrDlEBRNteA4xK/ccY3XEX5C8RJFe8I1+IV6Ioy
 DDl7QG6mkfm+zSMch6J4RPgbkjNMpLKbhBQ+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zSLZfhqj5LlgFfpYLOueILNrvF0k+OKE5voNHu/WFJA=;
 b=Ehoe7roH8vjVEwcRaKPtbkVadPJV8bbVkgl8SzZ3Wkegfzhu5i9WrifVv3ucawCPsG
 /pAPfWj0KqWlP6c2y17hauTzTj88Ap2fiyQQC5ssDBSkx0bqfamRMpLRwvjyrhw9/EbX
 5VyUfPcKedX5jL48StaiYQhor6z9MB2tNYolbe5AEMxM7ad9YmvLrttJBi6fYhTEUieT
 3xFN8hjcRCpPFAIeNv1QVjw30EST6nKJVKYEUwhWbE8yXEvyOzlgihODiA9wUKSg+N4k
 GxYAPyggeIsYtXIO4Jp15FlH/kWP4i1K6M42STU/um/KZz5gJ/qbGisSr637dtdl41rS
 f2fQ==
X-Gm-Message-State: AA+aEWa/v2bczLfH9E0ejOFwRyTGub4ImTnQHNDCuJ6PaxOlv+LrzsR9
 G/i645MjU250D1qcRZo3WtFSiQ==
X-Google-Smtp-Source: AFSGD/UG8pTrHfDIEcjUTcTwXDbLv36fj4jWRUX42zMKoNQDG4BaPOHeJx6GzE5YfiHqXFAEts88IQ==
X-Received: by 2002:a5d:570c:: with SMTP id a12mr9992101wrv.161.1544458691718; 
 Mon, 10 Dec 2018 08:18:11 -0800 (PST)
Received: from localhost.localdomain (ip-162-59.sn-213-198.clouditalia.com.
 [213.198.162.59])
 by smtp.gmail.com with ESMTPSA id b13sm8397503wrn.28.2018.12.10.08.18.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 08:18:11 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v5 16/17] dt-bindings: sun6i-dsi: Add A64 DPHY compatible (w/
 A31 fallback)
Date: Mon, 10 Dec 2018 21:47:28 +0530
Message-Id: <20181210161729.29720-17-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181210161729.29720-1-jagan@amarulasolutions.com>
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_081823_869670_C438CAEF 
X-CRM114-Status: GOOD (  13.23  )
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
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The MIPI DSI PHY HDMI controller on Allwinner A64 is similar
on the one on A31.

Add A64 compatible and append A31 compatible as fallback.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
index adc7cdf129dd..08f1f57abff5 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
@@ -40,6 +40,7 @@ D-PHY
 Required properties:
   - compatible: value must be one of:
     * allwinner,sun6i-a31-mipi-dphy
+    * "allwinner,sun50i-a64-mipi-dphy", "allwinner,sun6i-a31-mipi-dphy"
   - reg: base address and size of memory-mapped region
   - clocks: phandles to the clocks feeding the DSI encoder
     * bus: the DSI interface clock
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
