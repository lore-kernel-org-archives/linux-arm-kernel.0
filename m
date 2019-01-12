Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D394C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 13:08:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E7BB20854
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 13:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZUkOpsMc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="YefjpmFX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E7BB20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BU65ThN0ROjknFSMSdbHrNUsSQR46ET2YljkBToIGZw=; b=ZUkOpsMckS/mfX
	vD+pGjCgP9Ei6pQX3bEhPiANWLeNYOBWekvoKeIHDIOk6VsbMCgwXMAc/FMXkxXu8z3aQFEaEl2Tx
	qUB5gzLcOuIw0Hx6MRiiVqOgYCarDz/RyTNzdLndFr5dJ8d3O+WmkigtapCqA+KhvUY2+sIIvJqW5
	czyiUaU6z/p2GTnoA6nbwx8a116d9VQ2mtyU6iuL279RSosWq3eph78sGkiG2OMTr1gsAa+2oMPty
	rWD6Crq24lb/oDloyfQRIuoib32QcGmjEIQJVP4yjACs3PPhyEjdRmwVmJ8/a7I4hg+/g5dHNKpyX
	wwKnQnp8ziErjRvOpbAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giJ1O-0000hx-FT; Sat, 12 Jan 2019 13:08:18 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giJ09-0007qY-LG; Sat, 12 Jan 2019 13:07:08 +0000
Received: by mail-wr1-x443.google.com with SMTP id q18so18002495wrx.9;
 Sat, 12 Jan 2019 05:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=X0DVle89JG5JTLCgwoLl7aCIrZA7dPHg3+1ZWFBYSeI=;
 b=YefjpmFXGcXUkogc+OefuH+HXmnqlj1yS0Jg98dnIjm6HZeihAV0wU/LRU5auR7YTp
 uqHuAfKmwFV8k2s4nHfxVLDQZLhyJ3bibsKX0D/dYvI3G7p1Xd/wVkF1KteeDQfIhf0V
 7kf9tgtmJErVPqPXDX44i8sF8l1ABgpTAMjyV+sBUefv4EnTwFqZVny+7VIY9T2y7/LP
 QpmzBEM/i9+jeuuZZUZuAdJRY78QzhV4sPEEU2I1+SkwCUOhdjCGRoVov1FdmkQlzu/9
 3eH/VrVizwjFG9ky5LJmSzHUaCISaMvuXgZHv2vkvMckUpogIGVMGEfXLwkhkcT+2HrW
 phMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=X0DVle89JG5JTLCgwoLl7aCIrZA7dPHg3+1ZWFBYSeI=;
 b=bvpvMZyPJXSEfOIlVDDWBkl1jPD07WBnqQJGAXPSWEF/I86ElwrxJevN9Ga4GPm2Zz
 Bkp0JbY9DyBj6iMEIFIV8XsT9Gi4E+UH4YZHZ8NIzzGEmuuqchxdjXdf07diYPaMV4d6
 ltgDhjONNez4xpZtTRkzgGuAkfZSO7FUbpgfPCvuHAZbxRadzyNVEsI8bVy0KwD8EyRy
 C/XqOYtJ94Sb0QhdkkX0JcHwJO0YQG6KbiWBvxcsvnOMNKS9jVna+6dKieWanTd8Y3kg
 65EUvny257tWl0KXq6MCEI63Xa1B4zGfeAja2mTQnW5bf1ANuGC3ntYwnDSNeFZzbBqW
 Y2pA==
X-Gm-Message-State: AJcUuke7qXQZHRPIFEu64NOFNfsKKGdDmz2mMPQDABSZF318t3/VFFLr
 mihrp2/d9M04UeZnhPENqHfskKpT
X-Google-Smtp-Source: ALg8bN4nX9DZBSCv/ZN9AKhcOB2ftMpdxo/Y0q2bKoG9N0pXPd7GoVbuUos6lvj8h+Ugotf/cQapvA==
X-Received: by 2002:adf:9b11:: with SMTP id b17mr17690965wrc.168.1547298416777; 
 Sat, 12 Jan 2019 05:06:56 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD7329F008D685E3E728ED25E.dip0.t-ipconnect.de.
 [2003:dc:d732:9f00:8d68:5e3e:728e:d25e])
 by smtp.googlemail.com with ESMTPSA id o5sm37804630wmg.25.2019.01.12.05.06.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 12 Jan 2019 05:06:56 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	khilman@baylibre.com
Subject: [PATCH 2/6] ARM: dts: meson8: add the temperature calibration data
 for the SAR ADC
Date: Sat, 12 Jan 2019 14:06:45 +0100
Message-Id: <20190112130649.23838-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190112130649.23838-1-martin.blumenstingl@googlemail.com>
References: <20190112130649.23838-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_050702_024012_4EA652D1 
X-CRM114-Status: GOOD (  11.63  )
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
index 83ed92dae892..5c6af73e4fc0 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -456,6 +456,11 @@
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
@@ -535,6 +540,9 @@
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
