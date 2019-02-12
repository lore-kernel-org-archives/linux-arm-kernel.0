Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3D1C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:15:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC18C2075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Tsm+QyPT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="oiG+7YuJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC18C2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1ZG1VBNlvHpn7U+7feVHoAOd5gOlW7JkI2p3KiiswDE=; b=Tsm+QyPT9KMiFd
	F/erTBHif/ueocnc4xBRIhtGzXm1jHCqrAj3Mtamm3pcqWpAhSwUlMl/14zjyBB7H+6NzwPxV8TjA
	bYfisKuro884adk5KhEWLpHg5pnEl2ktbi6vOP6yYV17aNKY4YwbKCYpWMvfzxHZz6+hCPQsr4koe
	YWb8tsUEwUIMiIPsHZKKI6K/tpj4RwVbv848mLJ1/Nkx9fGfRhVE2eg2mxzhrfUmf6AsikgHcVDCz
	MLLsVfjAip2kaZbuiYDjXOUttCsvCQgC5TznRwTKU6AW4bUQkFrsQdciMHHYq100fYqwyIauC4R72
	S00enTwMrPn+N8JX3U9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtZlx-000706-0W; Tue, 12 Feb 2019 15:14:57 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtZlN-0006SH-Az
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 15:14:23 +0000
Received: by mail-wr1-x442.google.com with SMTP id x10so3056329wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 07:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=osllFgvA5o/xm9OT8Xpb7DYHPsPsZmWNpK7mAFRAhF0=;
 b=oiG+7YuJqM9Wn3QW7aHUgCS/ujcmlC66yyY0L75OKfZfhEsgXZGQp2Z4Ct+qlHmU7o
 zyParsGEfi6jFKGwT1Sm58Q8qak+h9AeePeIlLvc4+/zUEXTxtjThg0H0nNvX8yxataG
 giVR/PCot2NZA0WR/p3cxQAsNVSdB5GKKOKJQeuYEDGJZPVIbqVp53nOXP2m02tiAKIQ
 PquwisJwleHTWm7npHZn++dVEVj7o/zpwlDUOAUgMPK6xA1NVUXYIYso6V/NVOB4/3i1
 dQw1UNEy0hA+owcyQXG/iWD53+HQMxaax3Y+zE+aBy3nBPyGemi/XeHehKveYrx1c6N6
 wlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=osllFgvA5o/xm9OT8Xpb7DYHPsPsZmWNpK7mAFRAhF0=;
 b=P74D7Y2sw+cryATIcNOl9euBFlv3CH+sduR/aGGtQRrF4CL+XbO2AD/fjv1xgUE/P3
 d6g62kAtY/3jf+inDehjiehVsVPAuv+98Ntl46CTgf+g3IEeRno6rN3cBbtvfRVHFR+Y
 8+lKkP4tvcTRRHtalLjRg1gLCagalmFf97VisBQTDYMqxsxEVC3CRWzblBz6iBaO7vPB
 bFucK52P2OP6fWtN5NYI2zc89JC01Hzl+1g96h46QwbKlCUtX0tLp4RjywRjZnAxuDvA
 km49eIgNSWsajbkpfAQiWhwIN08H8g/z9aP9r1phNDocYlzoubr0Ku2vOLNEUBtItV+d
 GmdA==
X-Gm-Message-State: AHQUAubgWNi5YAj2rso35EL/FhV/KgD0RdbW/juyqI/I8bnbMgUMCdCV
 AH0sKgp+AdJVC5YdY8+iqW3GoQ==
X-Google-Smtp-Source: AHgI3IbQPmshcp7UbeGIucCzLiesV8ASLETHlCcJ+rDprRG/Eot3nXohyyE/10CpSA0gb4XgHD4aoA==
X-Received: by 2002:a5d:52c3:: with SMTP id r3mr3246168wrv.163.1549984459784; 
 Tue, 12 Feb 2019 07:14:19 -0800 (PST)
Received: from bender.baylibre.local
 (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id c1sm1589515wmb.14.2019.02.12.07.14.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 12 Feb 2019 07:14:17 -0800 (PST)
From: Neil Armstrong <narmstrong@baylibre.com>
To: gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
 kishon@ti.com, devicetree@vger.kernel.org
Subject: [PATCH 2/8] dt-bindings: phy: Add Amlogic G12A USB3+PCIE Combo PHY
 Bindings
Date: Tue, 12 Feb 2019 16:14:07 +0100
Message-Id: <20190212151413.24632-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212151413.24632-1-narmstrong@baylibre.com>
References: <20190212151413.24632-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_071421_380063_4F41B7E3 
X-CRM114-Status: GOOD (  13.24  )
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

Add the Amlogic G12A Family USB3 + PCIE Combo PHY Bindings.

This PHY can provide exclusively USB3 or PCIE support on shared I/Os.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../bindings/phy/meson-g12a-usb3-pcie-phy.txt | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.txt b/Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.txt
new file mode 100644
index 000000000000..714d751091f5
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.txt
@@ -0,0 +1,25 @@
+* Amlogic G12A USB3 + PCIE Combo PHY binding
+
+Required properties:
+- compatible:	Should be "amlogic,meson-g12a-usb3-pcie-phy"
+- #phys-cells:	must be 1. The cell number is used to select the phy mode
+  as defined in <dt-bindings/phy/phy.h> between PHY_TYPE_USB3 and PHY_TYPE_PCIE
+- reg:		The base address and length of the registers
+- clocks:	a phandle to the 100MHz reference clock of this PHY
+- clock-names:	must be "ref_clk"
+- resets:	phandle to the reset lines for:
+		- the PHY control
+		- the USB3+PCIE PHY
+		- the PHY registers
+
+Example:
+	usb3_pcie_phy: phy@46000 {
+		compatible = "amlogic,g12a-usb3-pcie-phy";
+		reg = <0x0 0x46000 0x0 0x2000>;
+		clocks = <&clkc CLKID_PCIE_PLL>;
+		clock-names = "ref_clk";
+		resets = <&reset RESET_PCIE_CTRL_A>,
+			 <&reset RESET_PCIE_PHY>,
+			 <&reset RESET_PCIE_APB>;
+		#phy-cells = <1>;
+	};
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
