Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B42C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 00:26:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ADCA2184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 00:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OUh1Al8H";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VcUl6ZcO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ADCA2184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PkHLjYm2dp3Q/yxaKzYE3VJpJ6riPeEXFjkNFwBzMJI=; b=OUh1Al8HeT3dil
	kn2u4XlOcUnu25D5LOQ4Yn2dNcy2+0DVxj2bnAwSOaeOVrSGzH3PGZFhsM3x53ETKIPkmrG/FAHp6
	ueeaR5xmmuWMkzjSxErFk5mhvLF6A6IfYH9ztyYwNcD/m82tHeK1Wt4+sLDxhv+NCHGsSNTXZ2oxR
	YwcFnkzEzJFIrqkp5HdttkPzy7yiABpOJ5sXLVzTD69/BOq8SzNOzbmnsSnaI88ax//Hf7iYmeDJo
	YtNs9UwxyHsoV0sOqci/k8AMHtXedZZpX3FGOlIbpH6zUajs3zhpOij0YrOCuURtwFulZLxxLLTfz
	Jv+sMN0DZbvKSxJoo+7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZPh9-0003L4-4k; Wed, 19 Dec 2018 00:26:39 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZPh4-0003Iw-4Z
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 00:26:36 +0000
Received: by mail-pf1-x442.google.com with SMTP id b85so8935290pfc.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 16:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hL3Ati85fy8xFPkWQkPeCaLxIhmY089PTpo//eHsIx8=;
 b=VcUl6ZcOmFKO1l5mSOnUQ4w3T8m0EkrQ+Cs76VpPqospZNTYpNroW6AFJzRAtliT74
 7aJmeqwGvzULNnumJ2qX61fsmVOTRNELlxlGd9toemARpH5dW07e/0k5pB2ZJ2ofP/pp
 YZOlYrQDeHif/GkIUn3ZUHaH5KRK6RNZce0k8VWZkD5sPlxHpbvNMx9Kd3nB1wWnF+1s
 LmSHH+/z//N7XynNUl4X12YzIyB89/srrijPbbAwbxMdB5bZy1TTIGlmHJ7oI1WATObA
 rZav8dAdDuxc6CyJnxZthk44IEcU9XyDAjMM40KhyOW8TUrgHYEeA31Aw5E+VlfsYqKL
 poCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hL3Ati85fy8xFPkWQkPeCaLxIhmY089PTpo//eHsIx8=;
 b=IBJVg94RhP5wiK/d865y9tC/GA+myZeTuazHJrrZOUAwIIg5nkhI9riM2ISekt5RvA
 gJqrmZwFiaKh961sjE8VRSAYoqnakczkm9KqfA5G4aCYfC8/A+tAHS/GXrTaM6KNRFqG
 q0HuxdQKZXVtclCpnBOw+XBvV/kt9pYdBhYyq5lxXCX4DxkcCvpDN+Fsa+ioKrEXgEAa
 f51OiW5XnNv3m2x3I44mLm3Lb07AwGFdH4GkFsWU8kF1LbOjIur834Z2dc/H6JhFjx4T
 74oNkUuoUN2ibCOIE/nHnauUafIi3R9pUDNwfwvONGqEsriBzdeUWrou9VUiinocZhN0
 IbDw==
X-Gm-Message-State: AA+aEWYOqRWOvGLLNFYkJfxLreRnoYy3VZ4wTWBvVaWcDwGWJoO/OOPi
 UimzDOTdNuWSeWzkcgYRIKvbHQ==
X-Google-Smtp-Source: AFSGD/WLtHfBXONkh3HKQH8ghbzwWlejt8OaqHmf9eAhUkKNvnPb1MN9y0PGNOXwI2e5SogvuyrRVw==
X-Received: by 2002:a63:990a:: with SMTP id d10mr17722148pge.279.1545179183263; 
 Tue, 18 Dec 2018 16:26:23 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net.
 [71.197.186.152])
 by smtp.gmail.com with ESMTPSA id x12sm19743148pgr.55.2018.12.18.16.26.22
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 18 Dec 2018 16:26:22 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: linux-amlogic@lists.infradead.org
Subject: [PATCH 2/2] arm64: dts: meson: add g12a x96 max board
Date: Tue, 18 Dec 2018 16:26:20 -0800
Message-Id: <20181219002620.12138-2-khilman@baylibre.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181219002620.12138-1-khilman@baylibre.com>
References: <20181219002620.12138-1-khilman@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_162634_176508_82D37B37 
X-CRM114-Status: GOOD (  14.55  )
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
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add the G12a (S905X2) based X96 Max board[1].

There is no branding for the manufacturer anywhere on the product, so it
took some digging to find the manufacturer.  But since there's nothing
about the maker on the product I've left it out of the DT name because
1) nobody will no that name and 2) keeps the DT filename shorter.

[1] https://www.cnx-software.com/2018/09/25/x96-max-amlogic-s905x2-tv-box/

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
Special thanks to Martin Blumenstingl for extra digging for the manufacturer

 .../boot/dts/amlogic/meson-g12a-x96-max.dts   | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
new file mode 100644
index 000000000000..fe94765b671e
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "meson-g12a.dtsi"
+
+/ {
+	compatible = "amediatech,x96-max", "amlogic,u200", "amlogic,g12a";
+	model = "Shenzhen Amediatech Technology Co., Ltd X96 Max";
+
+	aliases {
+		serial0 = &uart_AO;
+	};
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x40000000>;
+	};
+};
+
+&uart_AO {
+	status = "okay";
+};
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
