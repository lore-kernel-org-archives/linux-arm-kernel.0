Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B138C5AE5E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:54:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BA3A20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eHncF6vy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="MrkxwyVu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA3A20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TL4fnsXDoFLnBMcLyb1lKKHd4Pj2k09XFVxtXJy+JCs=; b=eHncF6vyzWu7IB
	kbajYFlPWPBy1VekrwmSyLAIIVurrVw0DdP4ssEBUPv/+YcdIK46fPwiE2wEtKNtaUJRLFwHd3Pf/
	7e+KVgwVTlFCdV3uOec8RFbgBdOhrDxpYED2BuIYpYoOFTD1IXrRwbV8mXeMFnz5MXBSI/m38/mRb
	0bGy6Ognu5SpSvoPSl/IAGaZ1CAGKSK2gI2Osjoox/VXaGxKt6WMNX1+Ka45lpQzyUOYGwvi42OH7
	z5lFvGgCJ/Re3IFCOoJpgBnZ5hoqS6d9+ckjlkpNNg/1Vg/c61i5c4IBZrpXEqRtMHEuenrvvzsL/
	UCw+H1M7rYsFmT0hYEZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkd2L-0002T1-4u; Fri, 18 Jan 2019 22:54:53 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkd0X-0000o5-IF; Fri, 18 Jan 2019 22:53:02 +0000
Received: by mail-wm1-x342.google.com with SMTP id y185so1968960wmd.1;
 Fri, 18 Jan 2019 14:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5llSdIDYBFr0D2hZn/CaNdENBIdD2RMZQMIhtJVQII8=;
 b=MrkxwyVuM/VrYzj6MfmBklx7MzwFAEQIs1gfYfaA6tn4rJHOfg9APHhUL46whRp2BC
 3fZt86+ZfVuhgbl9vUwcY7EMNCbqezFJA3J5CmtT7x1Ywa/ayOht8NXh2J5eSJhdtaCd
 KK0iWHaent6ROazwLewuC8vn+naTUfYaooWXan86ZYkvFHW1c6KUz64EMly2tUi3CwF9
 WsfKvNvy4oV0r/Hc/cnrWE8pNvp7OqIy5b7FfJYXiisBeQKF/lF0Na3SL8Ge4/pEPaAR
 JUVRTpyz0XI8FswEM64kNLXuKQtTH6XCyYp5NItNpTGB0SKuw3IZDdJMe3UG9GcWzZs1
 oVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5llSdIDYBFr0D2hZn/CaNdENBIdD2RMZQMIhtJVQII8=;
 b=knGfEVu4kCtvsyS0L7PRufrrFkLit8aYsBwtptUeYjwe9uxaKHQ5xLXbNLL0XQHxvM
 ClIWJCYlyjWS+2I1cvuaQvBwllFISVpeWbt59BMthW84l9imETEMBgMJfhqVpaeXqUBr
 Ap0Y9Eq71EyKJxCTkeOMNqAvI3OZiPuk/XfnvI89vLemn6JOKmDBqM5G9Lj0toHJotf9
 /QQuN+qv8g6EwwK0yvv25K+rPC5IxCnpKKj7bursPofJTB/HDVv40BuQ4rKpAh/wyglw
 nSa3xxBz9xnjmmKFaufsRJLEbZfHbIEpbvBQmudoDOlXu/lfxR5IOxCz/FNNSM96Ec3a
 nklg==
X-Gm-Message-State: AJcUukcmZ/8Fj9tPl7l8e+TEH2Ek/jB/1klET+bKKjiheWQY6dVzNNtB
 K8MOBqWtGCEy6IW2amKsXUev42Fu
X-Google-Smtp-Source: ALg8bN6eJLlKs2a/VmCQZuefCkTrGEhlPszBp6t/Hjlia6Y1TZYYAmxKHbB50kFASV1Men1u1VOmvQ==
X-Received: by 2002:a1c:ac85:: with SMTP id v127mr15414023wme.62.1547851979902; 
 Fri, 18 Jan 2019 14:52:59 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD73A810039E290CB771389D7.dip0.t-ipconnect.de.
 [2003:dc:d73a:8100:39e2:90cb:7713:89d7])
 by smtp.googlemail.com with ESMTPSA id
 x186sm51197352wmg.41.2019.01.18.14.52.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 14:52:59 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	khilman@baylibre.com
Subject: [PATCH v2 3/7] ARM: dts: meson8: add the temperature calibration data
 for the SAR ADC
Date: Fri, 18 Jan 2019 23:52:23 +0100
Message-Id: <20190118225227.6516-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118225227.6516-1-martin.blumenstingl@googlemail.com>
References: <20190118225227.6516-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_145301_605047_BE349436 
X-CRM114-Status: GOOD (  11.58  )
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
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The SAR ADC can measure the chip temperature of the SoC. This only
works if the chip is calibrated and if the calibration data is written
to the correct registers. The calibration data is stored in the upper
two bytes of eFuse offset 0x1f4.

This adds the eFuse cell for the temperature calibration data and
passes it to the SAR ADC. We also need to pass the HHI sysctrl node to
the SAR ADC because the 4th TSC (temperature sensor calibration
coefficient) bit is stored in the HHI region (unlike bits [3:0] which
are stored directly inside the SAR ADC's register area).

On boards that have the SAR ADC enabled channel 8 can be used to
measure the chip temperature.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index 829984be4ed8..c9bd46120cb5 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -449,6 +449,11 @@
 	compatible = "amlogic,meson8-efuse";
 	clocks = <&clkc CLKID_EFUSE>;
 	clock-names = "core";
+
+	temperature_calib: calib@1f4 {
+		/* only the upper two bytes are relevant */
+		reg = <0x1f4 0x4>;
+	};
 };
 
 &ethmac {
@@ -536,6 +541,9 @@
 	clocks = <&clkc CLKID_XTAL>,
 		<&clkc CLKID_SAR_ADC>;
 	clock-names = "clkin", "core";
+	amlogic,hhi-sysctrl = <&hhi>;
+	nvmem-cells = <&temperature_calib>;
+	nvmem-cell-names = "temperature_calib";
 };
 
 &sdio {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
