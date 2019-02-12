Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D851C282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:14:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B5C02075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sDYZ1dBH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mrPl2XTA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B5C02075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Vp9n21TVyxiGi5YBRyn15MLp9sFO++yvDbVbUnbV684=; b=sDYZ1dBHCJhXOj
	ycLe6am9eSVadEa4wA3TOLhOg6Ef35Gdowdy7pT0QV2Thjqg6yLs9WVp4gyBU8mkw4/6IfrnVVARC
	DwvwhWmuVPbQSQmz2/aaFveVgv1g4yXwcHSnZDU7DVFrxf+0CMXI+s9lTHyMl+hUHH6nNoBIRvH+J
	tX8z+sPoBDNqAbkXIrHHyGwhcdvJXj0zVOYgZrv+4P536Sl1J0z2QolRTowus6dLK4ag9/H1TZrzI
	yyI6AVyEK4X9O7zrgYM11Qf9IXwFWCTn1Krm3/jcjjshnT5S+lF1AfxEjCXsnY0I8RPAwQ1YbMAzY
	vzsbWgkuej8KjnLc2ixA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtZlj-0006oV-6x; Tue, 12 Feb 2019 15:14:43 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtZlK-0006R1-Uc
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 15:14:23 +0000
Received: by mail-wr1-x442.google.com with SMTP id t18so3101358wrx.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 07:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lEfvGeOk1usEAZ8llxjKkiOzQN+ahvtkYpFJPi6soxQ=;
 b=mrPl2XTA02ZrZOTTKOV6YbwerRpbdV9CMe3BnIq9Qfgh0nKxk5t98JZb1RtPnsYCbx
 ohG+Nv9qn+h1EYsa65ywzS6VFgoAN/ngyjBg1sB2fgIGfT8oYzm+GebourW72INdf5FJ
 oz4nk78cufgfWoZhy/mtB06VdJcg1n6ArWqQ+36geNiP3oaKcrEdT0Di13cFTH1UkC7m
 xviVkV/6Qj+37fy6ivzkYUWtD1aXC4ib3w49aWohJ3cj4pmwEW3yBKXX2igS1bmjjg2q
 4+lxqoT+8zT+rii/ST8SGKlurSxrY2PmIz7JhKUAf4oR8gBKrYW7aqY32G+jIMcV+guK
 YRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lEfvGeOk1usEAZ8llxjKkiOzQN+ahvtkYpFJPi6soxQ=;
 b=cADOtSA4LVW6auX3WOZ21qhPfTBMfi/ax9qpIWiimo1/CVwqalmrWZN28tScTjjqNQ
 G/Vych3ei0sqQPQUVs8kjUsG23O3c1Vg3T4aEp1asqIFwuBGD3dmar8dk7Q+z4PWh3EC
 QQiL/x9jPx4KocGy0QNUhhFoMNi6Tx52IwTY3ff1H/HGhABSXlhO67YzP/QdJjXJXU7u
 q/+FAXiosk23TfWyz5jEdrGbutw5kEG+Bo7tnYAU2qDSl+YWPkpGcEB3PBFquDe4VEI/
 QeNwEDWQ4D99hHsylgBtyUObR4WgBFgmBDMgV+UUmXY8X+YX/n0vfjX7YMr4dUNtv/TC
 Bq+w==
X-Gm-Message-State: AHQUAuaW9fAE+H27Zh9XhDB7WL4ytd74Xq5ezrBc9JT0E0qSzlb9nRyu
 AffllZJrgEx+arJoadzkkldt4w==
X-Google-Smtp-Source: AHgI3IYxKnd8AIHCEYlPT+DtsN2774Su5ayDJJB6gxk5G6/KEOGgxjSfhqycSOtgD5LnRxuJc++F6g==
X-Received: by 2002:adf:9123:: with SMTP id j32mr3464508wrj.122.1549984457297; 
 Tue, 12 Feb 2019 07:14:17 -0800 (PST)
Received: from bender.baylibre.local
 (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id c1sm1589515wmb.14.2019.02.12.07.14.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 12 Feb 2019 07:14:16 -0800 (PST)
From: Neil Armstrong <narmstrong@baylibre.com>
To: gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
 kishon@ti.com, devicetree@vger.kernel.org
Subject: [PATCH 1/8] dt-bindings: phy: Add Amlogic G12A USB2 PHY Bindings
Date: Tue, 12 Feb 2019 16:14:06 +0100
Message-Id: <20190212151413.24632-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212151413.24632-1-narmstrong@baylibre.com>
References: <20190212151413.24632-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_071418_989007_32B8E473 
X-CRM114-Status: GOOD (  12.22  )
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
Cc: linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add the Amlogic G12A Family USB2 OTG PHY Bindings

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../bindings/phy/meson-g12a-usb2-phy.txt      | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/meson-g12a-usb2-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/meson-g12a-usb2-phy.txt b/Documentation/devicetree/bindings/phy/meson-g12a-usb2-phy.txt
new file mode 100644
index 000000000000..a6ebc3dea159
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/meson-g12a-usb2-phy.txt
@@ -0,0 +1,22 @@
+* Amlogic G12A USB2 PHY binding
+
+Required properties:
+- compatible:	Should be "amlogic,meson-g12a-usb2-phy"
+- reg:		The base address and length of the registers
+- #phys-cells:	must be 0 (see phy-bindings.txt in this directory)
+- clocks:	a phandle to the clock of this PHY
+- clock-names:	must be "xtal"
+- resets:	a phandle to the reset line of this PHY
+- reset-names:	must be "phy"
+- phy-supply:	see phy-bindings.txt in this directory
+
+Example:
+	usb2_phy0: phy@36000 {
+		compatible = "amlogic,g12a-usb2-phy";
+		reg = <0x0 0x36000 0x0 0x2000>;
+		clocks = <&xtal>;
+		clock-names = "xtal";
+		resets = <&reset RESET_USB_PHY21>;
+		reset-names = "phy";
+		#phy-cells = <0>;
+	};
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
