Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D836C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:42:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E739C2075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VaBNdkud";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qQxtFI3/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E739C2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=YopO2vduMKcvI6ctOGqcJKf/+YL2v9BOZnrkgDRO3G4=; b=VaBNdkudZK0LF+
	iaTudN7yvL6Czgudqj76wsxMg7wQujk0RssbwXbpu1tdTWMcVC/QVX4GJ32g45LXFExfTQoozR3e5
	V9bq8Qk7AgytdHhnioLO7PXu+TqmRzAPJ3AsaqTxGF2xBwE+PDrbZnYE4YDfuiWBy+1mybMwUScYo
	hHLCdTZA8wTYyZaGckIox3o9aHdUCoBSerUnkTV46sUkG75i+UvzjFz5weWXQSa/Fp96lfk3mCOR9
	oqAU9ulmBo4KBS3C0xKVDiahQaPznpmt8zYIbbOxf5Ng/v/3oD7lYpE3Gc8Q3G9BoL4Vu+6UIsyD0
	dONQm0LOyWdJodQzyjqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs7MO-0005Rx-Qq; Fri, 08 Feb 2019 14:42:32 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs7ML-0005QX-1U
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 14:42:30 +0000
Received: by mail-pf1-x442.google.com with SMTP id i12so1754047pfo.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 06:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DztFhUbqBiBoiZBM0psbBi9/K4S0FwqEup8z3SPQ1iM=;
 b=qQxtFI3/Dlox1aoePvHCBqsxKDKy7lA5nNT/xbpSTgJ0I2Jg2aZwh7hkBpUuwvYp/f
 ARyq1LaQPmhrU+JIWAAZmuLh2ovqwdhS2swxeoieTxR7az3HDMWWszy746Bjv57KGzE7
 na0Ldjq/LHHRy28Q4GyZP9HP97vZSIRPsz9C/GrRQbXTczRRYhY4XZnDwYQV0QaL4zq6
 JCjZnl/4A0Pjge8ffIJtHKLFo0KPTH+xB6Pds1TXQX/sBY9cBM1Y0f2ixeJmm5YI1mgT
 cLn1VRqiG10s0FiRNXW8QU4PC6STjxH3MZhciw21Q5F0OxXMhIKwohTRLHIA6DrDnPbw
 dy5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DztFhUbqBiBoiZBM0psbBi9/K4S0FwqEup8z3SPQ1iM=;
 b=p5GD/hzbL/2/4sSWSdW8pB6XmuXG+8TSLT37HgiJr45JBvo85a6YkDrIVhcbifax4e
 yzXrdzLA3RtAOqlfRCq5O8ZqDh1/MgI2G3Hx3RxEerX2ONO+aXhoOUGwoc3PFJXlzt07
 8DfV6QlWae9J/3IgSD4iqQ8rhcLw0HHcElblZK9E5IWmldzysvG25E7sAydHW1hccjMb
 II7DbUrKSOPrc+r6es5EkVWKP6bc28cwFNkP71abLojojUZIoD3n/T0aXzNjbmuEUSgT
 PrKLK2uW95/wq1PK7Rq9p0x8ZdtZ01lwnZQ5RtzWJE3e94M3DiCC4HTyGfjDOVZeEuwv
 MaiQ==
X-Gm-Message-State: AHQUAuYagNl+kPFiyyxECJfAPIH9l1w+o0etqO13iiaII9/A7eHk192y
 XJdkGjjJV2LLLCv1HFu86F9scQ==
X-Google-Smtp-Source: AHgI3IZccgBJ2lYamzT34UGYuVamn2T+EakenUEa8BfOLpLMyj9sGEzVoDgN0DsRMQCvI5uI+iZ7yQ==
X-Received: by 2002:aa7:8759:: with SMTP id g25mr13568517pfo.248.1549636947453; 
 Fri, 08 Feb 2019 06:42:27 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:da9d:67ff:fec6:ee6b])
 by smtp.gmail.com with ESMTPSA id n15sm2220478pgu.9.2019.02.08.06.42.26
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 08 Feb 2019 06:42:26 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: linux-amlogic@lists.infradead.org
Subject: [PATCH v3 1/2] dt-bindings: arm: amlogic: add amediatech x96-max
 bindings
Date: Fri,  8 Feb 2019 06:42:25 -0800
Message-Id: <20190208144226.15102-1-khilman@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_064229_225412_28532612 
X-CRM114-Status: GOOD (  10.03  )
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
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add new vendor for amediatech, and initial board: x96-max

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
v3: fixed the SoC name

 Documentation/devicetree/bindings/arm/amlogic.txt     | 1 +
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
index 8dbc259081e4..7f40cb5f490b 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.txt
+++ b/Documentation/devicetree/bindings/arm/amlogic.txt
@@ -109,6 +109,7 @@ Board compatible values (alphabetically, grouped by SoC):
   - "amlogic,s400" (Meson axg a113d)
 
   - "amlogic,u200" (Meson g12a s905d2)
+  - "amediatech,x96-max" (Meson g12a s905x2)
 
 Amlogic Meson Firmware registers Interface
 ------------------------------------------
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 389508584f48..4615d4b9d11e 100644
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
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
