Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AC5C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:18:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3ECE20869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hbOvgSGD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="T4Td5UR0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3ECE20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HCB/DJQMhUyPZl8878pDhUAdeesSd1xuHbA27IeONkE=; b=hbOvgSGDKVinY7
	HQZM2NP1sTU2No9ttC3SBwmZXAfx1ZhgXXZiyPYqfoHtt0LsGan45p31T1d9VayHCrE5oFLrV2X9D
	tL7VB+KEHqE2lKJRt06Hf3AaX6PURMJkU8jv6GxqTw9f1jPNDWaMqTDj/2L/mcD/HAlAcgUOMAwdM
	Efh9aZqRtQ1JxIsRI7FIf0yY8DfR5FqXCvWDpTsHv0MjeNBp9stCtp4GEwGIxcKeqM80X5e9KhpHo
	mbsmbMAaPnLR3l33e6sto72W3726dN9IHJFsqw2wtp/GYzAazMWpcNkyvYhaJB6kC+3EpO3/I33oo
	89nVf6ge8Vk+ZNVZgQRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsGM9-000262-Ml; Sat, 09 Feb 2019 00:18:53 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsGM5-00024C-8j; Sat, 09 Feb 2019 00:18:50 +0000
Received: by mail-wm1-x342.google.com with SMTP id z5so6305076wmf.0;
 Fri, 08 Feb 2019 16:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qeQ6qFBBecGkUUWa0nrJm3Kg+BaUyaQ2/4jZF4BLOtU=;
 b=T4Td5UR0+GaEeWW1nnS6Unhh73PMGEs12YdcDlbbs+9Fcq5jj9wHkkpjSPHGk9VmxV
 BiTg0snuLvmmYc0tikXfEzZJb1gT+D5pzk4jkYPuntNDYoArfwm/QX0thCeKLcO9wblJ
 mwQrtWja6XKRtfAe7X9/YA0vAuDzQpxQd3D/GQWiVczOnssFJ8mlRsGjtJczmQ9+Y710
 +3kFGlcsK+JkLlISkSkKweAZUpVjRUsbhdg0nC3oxi4dhzCwC9hCthRuEnWOqjCbobaB
 FFknK2JSWjPc3AqWIszE+4QbTEQJ1vNmACTjiXq6q0ly80ndhd1M0I4570JXwuQ/xcIP
 ExMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qeQ6qFBBecGkUUWa0nrJm3Kg+BaUyaQ2/4jZF4BLOtU=;
 b=MKQvNsZ70Eqf+at6GXyhlDyCUig4VJkF+TGl+V9oAk4uAw2r0sq8KlUvN4haZEEMsE
 89w6Ep7PDjjmt57LM7u+gqtBIP+dbC4Lqp6AY/A75gg4Y2vz1yUWPAhfDkIYSlqBJHT8
 GHf1xFqWIiQ1lzncJN6KR/Bd1hYVQaMsRY5rCdgUnYoui2Snyb1kQvAVCKDRg05ChR2c
 0tyE58Z4EY6/CmNMC0o8k6QSxEZ/Guatyp0LRCEd9KCCHayzOY+mcG0mgt/EmXN0XmGy
 lcktDrBcsjvmZ1/TMK8Ighe15VBL0/ZNv30FmGLTlz4zgFpgHqCw43kPYdG0Rgx6SV6b
 weag==
X-Gm-Message-State: AHQUAubco783jbQAs+Q89McvbwWErjGS78K2kXPZFXbXyDLF3JvSPbia
 ZCTRGYOVcAL++mMV5VfCrZwv5U0F
X-Google-Smtp-Source: AHgI3IYUcSNAlybaGXTRUz+mJ9/8hxVON182aTFHSXwPOvWNZKbXZGq6d+fe6lmC60vpgAH3C1oONQ==
X-Received: by 2002:a5d:4dc8:: with SMTP id f8mr19174849wru.45.1549671525604; 
 Fri, 08 Feb 2019 16:18:45 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD70B4600C545FEF64E1C6C81.dip0.t-ipconnect.de.
 [2003:dc:d70b:4600:c545:fef6:4e1c:6c81])
 by smtp.googlemail.com with ESMTPSA id b12sm2168162wmj.3.2019.02.08.16.18.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 Feb 2019 16:18:44 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org, linux-rtc@vger.kernel.org,
 alexandre.belloni@bootlin.com, a.zummo@towertech.it
Subject: [PATCH v7 1/2] dt-bindings: rtc: add device-tree bindings for the
 Amlogic Meson RTC
Date: Sat,  9 Feb 2019 01:18:12 +0100
Message-Id: <20190209001813.6792-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190209001813.6792-1-martin.blumenstingl@googlemail.com>
References: <20190209001813.6792-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_161849_311137_4F78CB0C 
X-CRM114-Status: GOOD (  12.27  )
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
 ben.dooks@codethink.co.uk, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, ccaione@baylibre.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The 32-bit Amlogic Meson SoCs (Meson6, Meson8, Meson8b and Meson8m2)
have a built-in RTC block.
It has the following inputs:
- an 32.768kHz crystal oscillator
- an interrupt line
- a reset line
- 0.9V voltage input

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
[resurrected patches from Ben after 2 years]
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../devicetree/bindings/rtc/rtc-meson.txt     | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-meson.txt

diff --git a/Documentation/devicetree/bindings/rtc/rtc-meson.txt b/Documentation/devicetree/bindings/rtc/rtc-meson.txt
new file mode 100644
index 000000000000..e921fe66a362
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/rtc-meson.txt
@@ -0,0 +1,35 @@
+* Amlogic Meson6, Meson8, Meson8b and Meson8m2 RTC
+
+Required properties:
+- compatible: should be one of the following describing the hardware:
+	* "amlogic,meson6-rtc"
+	* "amlogic,meson8-rtc"
+	* "amlogic,meson8b-rtc"
+	* "amlogic,meson8m2-rtc"
+
+- reg: physical register space for the controller's memory mapped registers.
+- interrupts: the interrupt line of the RTC block.
+- clocks: reference to the external 32.768kHz crystal oscillator.
+- vdd-supply: reference to the power supply of the RTC block.
+- resets: reset controller reference to allow reset of the controller
+
+Optional properties for the battery-backed non-volatile memory:
+- #address-cells: should be 1 to address the battery-backed non-volatile memory
+- #size-cells: should be 1 to reference the battery-backed non-volatile memory
+
+Optional child nodes:
+- see ../nvmem/nvmem.txt
+
+Example:
+
+	rtc: rtc@740 {
+		compatible = "amlogic,meson6-rtc";
+		reg = <0x740 0x14>;
+		interrupts = <GIC_SPI 72 IRQ_TYPE_EDGE_RISING>;
+		clocks = <&rtc32k_xtal>;
+		vdd-supply = <&rtc_vdd>;
+		resets = <&reset RESET_RTC>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
