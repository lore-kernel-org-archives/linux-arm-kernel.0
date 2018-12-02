Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C82DC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 22:09:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3304F20834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 22:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FqMMbS55";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="j6WiuGt7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3304F20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=boy3WbMMvJhzRw/0TNELSuAcT8wEN9zi2WJRu7O900k=; b=FqMMbS55yQZXYz
	OVHvsPCXyVyhyERNVlI+jrzDO1Zg114T7ITgBONlzj/Kkz+KvpscS4tJuVEyi2Ek49V6OQvrnhVsl
	mdY1MrXh16mCI7sY311XgPhAeh9avlNX1DTSzY1YZRkcdCkeVA0ZXJ4OGN5xRDNy737i2IMV4iIJx
	NEdmxxbakJWQCWL+2Ml/7FTYeEhdmlm19o+MKMYLH42bsYdNodLYLP1NjEjVHQcQbTXlaDOQV2tYL
	M0KACGX8AZkRxeMu8qB7KLwfR9NlqKK7vGC9SU7M7KWGMj3zfYCv314ux4o107CNFd82iBODmz1E3
	uwFAHuIsy7qYQ6zEchwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTZvr-0006fx-7E; Sun, 02 Dec 2018 22:09:43 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTZvJ-00065F-U8; Sun, 02 Dec 2018 22:09:11 +0000
Received: by mail-wr1-x442.google.com with SMTP id c14so10214927wrr.0;
 Sun, 02 Dec 2018 14:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DgleaoAa3YaOEy0n3Wi4meO9b+MluJgrwKrKNoAz80U=;
 b=j6WiuGt7UJEfVr0F0CcmJkQzzXhbXwy92Gni16/No+Xd5juIIKW52nXM1AVqgtpnAB
 VKWckHNApMGHJwOdGVYqI0X2rs+VdSwiO3kopG4PKZpzDg8rZERc/+oghc6pI1I/D+CZ
 DPWCkQQ3aFsXV/KqHegcexxFbvwjWZFQ7eQm3+sxv+jWanCpvmZSnHes7g9eZWcv6fYL
 hficnqjBw+EwMpOQgLxuPK1jjRSMMnbw0f3f1ZaZhkEPJymFQRQ9iN1NuVOCxczOL/9f
 GGWEykorEfDvYTK34TPyOpdr63hMf4L7SZQHFnh6aWgYHBv6D1LSnVYsW53uhoD1mvxk
 Q7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DgleaoAa3YaOEy0n3Wi4meO9b+MluJgrwKrKNoAz80U=;
 b=kcLWBdDWQ6I6xxGsKPf6cI4a7cZjE8my+d/r1rGlb/vOBewebEqwJmzIoSs7PebNLH
 EsAUQBAL7XOeEFdOqe/vRGQH0TNNOv7K9iCWMMEtBSAXCQuRpkNfUAD7B0GDEoOArSff
 KdaUwvgXN6bGgswJ+GVoj4ErLthKEaE+5/zfKHToGy7mcyd9RbC6hazw86eAaJd15zNx
 hiaNHh5vIMPd51LO0zjzuMeunYdMyBrZ7rj3L63cJU6b5qYnGl8x4a3h/iPccSeYkL9f
 5K3PTYSijMrHkA9DpQYS8SkkFrF3bcb8d/OUCH8NHUZ3pTRw3UbiUCYrIUruWpGNWgfv
 53FA==
X-Gm-Message-State: AA+aEWaRSEMKYTFDMQmhdIO4KbZDD68+UG4123wvYuKxi7b+1OMRVF2h
 cZhGrRKUHevp4vJJGjB7IU6fWMYn
X-Google-Smtp-Source: AFSGD/WI8kC7T5/dbZ8Ha3XPd5GusAFcDl1/ZlOeh7lrWul+4j8CVCJFq16Z6dMEqa83V0/a6TV4yg==
X-Received: by 2002:a5d:4512:: with SMTP id s18mr12514443wrq.182.1543788537891; 
 Sun, 02 Dec 2018 14:08:57 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD73FBA00B1CC0EB38CD20A4E.dip0.t-ipconnect.de.
 [2003:dc:d73f:ba00:b1cc:eb3:8cd2:a4e])
 by smtp.googlemail.com with ESMTPSA id m15sm8503351wrr.95.2018.12.02.14.08.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 02 Dec 2018 14:08:57 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org, linux-rtc@vger.kernel.org,
 alexandre.belloni@bootlin.com, a.zummo@towertech.it
Subject: [PATCH v5 1/2] dt-bindings: rtc: add device-tree bindings for the
 Amlogic Meson RTC
Date: Sun,  2 Dec 2018 23:08:46 +0100
Message-Id: <20181202220847.24364-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181202220847.24364-1-martin.blumenstingl@googlemail.com>
References: <20181202220847.24364-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_140909_965441_CB3B41C2 
X-CRM114-Status: GOOD (  12.06  )
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
 .../devicetree/bindings/rtc/rtc-meson.txt     | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-meson.txt

diff --git a/Documentation/devicetree/bindings/rtc/rtc-meson.txt b/Documentation/devicetree/bindings/rtc/rtc-meson.txt
new file mode 100644
index 000000000000..23df3cf2dd73
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/rtc-meson.txt
@@ -0,0 +1,32 @@
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
+Optional properties:
+- #address-cells: should be 1 to address the internal non-volatile memory
+- #address-cells: should be 1 to reference the internal non-volatile memory
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
+	};
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
