Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EA1C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:10:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8902B222BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OzE8mi3B";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="yD0DRYzs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8902B222BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=HRdvIuA7K15Z56Zg/BWZo6k7mfweJIJ9pT5m+A05yoY=; b=OzE8mi3B7yMTTNexpsmOxJjdxw
	rp34l/RgsrvuIkA5UsJ6EpaPFk+PdxaEnWcYRgqxZ/tEO8L+T1x33nyOXKfGuOx+sJbidq2gjCMj8
	DMyXv9ClrB9HsI5PE/bjK3DSIwWwY+dxU78CmkMlZs7/lRiBnAdJw/Zh1IHF47vFaSSaRvNbBo90q
	mkb63w8Wg34dxOsmwHbaous2aW6SNClpMqFAG4Z8YruPifUdhj9HoECOLILZXlsuYFSE9b0n3MWtx
	BnlvjOLDvYzeFX6B9FG29uPsw9RydmU+5mtJKl/pQP2AA5UM2S9PunqV4PhMoD2Ry36qn2R6R02Xv
	2zR48DBw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtwB3-0007Z0-Ks; Wed, 13 Feb 2019 15:10:21 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtwAS-0005f5-3t
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 15:09:46 +0000
Received: by mail-ed1-x542.google.com with SMTP id b17so2237046eds.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 07:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=RXmtNLTc175lxeTH4WR0FnsamrIEb1qNdvropbMnYQY=;
 b=yD0DRYzsVX92dlSIf/PztkWelRkLDlZHneO9ZtSuNOLLwtVOwihBQ/W9zsPLM+j7nN
 Cyv+6IIMNc0F+q4CuHWcviDrfZu3nOweZSpQou71w/SJ1PfbyevjcipIZeiTXcKEm+E5
 FUd86h5EeMHPgu1nlQTSQLJu+vrxLvis/6qepUk8Z8c7K1A/OYj+GrXCXUMbAr0c6xFL
 uorDlZUadR8X3Uw5qr+o9hCPeW5VRARVj5Hl36ROoQyrAxasp5qveLwV0hKQjIPRQn4g
 QH3VPSx4AI08iZ2hBHp5cxpFlAObQ3jl983HsK8nzNmLr/PXjdKFZ42o06TbypBc5DUd
 CSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=RXmtNLTc175lxeTH4WR0FnsamrIEb1qNdvropbMnYQY=;
 b=gIZKNEeQbIbZE8uEOK0Ac8q9nW6os6qch0ELn30kjIQorhvc/3+4Qbi+qtxeNV2USU
 wR1iGX9LybTxhCxk0A7wcx2VSoEE/TVHtTBLGKgyTFyvqfkKe+VzsZiwkYhxBPswHu43
 RozmGt9v+HRW5W0TCrpwRDdp5sFzIKnAcx7+UgSrDb2Iv7RWm+o7ImHiA0Jk0QooRIIz
 rPIX97UpSKCCYnFBekMMN5c5OnVPuzgbFpYHiP5m0/J058VOCXTHbRgYJAO0C5z5K+16
 HMsYSDbKJDjBlNiqmGoGl98zPCGi7iege+viX2CYUW2g64l/V6HLEjQZVlJM1/iJxWNg
 W8MA==
X-Gm-Message-State: AHQUAuYS9u8Ml798is4ladf4PgqyCxQpsmDIkeW6GeBypAnDw3X3Cly7
 Vt4/3pG544uUNyhQD9wwCYF1fw==
X-Google-Smtp-Source: AHgI3IYm6lK0YlhtSzkgX6CYrK6Mz5b5BmHD0nzdKeKE8+Irkx/R5nZ608RzcZTgog2SWuH7Cq9n+Q==
X-Received: by 2002:a50:b902:: with SMTP id m2mr769570ede.108.1550070582788;
 Wed, 13 Feb 2019 07:09:42 -0800 (PST)
Received: from loys-ubuntu-BY1835A49200471.thefacebook.com
 ([2620:10d:c092:180::1:4505])
 by smtp.googlemail.com with ESMTPSA id k26sm1903941ejv.63.2019.02.13.07.09.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 13 Feb 2019 07:09:42 -0800 (PST)
From: Loys Ollivier <lollivier@baylibre.com>
To: devicetree@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v4 2/4] dt-bindings: gnss: add mediatek binding
Date: Wed, 13 Feb 2019 16:09:27 +0100
Message-Id: <1550070569-18588-3-git-send-email-lollivier@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550070569-18588-1-git-send-email-lollivier@baylibre.com>
References: <1550070569-18588-1-git-send-email-lollivier@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_070944_175518_73D987BD 
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
v4:
Use standard names for reset-gpios and gnss-fix-gpios
s/an/a UART

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
index 000000000000..12283d429baa
--- /dev/null
+++ b/Documentation/devicetree/bindings/gnss/mediatek.txt
@@ -0,0 +1,37 @@
+Mediatek-based GNSS Receiver DT binding
+
+Mediatek chipsets are used in GNSS-receiver modules produced by several
+vendors and can use a UART interface.
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
+- current-speed		: Default UART baud rate
+- gnss-fix-gpios	: GPIO used to determine device position fix state
+			  (pin name: FIX, 3D_FIX)
+- reset-gpios		: GPIO used to reset the device
+  		  	  (pin name: RESET, NRESET)
+- timepulse-gpios	: Time pulse GPIO (pin name: PPS1, 1PPS)
+- v-bckp-supply		: Backup voltage regulator
+  			  (pin name: VBAT, VBACKUP)
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
