Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7380C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:07:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 759942081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ibJShQ/c";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qnmlEEqD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 759942081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dmlQ2UX8h3GU4aC8wRLIV/jt6T3Ry5maU7IGNdbPPGA=; b=ibJShQ/cYHMqZ/
	XkUj4FLvJzW/eD4ZbDOuTbEkfPg/u7GmyUWG5Qy/4Aib/6R7FH2LGiXuiLLrqxkGMM4LTnlBzxBKH
	alXlUv96hF2V5Q8vizNEkztDgwD78GAq+5j59qS5Jr87/Ygk2cXc/ejfkZ5jcr81/F1NN2sVk9HSq
	h7U35oCQKkGyk+mUCNIiY80DCziBbfvmjfNmCLxJWiZlSD60fGNhCB4boVZcj1hQyZoTSdCYmh8uL
	7cEJGUm8SFom6cun1kTNdFTzRxBU3gHT9VbGSYO+K4s9SK+yQZa5ArJY/qd6BPvAGuzGJtD5kOTa8
	yWIghKVDv++BKcOw3wzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWHX2-0000Sg-QS; Mon, 10 Dec 2018 09:07:16 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWHWn-0000EQ-9x
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 09:07:02 +0000
Received: by mail-wm1-x342.google.com with SMTP id a18so10369586wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 01:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=J/iFO9ro52MfQgXBg7sbtK9Q+GjTD65WMy8mc1LZAJI=;
 b=qnmlEEqDy9HdDvus57/G5BdLOXqj6Tt/3om5CgcTwvfsYh0W7xG0wjdTfCFqu2wtjN
 M+zxoyBJS5trVxIpGjE4LyQkNkxP8MvsS1QDP8aJ5xRfwFJ4M1GkGBC4at+c/0qHVyDM
 GDMiTgSm4lXk0wXEIzFClHj9jsnc/Wl9wDaqYyqhEr7f1EMkxWLx41mbofewNeuajK/g
 KKdU/xH5Tw/uzK8akj+mw1ZXhx1yrQZKHz41i/8kNvSYtc1SDN0lc24hlN0UKM18j76h
 zSfTxs271Pkjs5iNIpZJvdAprAxyKNj/ZfTXdkWN2MsFLGvAOVPeCtNxa61i9/to96q1
 TVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=J/iFO9ro52MfQgXBg7sbtK9Q+GjTD65WMy8mc1LZAJI=;
 b=sSLPKuYoKfqd7eLrKR80rzjtcMWs1kFVJkX35OEwqko6cDvRDeYyu4uajK9zN1wFgB
 HlhST2myNpuxKIuE267YRBK8iguQpCKDwpjv0unKGsVXi9gxFwTmm1WrFLM8/cDZEqC0
 BnCLid06oN7u0PQYomZzadVmxMLxEYkETjhluYQ9yhUkb38v69LGTEu4edZQOqO8px1B
 jslRG1kqOZ3hJSUKcdc25CIdh9KOFsNBDPlM/McluauHXALVcZKlbnq/4xKUBi8hj/Ic
 jRDm2KBgMdKLLKV+OIPoyBm46ilbKhNmt6zIw0yzl1YbgHI/EFIREpD1fZ2cX2gN+WgG
 ZcIA==
X-Gm-Message-State: AA+aEWazt2HVj14/MgUn72DDcyIOsLEVnv6G5DwzV1YJDiVdF82iNXSH
 JshNh7sGLfvaCXJnJVnGFTH3AA==
X-Google-Smtp-Source: AFSGD/VusClaUcF5HcoQLnPCwhOSfRe01bWinz30a94mxKWWkzNEdw189dXQLbo85UBX8ST5A7L8uA==
X-Received: by 2002:a1c:1550:: with SMTP id 77mr10459677wmv.100.1544432809836; 
 Mon, 10 Dec 2018 01:06:49 -0800 (PST)
Received: from localhost.localdomain (abo-99-183-68.mtp.modulonet.fr.
 [85.68.183.99])
 by smtp.gmail.com with ESMTPSA id 14sm15856555wmv.36.2018.12.10.01.06.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 01:06:49 -0800 (PST)
From: Maxime Jourdan <mjourdan@baylibre.com>
To: Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 2/2] arm64: dts: meson-gx: add support for simplefb
Date: Mon, 10 Dec 2018 10:06:40 +0100
Message-Id: <20181210090640.4495-2-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181210090640.4495-1-mjourdan@baylibre.com>
References: <20181210090640.4495-1-mjourdan@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_010701_347685_F472131A 
X-CRM114-Status: GOOD (  12.82  )
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
Cc: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SimpleFB allows transferring a framebuffer from the firmware/bootloader
to the kernel, while making sure the related clocks and power supplies
stay enabled.

Add nodes for CVBS and HDMI Simple Framebuffers.

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 25 +++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 25 +++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 1ade7e486828..4bc7dd5ba141 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -13,6 +13,31 @@
 / {
 	compatible = "amlogic,meson-gxbb";
 
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		framebuffer@0 {
+			compatible = "amlogic,simple-framebuffer",
+				     "simple-framebuffer";
+			amlogic,pipeline = "vpu-cvbs";
+			power-domains = <&pwrc_vpu>;
+			status = "disabled";
+		};
+
+		framebuffer@1 {
+			compatible = "amlogic,simple-framebuffer",
+				     "simple-framebuffer";
+			amlogic,pipeline = "vpu-hdmi";
+			clocks = <&clkc CLKID_HDMI_PCLK>,
+				 <&clkc CLKID_CLK81>,
+				 <&clkc CLKID_GCLK_VENCI_INT0>;
+			power-domains = <&pwrc_vpu>;
+			status = "disabled";
+		};
+	};
+
 	soc {
 		usb0_phy: phy@c0000000 {
 			compatible = "amlogic,meson-gxbb-usb2-phy";
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 8f0bb3c44bd6..f7ef8e0cf96e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -13,6 +13,31 @@
 / {
 	compatible = "amlogic,meson-gxl";
 
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		framebuffer@0 {
+			compatible = "amlogic,simple-framebuffer",
+				     "simple-framebuffer";
+			amlogic,pipeline = "vpu-cvbs";
+			power-domains = <&pwrc_vpu>;
+			status = "disabled";
+		};
+
+		framebuffer@1 {
+			compatible = "amlogic,simple-framebuffer",
+				     "simple-framebuffer";
+			amlogic,pipeline = "vpu-hdmi";
+			clocks = <&clkc CLKID_HDMI_PCLK>,
+				 <&clkc CLKID_CLK81>,
+				 <&clkc CLKID_GCLK_VENCI_INT0>;
+			power-domains = <&pwrc_vpu>;
+			status = "disabled";
+		};
+	};
+
 	soc {
 		usb0: usb@c9000000 {
 			status = "disabled";
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
