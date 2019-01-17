Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB04C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:54:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C3BF20856
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Fjw6MdUC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zQVadgvm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C3BF20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=ps7UtUCaKGMQF9BFUImvY3vKI+Y375VuEcJ0Qsy//Fk=; b=Fjw
	6MdUChx5FstWexdkMgKAs3mCAY2xGYpTQNgkMiimMj/OA840lqRhGyFV4KDJPkQzz3iQ/h/VODoQm
	b8EekMEImPngmhJZrhZH5UemhFYUYUyToQNasGk20fc0w3Iqy8W3GOblxJ6LHN7o4cKaPnGZCDlXE
	bi3Of1UkA8OIrM9t0JEYKK3wt8LHWtn8AqcuOukGE+s8pSVXOi4PBVO3DSrqiCc6FEQfNgKCCtXUU
	i7EajvEmfTpHk8ZL0HDpwGAh2HJcaYCwnPL0gLXm2myDeg4k+d5IK0H4EAS6HUOKrJm9wOkxuPcaa
	JdQzLpl2U4HAoWmHi4yAehLuN9ki8ew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkAwN-00029Z-1i; Thu, 17 Jan 2019 16:54:51 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkAwE-000236-Mp
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 16:54:46 +0000
Received: by mail-wm1-x342.google.com with SMTP id f188so1786333wmf.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 17 Jan 2019 08:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=guam8jHzK8TRYRb78oVM8jQvkOc1edl/EV41EjO5ZPI=;
 b=zQVadgvmWN0kg3Iw41u1o+AFKjzYiVvu5IErM0gsdf7HBWaomZcj9Cbu+DvMMXtkU2
 Gl1QkYG8Q4/CgFIzWF00/ZNjQzkxAMQ0M3s+y/mN44f1C/h+srIh4XFYFhuXCA/6jKV+
 sXOmGgi/+GJmhzh2K2RtIclu1x10IGToNgAcIiea8HYJ/czOFD+2fJB5pM15oVDssMtC
 K9Te7dX9uqcFGozw2N0XPPAvvKyhImPY7AfFWjMtZSfSPk7XnWzP+qU2uBqnowlxZcL1
 BEqc7UZI5et5DHfBR+0zPsiZR8BNXWdNYdsvWXQRvJActaOdmwmxXV2yI4/0qFdniIdY
 odlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=guam8jHzK8TRYRb78oVM8jQvkOc1edl/EV41EjO5ZPI=;
 b=kKOXBAihNd/RixXjG5LReb9Ag8kh25pm0b5yyRueS8AKueIVifV0yFy7LXjq7Jlk5W
 c63mwnJ6OBlPgD8j7tz+F+7v+FVdX+NW3AzI8cvugrngs+BzrMU7ktfwkpF+FQk4aari
 SQeAzt14PFTo0X1dAWq253/A6CZIZ3g0hBi4Og8fPF3Z+dCPOIjZUti4TZWy7ZVNwcjm
 aHzJnMbR0OtdsLYiGswBA2xLPShV86uz8OG6frHfAHvyJPVOLdwz87AR8rpiY00Z6hEc
 ACoTY++pn9WLtirk2fbeocETpzewURym/E46oNyA1tl3TfPBrdKiqYa1c8AS+FIaFDYt
 UJug==
X-Gm-Message-State: AJcUukdujthnQVem9hsnl9JpRvGv5xASpvYzSFiMzJWou8dVPHpZfVs2
 GyUNJlMBSYolhil7yOsbN3txcQ==
X-Google-Smtp-Source: ALg8bN7vrQfMtSrk/vXxv8n8yhIkmaujikkGXUBK5XR9asB5O1uN5DUXPrZjJhuNDW9uz17jVJURWw==
X-Received: by 2002:a7b:c181:: with SMTP id y1mr12732023wmi.10.1547744080858; 
 Thu, 17 Jan 2019 08:54:40 -0800 (PST)
Received: from loys-ubuntu-BY1835A49200471.thefacebook.com
 (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
 by smtp.googlemail.com with ESMTPSA id b12sm65309630wrt.17.2019.01.17.08.54.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 17 Jan 2019 08:54:39 -0800 (PST)
From: Loys Ollivier <lollivier@baylibre.com>
To: devicetree@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 0/4] Add driver for Mediatek-based GNSS receivers
Date: Thu, 17 Jan 2019 17:54:30 +0100
Message-Id: <1547744074-28308-1-git-send-email-lollivier@baylibre.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_085442_754017_B2B92311 
X-CRM114-Status: GOOD (  18.39  )
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

Sorry it took so long for the v2. Rebased that serie on 5.0-rc1 and had to send
some fixes for the board before testing.

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

 .../devicetree/bindings/gnss/mediatek.txt          |  39 ++++++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/gnss/Kconfig                               |  13 ++
 drivers/gnss/Makefile                              |   3 +
 drivers/gnss/core.c                                |   1 +
 drivers/gnss/mtk.c                                 | 153 +++++++++++++++++++++
 include/linux/gnss.h                               |   1 +
 7 files changed, 211 insertions(+)
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
