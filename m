Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD46C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:38:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E359820811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LgUha4t/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="yzIDRLO9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E359820811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=1QeySeCsBybNdCsGd3BueoxMd2TykyANoh6gFkjn0sw=; b=LgU
	ha4t/uqxFTaVTqPuiCBUH4VurC53j6zctZn3rvXcKB0eb8o1mYBZlll7pqUpBL1qO2NSDtviGodF1
	Bi/x+5OnkZ9Z+HeIFvwQfscjJ75l+BTptim+cr/+u8zdWf+D4g72a5qJEpGAeBhH/RdmvkrQng8JM
	0PKkvWReVKnNzzV2MBc4vs3sBrD8zwdBkUz1SjQe/Z/9sdNcVqSHk8tOO/NGojuN50bFKEudOvUgH
	KQujsORXb3xR326LyTAT6RGs4/Orq47GV2NFsjh3dI2cPwDDSzmQQ14g3I0BVvH50bAUTyUzJz/ql
	Yjnk8PKrdaOWIk2EdE4h0Y89TRmQzJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go9vI-0006n4-RA; Mon, 28 Jan 2019 16:38:12 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go9vD-0006iL-81
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 16:38:09 +0000
Received: by mail-wr1-x444.google.com with SMTP id u4so18804923wrp.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 08:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=L7bmc/MKBpCEs68YcmIGpGX/6J5igsqYwSDPtXbpF5I=;
 b=yzIDRLO9X+802YPKhcWAQgT3HiXDB380oqYdqf6CP1G19Qkvqfbs58ODce5fIKqtNa
 eDnwsGju3DQS4WTAt09TRz+ANV1Wi+Ti1M9Ajro2biB5h3AbGNeHOATtrroDIwBfM8FJ
 z3U2ckMCCPgEYHVoqsLKtmtQHO4RJD9wGqQX+nxlEC80cMLJtyLZhdUDC+fkR13/mvpM
 YJTUK4Aa74JoWrl0LpImzYg0mdrfcgNAq76di6GBU0q+2SEal1IUcPR2fyqfIEtk5G1N
 hoCj+M/CpkRVFiLa8K+q0g0zu7c+UOiQvY39wngNKGB8IyFCO9n+346yAcy93jGXn9bb
 XN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=L7bmc/MKBpCEs68YcmIGpGX/6J5igsqYwSDPtXbpF5I=;
 b=Va3XmdTltWe6NWf3jyJfvgdybKil9OzVQGtJ5LfhT9D9vb8lhqDSgMdX8KGXbbURW/
 E0PAXhcmwNHhOcsotCZYfIlmWv6TkOJdR9oNnKiPetiX5aQSs+WcycU2DkxEIlFbO4LD
 ycO2vC4xvGyR11756D9aVhM0t2+n8nupp+Qt+zF6me0JAQ8Tbm3pjX4sVe7igNscnHaI
 Uhdub26V+chOu2dRxux/3nl50e28NoS66Oyq1uWajJEgByydnKLz6xdO3OXh9KUzfVg3
 DxsjNBhW3FUwQVM7vw8UaDbraAS4OkIYwNbVg7m+WmUsk/qI6kNQCJ/0+MVTT2EBmN6N
 cH5g==
X-Gm-Message-State: AJcUukdQwIkn/VhsaBBm9DUa8KPj94vvD6ZAA2d+xmd0buTQcZ8CQmYB
 OosmRZHV2J1VKNzBMTbml7+NHw==
X-Google-Smtp-Source: ALg8bN6/AeMbB9ztw2/OPA4aRkoO7jNQPii37d8PbkqqGlfnMk8N/2tBzzZxaU1owHOurlYxWl9Q3Q==
X-Received: by 2002:a5d:6b81:: with SMTP id n1mr24066949wrx.149.1548693485628; 
 Mon, 28 Jan 2019 08:38:05 -0800 (PST)
Received: from loys-ubuntu-BY1835A49200471.thefacebook.com
 ([2620:10d:c092:180::1:d40b])
 by smtp.googlemail.com with ESMTPSA id s3sm52388982wmj.23.2019.01.28.08.38.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 28 Jan 2019 08:38:05 -0800 (PST)
From: Loys Ollivier <lollivier@baylibre.com>
To: devicetree@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v3 0/4] Add driver for Mediatek-based GNSS receivers
Date: Mon, 28 Jan 2019 17:37:57 +0100
Message-Id: <1548693481-1162-1-git-send-email-lollivier@baylibre.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_083807_297712_30BFB13A 
X-CRM114-Status: GOOD (  18.45  )
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

Hi,

This patch series adds a new GNSS driver for the Mediatek-based GNSS receivers.
These receivers transmits NMEA output sequence after boot.
Power management can be done via the main supply and optional backup supply
as defined in the device tree.

The driver has been tested using a GlobalTop pa6h chipset on a Libretech-cc
board using the expansion header. Changes made in the board device tree can
be found below for reference and testing.

Loys

Version 3 changes:
- driver: Removed "mediatek,mt3339" compatible
- driver: moved gnss_types_names string diff in the GNSS_TYPE patch
- driver: edited [patch 3/4] commit message to remove ref to vendor protocol
- driver: retained the original copyright
- dt: removed interfaces that are not available on the globaltop SoC
- dt: Added missing pins documentation
- dt: added optional properties pin names

Version 2 changes:
- driver: Renamed driver from Globaltop/gtop to Mediatek/mtk
- driver: Added "mediatek,mt3339" compatible
- dt: Renamed bindings from Globaltop to Mediatek
- dt: Moved the current-speed property as optional
- dt: removed the status line in example
- cover-letter: removed the alias that is not needed anymore

Loys Ollivier (4):
  dt-bindings: Add vendor prefix for "GlobalTop Technology, Inc."
  dt-bindings: gnss: add mediatek binding
  gnss: add mtk receiver type support
  gnss: add driver for mediatek receivers

 .../devicetree/bindings/gnss/mediatek.txt          |  37 +++++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/gnss/Kconfig                               |  13 ++
 drivers/gnss/Makefile                              |   3 +
 drivers/gnss/core.c                                |   1 +
 drivers/gnss/mtk.c                                 | 152 +++++++++++++++++++++
 include/linux/gnss.h                               |   1 +
 7 files changed, 208 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gnss/mediatek.txt
 create mode 100644 drivers/gnss/mtk.c

---
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
index 90a56af967a7..3b3d4dcc47aa 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -17,6 +17,7 @@
 
        aliases {
                serial0 = &uart_AO;
                ethernet0 = &ethmac;
        };
 
@@ -269,7 +270,20 @@
        pinctrl-names = "default";
 };
 
+/* This is brought out on the UART_A_TX (8) and UART_A_RX (10) pins: */
+&uart_A {
+       status = "okay";
+       pinctrl-0 = <&uart_a_pins>;
+       pinctrl-names = "default";
+
+       gnss {
+               compatible = "globaltop,pa6h";
+               v-bckp-supply = <&vcc_3v3>;
+               vcc-supply = <&vcc_3v3>;
+               current-speed = <9600>;
+       };
+};
+
 &usb0 {
        status = "okay";
 };

-- 
2.7.4

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
