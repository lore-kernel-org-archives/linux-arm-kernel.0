Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F79C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:55:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 497F2217D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SGxMpzek";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KICK/X8S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 497F2217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pH+ERL0i77mhlWw53DNeCCokC2KT5y22yqNU/DLlWYM=; b=SGxMpzekPzHJOR
	dZxA7cSYN/Wj9uBXlDa5V0J/RlYPdJ/cydwfmA+zwAzTevLEvF2Iu1yB9PSJZtvP0VVyTURLd8/AE
	KOYkMu+xfucw+rge7rXwNbTff2SZlqyqGFy2QM4kuzLgmmGn/tlIDw/wMLchUx7H6WZ8IDVf5eU1v
	qpPhbWWvMg79gtNoGvAfxzKlFSLmqLZ7wtk6/5qtjOAz/vxzGvNztdBDHH2h1HJd1tSBap21N9P8k
	WKELgipvQ5BxOLrCtL7bMk2/k3zavnN8+qtrgeURFI8A74LHfikJSCtDEyGgXNsmsBiLYWTkWGlex
	2JrrQf67kCBb0YKx61EQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsWqD-0004wz-82; Sat, 09 Feb 2019 17:55:01 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsWpv-0004ee-0C; Sat, 09 Feb 2019 17:54:46 +0000
Received: by mail-pf1-x429.google.com with SMTP id q1so3176488pfi.5;
 Sat, 09 Feb 2019 09:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ew5KCp9S0Z6DBIvhUEHStvGXQAKwpVHRwk681PRNWXo=;
 b=KICK/X8SxNbHrpxBhU+/6dLCu81zk2xTKuzYmIIQXdocAQoW/YWfqO+8MI9KtAV+II
 f4t5xcV/Am/6gLCu4PCvpXHfyVwZlpDqFT/AX3SH990cAQ7iUmIZEy1fHoJ/1vhg5AAB
 7pvBW5yaa3it5n3YASHB/JPUGGvXaSTsj1TJvbzla3MKdOuCHZQWRxIwPdu7TVg3PSfW
 vGb6HSVW96LdALKPrIAAGhUe9gLpUKLTRFkxlJPtFHcG4x4B/khSOIpOuHzDDbDxFgDj
 2rJtuM5xPnnAADeqWce++9TVjdybk8/R3rWzT/ydYLr53R9d3gpLs86wtussVhR+DhCE
 ZeEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ew5KCp9S0Z6DBIvhUEHStvGXQAKwpVHRwk681PRNWXo=;
 b=dl8B1wmCdeGq4YTNTxalGC14hooe44QjRkgJbTnngSytt6ex/uuREmRkJ66IV4xUqI
 ElGIsEY11I1M9QV0wKMZ04jvRb1lBEdhxLD7/Fx9VkdF7mKvuDtMa37MF3WfdLfzpNIr
 J58QyL+vOJQIH02o4qQOHsaEhP5SaG8lt9F5s6t9s1oy6ipbMob/0gw6njUcswwq2WMW
 Au1L66vTwahoTUNOLEr6vPqHwp0A8Ck0rFCrOyWNJwlUMPjgDUqyyTr0ZpjcYnKg6peH
 6qdW++6M3GNwFlRQ45KSmlJkVPAgwgQacHnlCftj556f7MERtWSYe3pPyl/hvLrWW08P
 r5wQ==
X-Gm-Message-State: AHQUAuZvlfln9tRPyCQ/gRA8JanWus6+w9iuK4RB3GUDbSPE/4G2Qdyo
 6rN1WVUDSy4p/awz+x4dhO4=
X-Google-Smtp-Source: AHgI3IZE4lW+6xQafgF+0weaZKBM+Zaw4czPRxJry9nNZWTe6zCieAfXjo9j9BCKf2yxfaAJWeYQGA==
X-Received: by 2002:a62:9fcf:: with SMTP id v76mr28361157pfk.144.1549734882053; 
 Sat, 09 Feb 2019 09:54:42 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.181])
 by smtp.gmail.com with ESMTPSA id e9sm26359780pfh.42.2019.02.09.09.54.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 09 Feb 2019 09:54:41 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org
Subject: [PATCHv2 1/1] ARM: dts: meson8b: odroidc1: fix USB power supplies for
 phy
Date: Sat,  9 Feb 2019 17:54:28 +0000
Message-Id: <20190209175428.1199-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190209175428.1199-1-linux.amoon@gmail.com>
References: <20190209175428.1199-1-linux.amoon@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190209_095443_345253_7A270482 
X-CRM114-Status: GOOD (  10.20  )
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
 Kevin Hilman <khilman@baylibre.com>, Rob Herring <robh+dt@kernel.org>,
 Neil Armstrong <narmstrong@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From the shematics GPIOAO.BIT5 gpio input for the PWREN signal of the
USB_HOST controller (usb1), add missing phy-supply link for USB1 phy
controller this changes fixed the power issue on usb ports.
Changes help fix usb reset warning.

[   59.693078] usb 1-1.3: reset high-speed USB device number 6 using dwc2
[   62.703039] usb 1-1.3: reset high-speed USB device number 6 using dwc2
[   65.693073] usb 1-1.3: reset high-speed USB device number 6 using dwc2
[   68.703030] usb 1-1.3: reset high-speed USB device number 6 using dwc2
[   72.080440] usb 1-1.3: USB disconnect, device number 6

Fixes: 2eb79a4d15ff ("ARM: dts: meson: enabling the USB Host controller on Odroid-C1/C1+ board")
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 regulator                      use open bypass  opmode voltage current     min     max
---------------------------------------------------------------------------------------
 regulator-dummy                  4    3      0 unknown     0mV     0mA     0mV     0mV
    c90c0000.usb                  1                                 0mA     0mV     0mV
    c90c0000.usb                  1                                 0mA     0mV     0mV
    VCCK                          1    1      0 unknown   860mV     0mA   860mV  1140mV
       cpu0                       0                                 0mA   860mV   860mV
 P5V0                             3    4      0 unknown  5000mV     0mA  5000mV  5000mV
    VCC1V8                        1    1      0 unknown  1800mV     0mA  1800mV  1800mV
       c1108680.adc               1                                 0mA     0mV     0mV
    VCC3V3                        1    2      0 unknown  3300mV     0mA  3300mV  3300mV
       VDD_RTC                    0    0      0 unknown   900mV     0mA   900mV   900mV
       TFLASH_VDD                 1    1      0 unknown  3300mV     0mA  3300mV  3300mV
          c1108c20.mmc:slot@1     1                                 0mA  3300mV  3400mV
    DDR_VDDC                      0    0      0 unknown  1500mV     0mA  1500mV  1500mV
    USB_VBUS                      2    1      0 unknown  5000mV     0mA  5000mV  5000mV
       phy-c1108820.phy.0         2                                 0mA     0mV     0mV
---
 arch/arm/boot/dts/meson8b-odroidc1.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index 0f0a46ddf3ff..00f2bb1a68f4 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -83,6 +83,20 @@
 		regulator-max-microvolt = <5000000>;
 	};
 
+	usb_vbus: regulator-usb-vbus {
+		compatible = "regulator-fixed";
+
+		regulator-name = "USB_VBUS";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		/*
+		 * signal name from schematics: PWREN
+		 */
+		gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply = <&p5v0>;
+	};
+
 	tflash_vdd: regulator-tflash_vdd {
 		/*
 		 * signal name from schematics: TFLASH_VDD_EN
@@ -295,6 +309,7 @@
 
 &usb1_phy {
 	status = "okay";
+	phy-supply = <&usb_vbus>;
 };
 
 &usb1 {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
