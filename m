Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5D3C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:05:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D12D62081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dyzEdtUb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zJ5eI3rx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D12D62081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GmfYqO73au4TyLKJcZjDnCf73Z1oZZDemDGw8UoWrko=; b=dyzEdtUbfvsYfl
	rrmSqnkKaAapmYhaWKcWOowToq1iLReFSAdToq+mRlhI+NCbJDbwFoutQi9Hf+P8shPmIx1ut+///
	WUDAZf8VJUxabcZ0eFFe39pldqtXFGs8o6uM0/7vQ6bnS6LxR5raouT/0eM8ivTDWEZuRqo6cAasg
	CKCYN3HEbZKLWL9hUxmddEP4gTu//rRnLP7havnNJRQHfdYeKnGSH15gx4b2fRS+lbmejovawZXr0
	iMm6NOJ1gBm+tASE5FrbqHcDrAVCojhMyDBxvSydLQ8VmYPfUql14kVXrPAlZutbyaUTHYV6V5TP9
	RGPVwdQrhO7S94nCPZNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUDCP-0005RB-Mm; Tue, 04 Dec 2018 16:05:25 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUDCC-00048I-78
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 16:05:15 +0000
Received: by mail-wm1-x343.google.com with SMTP id c126so9872718wmh.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 08:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XN+iJU0/cAep1Wwr8rSwA7W/c+XOn4BhI5wEkNhsKjg=;
 b=zJ5eI3rx0SUgklcxvQrXD3m4sQq8GF+beKgqPUlYnNk3jl6JFtR4nf7dkBjJo0KpAX
 /IR9eo3OwmGy9NLuo0cZflGMAeQILAaROlZke2fYbxfoWEKXOL5khVA/V/bMQQ1rWzG7
 zSWIG77moVBU0HUKMvfjyvIJ5cOkHkrjhGqaUZGXnALJVCVuoPTxhmOo3XSXhkMsGzlf
 1Drow7uQCAgOLcPRvCrjc3FmcjlniXc8qwJaL25egb8/6xnbEcfMl+A9af0zioIBjzAA
 RO97P56f86aRwAzBorgjW/z2xIIBMGN3itL/5B2wCZNbmKwtYzFm0S5M9FTAsDKcyXYi
 CX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XN+iJU0/cAep1Wwr8rSwA7W/c+XOn4BhI5wEkNhsKjg=;
 b=R1KAK/JUI/be9L2lfhLH7HJ4DX0pzuMkr6XGl1IEGQlHsVxE08UawbqLpa024qBM++
 FTRB78gRH27fA+tLRAJAvVhcMUhQs8xRLdCfkRo6uTYm3NVvq07S49byeSViSQ2v/Uz0
 j/Nbhb4Bj+S6+3MmxIH/dUmvrtTqKFD7LicDqljBxyDIgjzKwKH3ts8YRo/KRCU8S1iM
 h6DIpUolzoohLmO/TEuMULrbXC1vqmsUI/WgKmQnROIlZtrTxoxNwMuJZ2+aZuCJfZNf
 wMqE5fC3CuS01EJkgCIyrVmygEXsrXMmV6xnOjiO7K/+4icW6I1AvlcVSLaKDv/+sCol
 g0vQ==
X-Gm-Message-State: AA+aEWavkg0v9IlZrIR5Wt1oyOhrCn4ValwaUxNnF/XXHclH2RD+xayp
 rZe1QC/0wNsfLq9FNWOt00uJoQ==
X-Google-Smtp-Source: AFSGD/VDnRmD9tZaMfcMHfQmULBbSBzmLutQk6a3gXNGow2nvW33S0EV/vgmiQlWbbtNdXb0S11ItQ==
X-Received: by 2002:a1c:2e0c:: with SMTP id u12mr12964703wmu.81.1543939501699; 
 Tue, 04 Dec 2018 08:05:01 -0800 (PST)
Received: from xps.expressvpn ([2a00:23c4:f7a1:ce00:1581:6f5a:196:51f2])
 by smtp.gmail.com with ESMTPSA id k23sm5451585wmj.32.2018.12.04.08.05.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Dec 2018 08:05:00 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
To: robh+dt@kernel.org, mark.rutland@arm.com, khilman@baylibre.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, martin.blumenstingl@googlemail.com
Subject: [PATCH 2/2] arm64: dts: meson: Remove eee-broken-1000t quirk
Date: Tue,  4 Dec 2018 16:04:47 +0000
Message-Id: <20181204160447.27869-3-ccaione@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181204160447.27869-1-ccaione@baylibre.com>
References: <20181204160447.27869-1-ccaione@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_080512_271741_318CAB9B 
X-CRM114-Status: GOOD (  11.78  )
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

The change in the macirq IRQ type also solved another long standing
issue affecting this SoC/PHY where EEE was causing the network
connection to die after stressing it with iperf3 (even though much
sooner). It's now possible to remove the 'eee-broken-1000t' quirk as
well.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/boot/dts/meson8b-odroidc1.dts              | 1 -
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts      | 1 -
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 1 -
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi   | 1 -
 4 files changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index 58669abda259..a951a6632d0c 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -221,7 +221,6 @@
 		/* Realtek RTL8211F (0x001cc916) */
 		eth_phy: ethernet-phy@0 {
 			reg = <0>;
-			eee-broken-1000t;
 			interrupt-parent = <&gpio_intc>;
 			/* GPIOH_3 */
 			interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index 18778ada7bd3..4d57363ac536 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -357,7 +357,6 @@
 		eth_phy0: ethernet-phy@0 {
 			/* Realtek RTL8211F (0x001cc916) */
 			reg = <0>;
-			eee-broken-1000t;
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 54954b314a45..f8d1cedbe600 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -143,7 +143,6 @@
 			interrupt-parent = <&gpio_intc>;
 			/* MAC_INTR on GPIOZ_15 */
 			interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
-			eee-broken-1000t;
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
index 70325b273bd2..ec09bb5792b7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
@@ -142,7 +142,6 @@
 		eth_phy0: ethernet-phy@0 {
 			/* Realtek RTL8211F (0x001cc916) */
 			reg = <0>;
-			eee-broken-1000t;
 		};
 	};
 };
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
