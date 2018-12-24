Return-Path: <SRS0=tR0U=PB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E463AC64E79
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:06:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB5212070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FPodgE6+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTI4+8cL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB5212070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=xCrWo5QcgFZCza3N7L2Fackj9rgAmxwSqi8nA7m3SXU=; b=FPodgE6+IomrnLpFmWDqDgd39P
	m4N3jW98rb2MxBYOOsD4Bt3jFxlJmKZE1SyqomfJGgf05iPEXCHDLDFQpjLD3EnRBFA03asH0aj2Q
	hCI87vbAFY29oB3Sk8u8ldRi4WNo2KwB3biwPGKI/Sd2FHRIdAlIY7ZgDdIXtedg+kap1QqMjFLDO
	ohPZKGuEYhaONUy4Sj7AiAOUwDbxKs7m1VrvAJEnqrMT3nMOQn+8TWP77VNWb6HbcG60QS1GhSs6z
	wBJtSq1Cbs/j/71fk4TmMfVjcJPg1rKHj1SzsbdTzUA7tTCUNyr2htdoisREjmZZH29NwiGduJ5V1
	fS9lQGNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbYMV-0000xE-Qx; Mon, 24 Dec 2018 22:06:11 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbYHv-0004Sl-Bw
 for linux-arm-kernel@lists.infradead.org; Mon, 24 Dec 2018 22:01:28 +0000
Received: by mail-wr1-x444.google.com with SMTP id u4so12530096wrp.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 24 Dec 2018 14:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=lduvTdvt6JcEpnSpmltVeafjnok+c/QPakMMBL6iHiM=;
 b=GTI4+8cLB7EIkqORQRNJK2e+mWwLzHxqnjqdg0FW8/YPiWvdVUJgTgzL1tnRGWMahY
 +o4hpkP7VEra8b3sO/7aBg3Xms15b9MNIGsed5hecXpiJW4NHbCkxqQkNX3otMO2DYTi
 BZE9pYE0euHvXydo9qKoLxOhWbEXiMWkKowj/nRvXghj8j2U7XRpqmwyyRZcj51Qo0Oh
 btEg7bjWQyHUu1cbDnlkwG7gH9IWb+3IciEEoQc0I5T/Eg6sR4AIjyJPrpVbhlpgMxJq
 EktDWHNE3t3pMcod05Eck4smEAJiZ3cnYo9Ovy17HJeDm+WhnrilZBJ4h00XXCyPFO4o
 0TQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=lduvTdvt6JcEpnSpmltVeafjnok+c/QPakMMBL6iHiM=;
 b=PXmklzHWFj/rzhCkGl4ONp8sYIo07noYoSWGNW1X8VviDJK7UbgbbRC10EHrd1Y04m
 kajkEHNO9isM6AIlGH19Bv/eITuuC+Z0sf6ip7lpakLvy1d8VHmLm+V/GjRtjVnwhAYD
 T7RnozBO6ZFDKn7tTr9+9l/oL6Jd7Ld855oyTUM8uuMMUgBKtQ/q8L8H9oCppSMt3b0D
 tuqeGPpqb1zgiOWRbKdy0nEqJiofon50lz+K+FZok8FmJcKHDsAK9lszJx/24QYqbSy7
 Wqe7eia1i6r6uXLaWIEVX8IBxfP/erBsCKHgicv4GdPz9O94NVNjfAlL88BE9J38m1qQ
 UhpA==
X-Gm-Message-State: AJcUukftjpLWBuA4EnJHvTWcN+3v05wsoDDFfJcOEKvfQzxn/mzbPw54
 oed26WVTH6TB0ngVdqLULw4=
X-Google-Smtp-Source: ALg8bN42hV1R5my0GPnSzrQBulHiF/G7OSjmVP2ZkIj9Y7TxgAAyno+CS4h4zcAR6waf0Xg/0xY23A==
X-Received: by 2002:a5d:454f:: with SMTP id p15mr13782754wrr.39.1545688875943; 
 Mon, 24 Dec 2018 14:01:15 -0800 (PST)
Received: from gapa-Lenovo-IdeaPad-Y580.home (daw20.neoplus.adsl.tpnet.pl.
 [83.23.22.20])
 by smtp.gmail.com with ESMTPSA id d4sm23970153wrp.89.2018.12.24.14.01.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 24 Dec 2018 14:01:15 -0800 (PST)
From: cezary.gapinski@gmail.com
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
 Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH v2 14/14] spi: stm32: add description about STM32F4 bindings
Date: Mon, 24 Dec 2018 23:00:40 +0100
Message-Id: <1545688840-23992-15-git-send-email-cezary.gapinski@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
References: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181224_140127_405941_2268EA77 
X-CRM114-Status: GOOD (  11.35  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Cezary Gapinski <cezary.gapinski@gmail.com>,
 Alexandre Torgue <alexandre.torgue@st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Cezary Gapinski <cezary.gapinski@gmail.com>

Add description that STM32F4 can be used in compatible property.
Master Inter-Data Idleness optional property cannot be used in STM32F4.

Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
---
 Documentation/devicetree/bindings/spi/spi-stm32.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-stm32.txt b/Documentation/devicetree/bindings/spi/spi-stm32.txt
index 1b3fa2c1..d82755c 100644
--- a/Documentation/devicetree/bindings/spi/spi-stm32.txt
+++ b/Documentation/devicetree/bindings/spi/spi-stm32.txt
@@ -7,7 +7,9 @@ from 4 to 32-bit data size. Although it can be configured as master or slave,
 only master is supported by the driver.
 
 Required properties:
-- compatible: Must be "st,stm32h7-spi".
+- compatible: Should be one of:
+  "st,stm32h7-spi"
+  "st,stm32f4-spi"
 - reg: Offset and length of the device's register set.
 - interrupts: Must contain the interrupt id.
 - clocks: Must contain an entry for spiclk (which feeds the internal clock
@@ -30,8 +32,9 @@ Child nodes represent devices on the SPI bus
   See ../spi/spi-bus.txt
 
 Optional properties:
-- st,spi-midi-ns: (Master Inter-Data Idleness) minimum time delay in
-		  nanoseconds inserted between two consecutive data frames.
+- st,spi-midi-ns: Only for STM32H7, (Master Inter-Data Idleness) minimum time
+		  delay in nanoseconds inserted between two consecutive data
+		  frames.
 
 
 Example:
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
