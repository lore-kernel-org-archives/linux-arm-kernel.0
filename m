Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C9CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:35:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62CFB20869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Lkk99nAj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="lm0vozWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62CFB20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=zV54LsUR9fUHw0Zu3t1hrtdeMEZ4FbzTYX5LeV2NyUc=; b=Lkk99nAjYK85j4
	DMNg9POEkoW7MyrxoEbf350X5pk09RnTzJ31EXNOkvF80z2xj3PmWYxol9JoDQ+xFTZ4iCnrjsCq0
	Fff393gmYk4n+saCDVW8a/QqsWK8l3rPY8uCwe1j0SXko8IL9pYQD1NDD9zH7s7BmP3xHs34Zbewv
	mSwcnCns37AgZBylriCzwJ7/BeslrNgPsVwG5WqubMLfdwIqDcXxOWc4P/bDTMmCfftMePBK52gsJ
	u99XizRzE7ABTFBBM0WC6CnM6DXVvbyhWa5pVrhh2sZWlpH3no7NYkDwdc6J9GX6fbi69qHxZeeV8
	/jETfqoqM/trhIQugd5Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZlNI-0002Ri-N2; Wed, 19 Dec 2018 23:35:36 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZlNF-0002Pg-Er
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 23:35:34 +0000
Received: by mail-pg1-x544.google.com with SMTP id j10so8940682pga.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 15:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fM4yF5XC/CAQiBy4ThvTvJ1DsvWxr4n59kQ4YqGRqpM=;
 b=lm0vozWzqIMqSzNqPkOgcAURyg5cohtOOHkVCjZB1gLCtYPHOZVruQDE9iYb3dSXd4
 5xdkdqUg4SK3vpO/lkvlfIVSJgTOq8auhv6lmaEcKer/tLdo2t4IM9lHcxAuJs/BMHWl
 iYQfRBtz2iJ9HwlgsvgXQ5apoPKuBsBTI8Z3SfX2pI3jbViElLLrD4RqLK5OAAN/M4id
 SJhIWt1/XCl+HK8BEGQv6+3LhCrpJX3X+rdVID0cV3r2ELQsVbHSArFuvWOtyeUo6lU/
 mVRri/Iw3PeJfBRoMVRKGJTEYHZHtjmD25XBKdWA4dk5SA8GToQnt4+pn+R0ibCW+8pg
 JPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fM4yF5XC/CAQiBy4ThvTvJ1DsvWxr4n59kQ4YqGRqpM=;
 b=g+S0lt02C8+GXBeffzXivwfisrcKZDjnnM6le++HfjexLh0EUxCSYqikaMUQ2pWJ9D
 EoXinRx8LNQymXFAoj1044I19gxu5HRvSB59+UO6hE2M7GA0rA6+1GgwOeCuepMMINs4
 1sIxmwOOYrF5Fol/R3yYZM/nXO+1w3VmfRKmjHQUUOgfOtuqbmTGmlShR4vzCP8+O0BM
 e90DS4OAOSmvHlp9qgju2lGTC59vwxfg9nKuJOABRZ2cDN0rd3SCzwdn2aIyR2+X26wK
 35Vjpe3Pq1epTGvrRZ4S6TMm7c99IfmYhJCq0bggBQEU+eiSkdgQtVwiqA/9SG3Ky4Wn
 ZFJQ==
X-Gm-Message-State: AA+aEWZC8qDO75t3SCSzQpD7gLLBVuzsoBPSzUAihfuFb1yrnl72iPEp
 y81wraBQr3jN8R06pWE9czmk5Q==
X-Google-Smtp-Source: AFSGD/URNddIK30HEXqw6ZADC+5p/tkf7IwJUk5WjGmzW5mEu7OMjI9RUJRrChHM577ksoagRlal/Q==
X-Received: by 2002:a63:334a:: with SMTP id z71mr21409240pgz.400.1545262521018; 
 Wed, 19 Dec 2018 15:35:21 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:da9d:67ff:fec6:ee6b])
 by smtp.gmail.com with ESMTPSA id i21sm23692663pgm.17.2018.12.19.15.35.20
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 19 Dec 2018 15:35:20 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: linux-amlogic@lists.infradead.org
Subject: [PATCH v2 1/2] dt-bindings: arm: amlogic: add amediatech x96-max
 bindings
Date: Wed, 19 Dec 2018 15:35:18 -0800
Message-Id: <20181219233519.35287-1-khilman@baylibre.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_153533_493459_68756407 
X-CRM114-Status: GOOD (  11.47  )
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
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add new vendor for amediatech, and initial board: x96-max

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 Documentation/devicetree/bindings/arm/amlogic.txt     | 1 +
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
index 8dbc259081e4..c50b084b6c59 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.txt
+++ b/Documentation/devicetree/bindings/arm/amlogic.txt
@@ -99,6 +99,7 @@ Board compatible values (alphabetically, grouped by SoC):
   - "amlogic,p281" (Meson gxl s905w)
   - "oranth,tx3-mini" (Meson gxl s905w)
 
+  - "amediatech,x96-max" (Meson gxm s912)
   - "amlogic,q200" (Meson gxm s912)
   - "amlogic,q201" (Meson gxm s912)
   - "khadas,vim2" (Meson gxm s912)
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 8c413d8cc2a5..c1bb0c220429 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -24,6 +24,7 @@ amarula	Amarula Solutions
 amazon	Amazon.com, Inc.
 amcc	Applied Micro Circuits Corporation (APM, formally AMCC)
 amd	Advanced Micro Devices (AMD), Inc.
+amediatech	Shenzhen Amediatech Technology Co., Ltd
 amlogic	Amlogic, Inc.
 ampire	Ampire Co., Ltd.
 ams	AMS AG
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
