Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13E9C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:44:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EA9420861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="txYQzTyM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lusticky.cz header.i=@lusticky.cz header.b="Jn82ia7A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA9420861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lusticky.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vhaHdw4Xuy8GOn7U3k9aPAFJVgcevIKC5vw4JFrWF0k=; b=txYQzTyMyAGZ1m
	HP13FoC30igJ9SMi+Ysz8XUCnF18mvJQI5UnAVS30Q9EBqotN8HtxI3UD8wfU/oBBL2S3/puLaS38
	e0lIjN2orOIhuEFczdJ+WmPQJiPZmuupIdXjXyzy8re2//YB2tOHwAZzFJNdU4GHBhWWK2fq1Ykft
	pLqEedYYyl+n6sQbKCBP/DWPX8IEfJYXJZYqFbw5AJrCGWfykQ8i1GvtRPKT4SbbxEJPkkgP6Y28j
	E7BXvtlu+srEwlDYs5DtaVbEMhNU0R1SqF/c23E3nfYslf4Kg/keIDMQ7u77CpO4oZHBz24Q3KIXa
	ZqvrOQfHmCFa6i5u3Gzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmF5U-0006xN-SV; Wed, 23 Jan 2019 09:44:48 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmF58-0006fB-4h
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 09:44:30 +0000
Received: by mail-wm1-x342.google.com with SMTP id n190so1310161wmd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 01:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lusticky.cz; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XU9Ziu/EctJ3vfvW9Lhd/8yY1FZiXEbMGXZMzrMGBoA=;
 b=Jn82ia7AQqEjc9KJ84lPSiMtQDM0XMYYH5o2QddLzTotbm9HQ56U0tDYaDrEdNxzIU
 X7IulhKDTiGpbAAbX2f7QED3c2aYh8l3jBD30yRewPbsYFOJ7Loja01c+iTgU+k83ICK
 WkIgegJDqbIDBR86T0LSHzZ2dq8uKAiQSx3ms+Q1PDQI/ijag1oj4Z0fMiBKSADpgpAs
 vFeohKZ7sQSRmequU6Dox01w8Zt5RmzKPRp0lzcSYU+qdnARFkykmAhpPlvyORy3JKvo
 ImjAjBTZfZTDvQYEgClJua0tqU44jKfkY+Slmba8a5qj/9Rl7VMt8abpLFAj99pXylaq
 gTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XU9Ziu/EctJ3vfvW9Lhd/8yY1FZiXEbMGXZMzrMGBoA=;
 b=iv8OT9GclQt/9uNPqpMDCLRn9TjaGH4BDpy5ObnwUrhIdpf8fbWUcfejRAA6YQwe12
 +lclBWbsjUAPQh5RBPY/u5EDtBOu0lBmlrFRiss41WQLtzjDVGKMh1nfCVYU74TSCB40
 +Yk+/6SZFmX/l7tnG5kVVnPHAxlIKjGcLeEplaMeBsXqZl/3ya9v7Yxl1PkL30G4NzTD
 hiZC0rRbhSwcXsehhtyVApOP1IZEoDgGYyhjve4CuKrc0iOgLob8NAwYUbW+qt6eoCp0
 VBpdE1Ovwcvl/F5NNTzmkkGfVaQx3hyhH4ojZS2DUJKeI9J4TJ4jhEi2Jwy1GA/AsRso
 KAzg==
X-Gm-Message-State: AJcUukfWchdaXR72iItOwdwWKeLGhiCWKe0N0qjHZhrQB0uW2fGMM+h9
 xEkVzSALyOYbjCxlohaE8P0mPbdOkR+CcA==
X-Google-Smtp-Source: ALg8bN4VEbgfIf9ewBm5ICAJvtKR3xTat8so2p5VM7+Ly7iUc1GO7HPeCfOf8XnScK0f3u3qxUX1Aw==
X-Received: by 2002:a1c:96ce:: with SMTP id y197mr2063168wmd.36.1548236663786; 
 Wed, 23 Jan 2019 01:44:23 -0800 (PST)
Received: from e430.riomail.cz (188-175-152-238.client.rionet.cz.
 [188.175.152.238])
 by smtp.gmail.com with ESMTPSA id y1sm71939131wme.1.2019.01.23.01.44.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 23 Jan 2019 01:44:23 -0800 (PST)
From: Josef Lusticky <josef@lusticky.cz>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] ARM: dts: sun5i: Add SPI0 pins
Date: Wed, 23 Jan 2019 10:43:32 +0100
Message-Id: <20190123094334.11030-2-josef@lusticky.cz>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190123094334.11030-1-josef@lusticky.cz>
References: <20190123094334.11030-1-josef@lusticky.cz>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_014426_469782_0AF2C707 
X-CRM114-Status: GOOD (  11.40  )
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
Cc: maxime.ripard@bootlin.com, wens@csie.org,
 Josef Lusticky <josef@lusticky.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add a separate pinctrl nodes for the SPI0 pins shared between
the A10s, A13 and GR8.

Signed-off-by: Josef Lusticky <josef@lusticky.cz>
---
 arch/arm/boot/dts/sun5i.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 5497d985c54a..897340ee27c7 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -536,6 +536,16 @@
 				function = "nand0";
 			};
 
+			spi0_pc_pins: spi0-pc-pins {
+				pins = "PC2", "PC0", "PC1";
+				function = "spi0";
+			};
+
+			spi0_cs0_pc_pin: spi0-cs0-pc-pin {
+				pins = "PC3";
+				function = "spi0";
+			};
+
 			spi2_pe_pins: spi2-pe-pins {
 				pins = "PE1", "PE2", "PE3";
 				function = "spi2";
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
