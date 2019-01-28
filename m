Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005A2C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:38:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4A1D2082C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HJ83QHhv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="RDmU414o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A1D2082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=QeZogwHe+8fiZl+TdgpAOiTepPg0V1x4Yf3nsserUMg=; b=HJ83QHhv96D0su2iPWmhFlFOPG
	Lxjlst+oMssy3I2kW+rXSZf8eOlMLbr7XpkkQsM7b7O5N5TfKhVjz27LdX6Uxfg0Aw8fa2Fl3fjEQ
	NL/zVUay0yM0SlxclqED53mrCX+p/baWr3ImaPHjqZhYFMDTW9zsffdGigkLgsQtvX9eWOX1ap22u
	YlPJxab3Iwn/w6g2mRXBo74jIoYlMSNnBQmzeYFAsmjgf0KTtHuB5F2cPRCo8LjAucSCf1O/u6xeR
	8AiRS8pu5Pk4Guv36nyp1/9fhRLRn47ucWz+SdlWuqC85v0HLy8X/AsKfSLpnvQJshwK4o634sERe
	Y+v/Z1QA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go9vt-0007GT-G1; Mon, 28 Jan 2019 16:38:49 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go9vF-0006k1-FV
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 16:38:13 +0000
Received: by mail-wr1-x441.google.com with SMTP id u4so18805089wrp.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 08:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=9TWS3RWKZyY10HyUQ8/8Pkd3n2zCGA7KyKif2utYLQk=;
 b=RDmU414oN71nkBAYiPqn/5DnY9a/u9LMT3qHlV2ydHCc9+jtKa3TZNdEJgRBEKLjco
 NI+Lb1XZrxNIUcye9zYNtrllkeaj2GBJoJI7Z/i1XARKPFGR9kWhG+lXT2jrRFEJnFXG
 fb0nNllUVAVqtLBaoWLKoW9l+FHgd0sKaMl5VY5QMFASIbkKM3vKMmKsLdNCuDCWoG46
 0AMutNJrNG1RtjHGwSWyW5Q7n5J90mjXDurK03szScyb9cpynPLrpT31fd8bU0tOTEb2
 EzYmx8T2acxvSwN8Brv/qxA6tYytvzdG1jBUYjMrnKEiND2F1CQCHlEcU9+/R2aYozSO
 qW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=9TWS3RWKZyY10HyUQ8/8Pkd3n2zCGA7KyKif2utYLQk=;
 b=I4MwTbOFFHantZnGLhGcGy/5NMl/lGeDycJd48YlMSDJ4JhTfEkFB8atCqRGdto4hU
 Z6+WD2RsclnBd7TeLhxbaNj5OoxeKKv9lEU/mgMcEsLa3WnQOHuNk5WJitauJB8hvfaM
 4nnD1fklRADSzcq6yGHlqs3dQdJ4EODOBJau4G5eDBfIP8EFUlU787wEEjGAk+dLolUe
 /8Eq9TD4f8TpW/6kbJrs3Fj6/RjhFFbyVWHSc5EZ686T66ZRGc+x0QAe3A8kDgsn3w6U
 7AJhVH/DFCQoe4n+z7iYVt1UT8axYZbCoJKTTle5nM02DkPuyQslpX4Y/LnrApG+PKeX
 woLw==
X-Gm-Message-State: AJcUukeK+rrhFJouoRKeNAQv88IFYxIh7Hg1R/nFapppHGTkdqflQu+g
 DwVRUlj35QdQr9OC7S2K7c0Kvg==
X-Google-Smtp-Source: ALg8bN4eVHINugfE+Wj5WD3XT4PnxZy5JY6koo/ABOSVBWhpinarToJm9cMVU9wRXD/OYiuX3Zt80A==
X-Received: by 2002:a5d:5182:: with SMTP id k2mr22490514wrv.121.1548693488056; 
 Mon, 28 Jan 2019 08:38:08 -0800 (PST)
Received: from loys-ubuntu-BY1835A49200471.thefacebook.com
 ([2620:10d:c092:180::1:d40b])
 by smtp.googlemail.com with ESMTPSA id s3sm52388982wmj.23.2019.01.28.08.38.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 28 Jan 2019 08:38:07 -0800 (PST)
From: Loys Ollivier <lollivier@baylibre.com>
To: devicetree@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v3 2/4] dt-bindings: gnss: add mediatek binding
Date: Mon, 28 Jan 2019 17:37:59 +0100
Message-Id: <1548693481-1162-3-git-send-email-lollivier@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548693481-1162-1-git-send-email-lollivier@baylibre.com>
References: <1548693481-1162-1-git-send-email-lollivier@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_083809_527308_ACD7EA14 
X-CRM114-Status: GOOD (  12.73  )
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

v3:
Removed the I2C and SPI interfaces references.
Removed the "mediatek,mt3339" compatible line.
Added the optional propertied (reset, fix)
Added the pin names for the optional properties.

v2:
Renamed bindings from Globaltop/gtop to Mediatek/mtk.
Moved current-speed as an optional propertie.
Removed the status line in the example.
Added "mediatek,mt3339" compatible.

 .../devicetree/bindings/gnss/mediatek.txt          | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gnss/mediatek.txt

diff --git a/Documentation/devicetree/bindings/gnss/mediatek.txt b/Documentation/devicetree/bindings/gnss/mediatek.txt
new file mode 100644
index 000000000000..00650d81c5c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/gnss/mediatek.txt
@@ -0,0 +1,37 @@
+Mediatek-based GNSS Receiver DT binding
+
+Mediatek chipsets are used in GNSS-receiver modules produced by several
+vendors and can use an UART interface.
+
+Please see Documentation/devicetree/bindings/gnss/gnss.txt for generic
+properties.
+
+Required properties:
+
+- compatible	: Must be
+
+			"globaltop,pa6h"
+
+- vcc-supply	: Main voltage regulator (pin name: VCC)
+
+Optional properties:
+
+- gtop,reset-gpios	: GPIO used to reset the device
+  			  (pin name: RESET, NRESET)
+- gtop,fix-gpios	: GPIO used to determine device position fix state
+			  (pin name: FIX, 3D_FIX)
+- timepulse-gpios	: Time pulse GPIO (pin name: PPS1, 1PPS)
+- v-bckp-supply		: Backup voltage regulator
+  			  (pin name: VBAT, VBACKUP)
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
