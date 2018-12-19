Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC55C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 00:26:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACCCE2184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 00:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RR/IIRTV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LEBnzzeW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACCCE2184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=zV54LsUR9fUHw0Zu3t1hrtdeMEZ4FbzTYX5LeV2NyUc=; b=RR/IIRTVUpozxN
	VBbrOU5dGd2NDgv/KeUX/POzQEqkzEZV4zd+V4dfND0OtHenTJ29SUSXslXfYETnU5vUKCBuhCRJp
	Bv37XuDG7pZ+jLldU+7YxAR1W9+YqSIkumh6WA9ZfJUb2LVcLiDrNUZaYfp2ZOAQp988iZYXnLVGF
	WbydqNcwf0/38aqKNYFvCrKcGUybQ0PLcZkzkfIHICi6tnzIT4Zgz9XP8qJwy+iTuk29GXOg7x1k0
	N89nQaNNalmxaJZwL+BqGqNNP7YpFkaHZ7eztoU5ydFdrCsO/WGk+2UQ/Wosi+Fp4Td8e0eoMgGDT
	UmTXFblopd/AcLonFlNw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZPhM-0003YE-TQ; Wed, 19 Dec 2018 00:26:52 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZPh4-0003Iu-BB
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 00:26:37 +0000
Received: by mail-pl1-x642.google.com with SMTP id u18so8592650plq.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 16:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fM4yF5XC/CAQiBy4ThvTvJ1DsvWxr4n59kQ4YqGRqpM=;
 b=LEBnzzeWk9BDOzcgr84HeCleKD2RkI8U7WFwKIznIXQHvexHoLL7mNE5Um9xtQgJAy
 zIO7HD9qOlh6tbY9Lv3iCH+LRJB9lMt/IHZgoULWNg0HvcleJb4uWEjBOwkCfFYIMavk
 ztehNg7BNsPxgO0g5DmySBLqOWCjk7dGVZeBB77YgOz36K0iUTt+iqXuRl7vGCQ576Is
 C419NBXLgZC3Lrekyp54xb6DT3mzbnfhzo4vMT1xM7tUuUQP97HtDhsuAA9sNYjkgN7l
 hROGlHok7B3vmW43/OdoEI9zPVra33CdE9Ilzd1Xq95JYueeYp2TTJuXTkzxKcpk5Wh4
 n1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fM4yF5XC/CAQiBy4ThvTvJ1DsvWxr4n59kQ4YqGRqpM=;
 b=JiYkzxUuev4nTwa69AionlqLNhh7qhKjzOGi99VB8qIbXtLsircVyHb4RJHj8ssXn+
 cOh92a5bJIy/F4MbbZP2VUafYItOPkxLp2iSlb2rP607coXFc9BLfADIoXOKCNykueCU
 QtqZ0KSfphgpZSDaa86sIOrzULjbmM21cEt8QKSRyntBETQCsed6vHdb4654GEThuniH
 zxsg1yLW2Yzh0N2NzphfOMDky9ihsZqr9U7rvgL+rE5/9rWARwXjM00ElzSKd0MlalCC
 sifJU9nM68ab7Ps6Ba6DdTNzYXzbuuyqQj0E8FqFQ4wVq5DsmIQxwCnSPLkCGUk+2bdG
 YbHQ==
X-Gm-Message-State: AA+aEWbJ8fE29+50envF3OSblfoz/cRxH7Sgfa7CvjPN4FXWacGB32Cp
 dAaXecM4+A5kxD+zxmi/eH2mAw==
X-Google-Smtp-Source: AFSGD/UmHiVKEqybFlkYFSRdU9kYTL5ptwECo+Nb+X52fVaO5ke1e9cIP/isuezk2zD9G/9CF9StAQ==
X-Received: by 2002:a17:902:128c:: with SMTP id
 g12mr2386320pla.146.1545179182066; 
 Tue, 18 Dec 2018 16:26:22 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net.
 [71.197.186.152])
 by smtp.gmail.com with ESMTPSA id c9sm9039279pfc.92.2018.12.18.16.26.21
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 18 Dec 2018 16:26:21 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: linux-amlogic@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: arm: amlogic: add amediatech x96-max bindings
Date: Tue, 18 Dec 2018 16:26:19 -0800
Message-Id: <20181219002620.12138-1-khilman@baylibre.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_162634_385240_15707C89 
X-CRM114-Status: GOOD (  10.99  )
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
