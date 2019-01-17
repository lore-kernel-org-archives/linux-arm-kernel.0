Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732EFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:55:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2130D20652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GL+QmY0W";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="H0Of10pf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2130D20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=U3tCxPVcpBNE0jX49/T7MVD3IlVoZLqO8grpY67CjKY=; b=GL+QmY0WsTS/cMGb9kz7PokJEV
	2HxPxdXSBeyT4dSn3vWTk6xQifUQkp0RQFO9xJLK7mzsDm0Ka+U8wgMJlDWEeYo/wgvghBx3FmRrB
	eXE9M83aD+fgEdcru/QQ34r0mO0I/4m5SiMWLWPqKaS831CyZmWAfvQXDobzudRZYPYEqhOprNUYs
	9E5wNOzHTuBciFzqDTLTzWm3rhG4IjFmEZ0pVVEBP/7Fay3qpmmThhprlS5qPncJbG4ninDGIktyq
	Xl6nA6e8uZ9Po9XOIl7AAKqXgs77n/P9MNgsaPXfHPWBh/utk1T6fM7GhU1qSgMV5y/L5v+V9DXru
	3r9r3ulQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkAxQ-0004KI-T5; Thu, 17 Jan 2019 16:55:56 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkAwG-000244-Hz
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 16:54:50 +0000
Received: by mail-wm1-x341.google.com with SMTP id n190so1826710wmd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 17 Jan 2019 08:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=b8QgOE/tP8Qxz0RDuzfPpPYFYowoEBOjoA8eqPauTxo=;
 b=H0Of10pfwb0GAxVCtSdHEMcUdQGVnzowP83zcS2ctxKASi53pk7mJaigAIOY0eQhkg
 NmZX/E1bwDrCf/n6l1XP1LFfL8WNDNmm4LFWiWaulVt9/6IWcQvvQHe3CnXA9qhp3NCj
 7/olVS/pMbpbUTzsNsEvwKwftD4W0IU3R9r+YBtT7jK5A9BQ5lCZUxNtpFNEBXQTm9G6
 u6d1txDihVH8TLJ+ERFZhXOVUQ5PCn26s31KrC28xgpJfjtxvV8SsgFwgfdAv4NMNzXC
 aCiKOeTT2jmVSh8cMkzugkzzgWQ1fCSDS7J9fUWMel44gdh/f0UERKITvwRXCxbWly4V
 JrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=b8QgOE/tP8Qxz0RDuzfPpPYFYowoEBOjoA8eqPauTxo=;
 b=VMRYH0qMLH+9JDqQiOXU5hbavqOYCkS2nUcVzFfHOqQvcfCpHHr98PX3DSpe5dym4s
 8JxGXXnw1E+5rtmk325WeUxU1mPdyQz/km2shPcN3+gk4vGl3VMvxc6lCT9bBuICB01E
 Mz3G26gR/Ds4j9U+N72rOqO0LY1nCbCJsz4I9FI+06H1FeqET7CFXgyVEL13kB1/yu+E
 zNYuiJ8MKAH2mnz7GlCiX2eOPhdbhquUUk1VXGEh3RY4H+uY0RayzPH8PHNGk2vd5Gga
 KSwfoPJHgXmfAH3My9Z8G/h6V0kRpKach6rqR1N+8AePpWyK2Fw6ieDuY5Cm3x3CAW8b
 nDhw==
X-Gm-Message-State: AJcUukfm8gUBAagfRLMEQz9H2xgJERIEmuX2TrxMqZjMuS9sVMmw8mJr
 EoEBbzgaQrkFERKTif1d8gj9NA==
X-Google-Smtp-Source: ALg8bN4SF57si1/YPd/9aUuvRaLoUikPxer9tLyuwYYMwjAf+wqgeEhhNOmtost06mEEjob9LtIuyw==
X-Received: by 2002:a1c:96ce:: with SMTP id y197mr12976064wmd.36.1547744082833; 
 Thu, 17 Jan 2019 08:54:42 -0800 (PST)
Received: from loys-ubuntu-BY1835A49200471.thefacebook.com
 (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
 by smtp.googlemail.com with ESMTPSA id b12sm65309630wrt.17.2019.01.17.08.54.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 17 Jan 2019 08:54:42 -0800 (PST)
From: Loys Ollivier <lollivier@baylibre.com>
To: devicetree@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 2/4] dt-bindings: gnss: add mediatek binding
Date: Thu, 17 Jan 2019 17:54:32 +0100
Message-Id: <1547744074-28308-3-git-send-email-lollivier@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547744074-28308-1-git-send-email-lollivier@baylibre.com>
References: <1547744074-28308-1-git-send-email-lollivier@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_085444_740204_B146FDEB 
X-CRM114-Status: GOOD (  12.60  )
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
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>, Loys Ollivier <lollivier@baylibre.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add binding for Mediatek-based GNSS receivers.

Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
---

v2:
Renamed bindings from Globaltop/gtop to Mediatek/mtk.
Moved current-speed as an optional propertie.
Removed the status line in the example.
Added "mediatek,mt3339" compatible.

 .../devicetree/bindings/gnss/mediatek.txt          | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gnss/mediatek.txt

diff --git a/Documentation/devicetree/bindings/gnss/mediatek.txt b/Documentation/devicetree/bindings/gnss/mediatek.txt
new file mode 100644
index 000000000000..fd984b4a9a6d
--- /dev/null
+++ b/Documentation/devicetree/bindings/gnss/mediatek.txt
@@ -0,0 +1,39 @@
+Mediatek-based GNSS Receiver DT binding
+
+Mediatek chipsets are used in GNSS-receiver modules produced by several
+vendors and can use UART, SPI or I2C interfaces.
+
+Please see Documentation/devicetree/bindings/gnss/gnss.txt for generic
+properties.
+
+Required properties:
+
+- compatible	: Must be one of
+
+			"globaltop,pa6h"
+			"mediatek,mt3339"
+
+- vcc-supply	: Main voltage regulator (pin name: 3V3_IN, VCC, VDD)
+
+Required properties (I2C):
+- reg		: I2C slave address
+
+Required properties (SPI):
+- reg		: SPI chip select address
+
+Optional properties:
+
+- timepulse-gpios	: Time pulse GPIO
+- v-bckp-supply		: Backup voltage regulator
+- current-speed		: Default UART baud rate
+
+Example:
+
+serial@1234 {
+	compatible = "ns16550a";
+
+	gnss {
+		compatible = "globaltop,pa6h";
+		vcc-supply = <&vcc_3v3>;
+	};
+};
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
