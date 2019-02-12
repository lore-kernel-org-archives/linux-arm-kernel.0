Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44645C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:03:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1416820823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZvhRnfNe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="DDKaRtFg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1416820823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Cd7aD7pcoHGKVcXvYvul3L081RgnKvmYOnV7bK5VdzU=; b=ZvhRnfNeGknM2T
	sjcaQW2zIMyZXWfRlG9N36Qgk03ascyIaKemKliRxCC9qYTLD8TiQwKpuI0ssbnvBwhxcfhGyx9ju
	JRYD1DPGVe10uLx8Hejy44TBNJa/IRnTviWFaTWZDnfp4g5csa8gIvPrE3DB2IgoDo45nwQk9TsuE
	rZJkQ7kOtini47UpTsRoP0IsDVzGlppGF7TKLwVvwRMu2OR+ZtN3p9EesLZsN8bm1JLTqHw87gu+T
	7CT+5TXuLtC9ow21havKAE9YWNjxSF6AnJjphHAN8vYyQl7TDWYONYcKxcH39e/pS21/D+vmE5nxo
	RfhzUjOMf2xFvI2i9Fig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtYex-00046g-S8; Tue, 12 Feb 2019 14:03:39 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtYeP-0003Ym-CA
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 14:03:11 +0000
Received: by mail-wm1-x343.google.com with SMTP id b11so3089360wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 06:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dulm1bU9WtsfyglzYBfpic3H5/a+/roIjKv2vYQ8/qg=;
 b=DDKaRtFgKO7VzFN3HDS4BSseE07cHdEL2YnMBj5rNfi4sdbaVkIJHhlvDCSgVwbNgc
 wcTWHqrO4lr5n1X2fyNzKUlAyr94HWE1W4vyjSIlMWbgs6O0YqrUBsXo4X0R42s8W9+A
 3+4PA7KeXrPYmDkwPdLwp9KEltX4bvhCs9rf5nWy9x1Q24o9NM0DR3/6M7Pmw45c97Wt
 M2wrfLuZy4gAqor7FHhhDO9sKcuU8ywd8BMXZtwGSXWPWAr5b6kcStJPlpuoqwvgAoi3
 PZY76QWsSBEVeqzXnvkiHgjwmKSSLuBdR55cJf0DqQofKrr0G+b7MwjgnLnwZX9BZI1r
 IWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dulm1bU9WtsfyglzYBfpic3H5/a+/roIjKv2vYQ8/qg=;
 b=TsUvyTCUDpJ4jCx1WUFQs0WQo49GiX5M7laE8eJQC9yag3VvRN9ovYcyq3/69p5cO9
 RSXJmxvqQzK0yd1uu0xRdbVmjwSdW8W8qT2pfb+ypvT+OjxrBZ/K2yOIf69bsGynUWhZ
 bXL0ee/6GuQ7Im5xylv+j89NOVxY7YDXndVW/y6zX+9gyOCgzmfkCzyvKhQRzAm4cVVK
 t63E/3ATH+++axV6OLLKfcJvgMmFucEUVIMgrhUBuZwAmYOaqq5XdNO03fWZT5rEc14p
 Z/SF7AtweZPIEDoOYvUVDspMDn/OSt/EUL4GgGx/2fgAGwZig8BqPXMa4vmE5p069DJn
 SuLA==
X-Gm-Message-State: AHQUAuZR+zXcjdPfKczk1gxSf0MH1y7BlYSETCZnZl05vWd0vkRSzGBK
 uyvLlC0U4bmoiqRI9LLVP/7VYA==
X-Google-Smtp-Source: AHgI3IYMiZchpHwXlRRXUxNBcje3WNreoRMlf+KDfkg3zQC6oxYJP3FScpJukr1yLGZK+OO4ykSc/Q==
X-Received: by 2002:a1c:eb18:: with SMTP id j24mr2886191wmh.119.1549980183432; 
 Tue, 12 Feb 2019 06:03:03 -0800 (PST)
Received: from bender.baylibre.local
 (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id g10sm23435678wrq.81.2019.02.12.06.03.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 12 Feb 2019 06:03:02 -0800 (PST)
From: Neil Armstrong <narmstrong@baylibre.com>
To: khilman@baylibre.com
Subject: [PATCH 1/2] vendor-prefixes: Add prefix for Shenzhen SEI Robotics Co., Ltd
Date: Tue, 12 Feb 2019 15:02:58 +0100
Message-Id: <20190212140259.9537-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212140259.9537-1-narmstrong@baylibre.com>
References: <20190212140259.9537-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_060305_432363_DBDD65E7 
X-CRM114-Status: GOOD (  10.85  )
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
Cc: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add vendor prefix for the Shenzhen SEI Robotics Co., Ltd, a chinese ODM
specialized in Android TV HDMI Stick, OTT Box, Hybrid STB,
Smart Home Gateway & more.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 4615d4b9d11e..921ad8f88ed3 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -343,6 +343,7 @@ sandisk	Sandisk Corporation
 sbs	Smart Battery System
 schindler	Schindler
 seagate	Seagate Technology PLC
+seirobotics	Shenzhen SEI Robotics Co., Ltd
 semtech	Semtech Corporation
 sensirion	Sensirion AG
 sff	Small Form Factor Committee
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
