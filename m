Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B9FC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:56:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49359218E2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="arjpyObB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="JapAZBaI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49359218E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9dAzzd8YQKeO5Rqo4EtcsgVAgAwUalGv258rjcFwB8U=; b=arjpyObB0iSB7D
	hw/iQRuGLxspZx5GG3dVbaMQ2rRwDXOWNJCzrW29gzvUWAe1qDbCv6jecXNLVZqZztJrAotFtjHrA
	+bZ9Foqee2oq2phdIjfyHvV9moONKw2X0U0z36j9Md77Y+aWamCNFw1WjqA6TeJV3isCb/ykTbLv7
	NMBK6QTT3mmQe+wPl/ALTpmozwzyseHu6EKutsofzSD2ahqjNhaN/sSXdT1xPfFPsSrT7+i/EQrbK
	5ezqFXE7rHYBY0BjfWlXP9cLRwNAxQWhKVt++XU2se+2lwIzV9Cyta8HTV8nYeoT60SZuAtWuux6D
	SbEw4IIu0vVXcYujEbew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn12E-0005W6-Ad; Fri, 25 Jan 2019 12:56:38 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn11J-0004kG-Aj
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 12:55:43 +0000
Received: by mail-wr1-x444.google.com with SMTP id r10so10163206wrs.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 04:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3k61Ao1miI2EQ8vy+O8E8azA+vtcQWlgksY/Dfn7Fn8=;
 b=JapAZBaIn6B6Zv64DK6hIhfRCHVdi88S40p534kpWpGAGDcu96q4lAF0WMI4GBAm+W
 iOFwvTaRuvKIOAwPV8cF9tKDWwp3lr0ihuplcbacxw4a415jFoJvdnIjVGPgAXb0ANF0
 +aKAUfgMgQUVw0RVjNkpB8dLwai9gmCxDPU3JSQwnnL4bgW3b0KruvhK6RlCqRkNrNl5
 EgGWFkB0O0ZE0/tITtenZs7pMy18sHtKTSR6v3KstUz1Iq8MIsJrWnqm/1Y1ou4QLj8D
 Q8Juh8+6wn+Q6xwvV28KAYWiRlASiHh6hD6WK8WYI7jj9DUSI0IiKSvZ3FbESV4uA1I2
 N1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3k61Ao1miI2EQ8vy+O8E8azA+vtcQWlgksY/Dfn7Fn8=;
 b=IGb7O0AQHd3F3xLYQX9Baap96C98DuOIYvIPNIjayDIKR1lr+oa5QTNLxFZJ5VGRuN
 XkTY/6RXcTp7aBMOQgTjIMAhIRtaMcgK7sb/1zyKwReZflutmpX3on2tkSG1MfrRf1NE
 AMysDiTBWlWkVQngnyGL7kI0J0tri5r+l3TeX9KqsQ+pCv/Qu/oYKhD82sgZdSGQ9pHZ
 pheiwPIvKcuAURRin532T9NBfLHFlja+CCQ16C8aY/MdvNX4cL3eo+NRGKMMAxH7KPIu
 3F5x6gcW4EeQXDas9U2c0B2XK8Q11oapOZF+YUyYlsekP9yeM3YM+BHLUAu/JfvQ1YC9
 51RA==
X-Gm-Message-State: AJcUukc0W6k6kObhSKYZ35iCo6qy8ThQHUIuXP+NWtFkVnlIT8RgCDtW
 yWMSWQWtxzpepCV+BpxWuDxArw==
X-Google-Smtp-Source: ALg8bN4Y84oXixS5OGbuKZjLv0fhO4VowJLWYUIceBSzUukWLP61xaL6oIkNb3Gt6oTgWLb0/jzCQQ==
X-Received: by 2002:adf:db01:: with SMTP id s1mr11120447wri.214.1548420939265; 
 Fri, 25 Jan 2019 04:55:39 -0800 (PST)
Received: from xps.expressvpn ([2a00:23c4:f7a1:ce00:5105:4b7b:c922:7c6])
 by smtp.gmail.com with ESMTPSA id w80sm93057860wme.38.2019.01.25.04.55.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Jan 2019 04:55:38 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
To: andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
 robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, fabio.estevam@nxp.com, linux-imx@nxp.com,
 mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, aisheng.dong@nxp.com, abailon@baylibre.com
Subject: [PATCH 2/3] dt-bindings: net: at803x: Document at803x,
 smarteee-disabled property
Date: Fri, 25 Jan 2019 12:55:12 +0000
Message-Id: <20190125125513.23656-3-ccaione@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190125125513.23656-1-ccaione@baylibre.com>
References: <20190125125513.23656-1-ccaione@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_045541_364025_01BA499A 
X-CRM114-Status: GOOD (  11.32  )
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
Cc: Carlo Caione <ccaione@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SmartEEE is a proprietary protocol that allows legacy MAC/SoC devices
without 802.3az support to function as a complete 802.3az system.

This is know to cause issues so a new property is added to optionally
disable this feature.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 .../devicetree/bindings/net/at803x.txt         | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/at803x.txt

diff --git a/Documentation/devicetree/bindings/net/at803x.txt b/Documentation/devicetree/bindings/net/at803x.txt
new file mode 100644
index 000000000000..931cb34534fb
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/at803x.txt
@@ -0,0 +1,18 @@
+* Atheros AR803x Integrated 10/100/1000 Mbps Ethernet Transceiver
+
+Required properties:
+	- reg - The ID number for the phy, usually a small integer
+
+Optional property:
+	- at803x,smarteee-disabled: Disable SmartEEE feature
+
+Example:
+
+	ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+		at803x,smarteee-disabled
+	};
+
+Datasheet can be found:
+https://media.digikey.com/pdf/Data%20Sheets/CSR%20PDFs/AR8031_DS_(Atheros)_Rev1.0_Aug2011.pdf
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
