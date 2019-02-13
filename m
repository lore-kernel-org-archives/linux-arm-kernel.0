Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182E4C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:34:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE510222B2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V2niKT5E";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K+u2BXE8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE510222B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=XykL4mtV6XiR65LsgR+Hhl2d+i3LyAXoeuHZNASYryc=; b=V2niKT5EIWrPZ4N4ApvlOIgbuc
	Yk4v+KGWnPeOZLvDqgRxH2W6YXNuvFqyVky+VeRYNVlnM95gyDd8LV6awJcN3S/OVXXV/fQNl1TM/
	Pynqt5vD7adCuHyKrPU9ohIIhaOR0hJy4mWJVbam5xOEQfU1Xw7rpPgW7B3R1RiiBiu3FceEqT49c
	L4aGrAxwZO+uzfRAkg1YDNNRlwGppZHjO6IR8gdCjNpGFpYMtOtMCjH1rZY1gf+HDcLDwnGyeulPp
	tc57Jfp30YB+qEFtGAlrjNBlnsH2lcbk9X/s85VfPXXcG27uHrW5XcrDRXUvrJN7iiVb4cnNdGnek
	ZQ8NoDFQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gttkH-0006NT-BP; Wed, 13 Feb 2019 12:34:33 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gttk0-0005zY-Et
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 12:34:20 +0000
Received: by mail-pg1-x544.google.com with SMTP id w7so1057175pgp.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 04:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :in-reply-to:references;
 bh=TsYSQ/G0YznTAgTKSekGveHgCX9PxIa5Y7B9m7W0j9A=;
 b=K+u2BXE8igH9mZ5PXj92nX6kf00B7E4SIonYnZdN76QA5DDQe+PbEmkmz8iP2a49Mc
 uE5vBYjcHExxmpQT2+jeCXEbGfxlZLpDUD0NFNA+H3nDVZvPV/Wa6fEup4fZUomy0hbC
 69/VDJuxrS+cNBBlVnAZuptQnAIzO+bZMe7BN6E1ZIYliug9BFIXqB1qerjLskzPOmlW
 wNGZEYi128Ls+AATJPire+8gcSzsxxBAOi+Jfh2MRTWJ1A9lbIhYOGJROro6VeBKb8xc
 Lv+zNRmnYMKofHCyLEZxM8+TlUvChbvJc40bSJpvJoc18NkN3OzpRyRnXyK3Sn2GZ2Q9
 nkcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:in-reply-to:references;
 bh=TsYSQ/G0YznTAgTKSekGveHgCX9PxIa5Y7B9m7W0j9A=;
 b=HyxM5mC3aMppcRT3Gc5q1h5Dp85jyVy42/zbR6r+0NNsuew3clBTaQe74428HEmpKs
 g2hhTnHcXCp44YLy4iEOLp4eDoY0SqjfXc+6QTNr5WvVQWGodwRIqE3TBYuU+XdoTrjg
 sMoUmh3OzcfU3Vzvzi8NgqFLRG3olrXRoDYY6VXFUj3F2fMb96voAufC+dNpVow+nz7j
 7ji3QwALiijq1J629gIWjkhpTVzPYGUrqoSY0YlNRPmuaic97tRvQJKOVCfffj7mCgs5
 +mp2Ac2I1KcKfNkCpcYXddw+feW6i8LA+F8FkbKRXoVZqsriDaB03wqbSsbbiBlBt3PG
 uzOA==
X-Gm-Message-State: AHQUAubwy6Kn8NwOj+B1DJwOpv7ZTd3W5xCrqRAfbpOvdLjSCM1jQisu
 ucfohCdgH8mYcIVk+YDnC+e1dw==
X-Google-Smtp-Source: AHgI3IasfNSW9A1fNEEBfWE7qbZtE4VaXKaB3tivIDyCvYJl0ojIazlXhuIdAmvJqFEljsjrumLvuQ==
X-Received: by 2002:a63:6bc1:: with SMTP id g184mr275245pgc.25.1550061255741; 
 Wed, 13 Feb 2019 04:34:15 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
 by smtp.gmail.com with ESMTPSA id l5sm21223640pgl.51.2019.02.13.04.34.11
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 13 Feb 2019 04:34:15 -0800 (PST)
From: Baolin Wang <baolin.wang@linaro.org>
To: robh+dt@kernel.org,
	mark.rutland@arm.com,
	arnd@arndb.de
Subject: [PATCH v2 2/5] arm64: dts: sprd: Add ADC calibration support
Date: Wed, 13 Feb 2019 20:32:46 +0800
Message-Id: <0213394a8e432e0ee0809f9032427d971ea9cde2.1550060544.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1550060543.git.baolin.wang@linaro.org>
References: <cover.1550060543.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1550060543.git.baolin.wang@linaro.org>
References: <cover.1550060543.git.baolin.wang@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_043416_833039_1280DB92 
X-CRM114-Status: GOOD (  11.35  )
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
Cc: devicetree@vger.kernel.org, baolin.wang@linaro.org, zhang.lyra@gmail.com,
 broonie@kernel.org, linux-kernel@vger.kernel.org, arm@kernel.org,
 olof@lixom.net, orsonzhai@gmail.com, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch adds phandles to the calibration cells provided by the Efuse
device, which is used to calibrate the ADC channel scales.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/sc2731.dtsi |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/sprd/sc2731.dtsi b/arch/arm64/boot/dts/sprd/sc2731.dtsi
index f2f2aa5..a2edc25 100644
--- a/arch/arm64/boot/dts/sprd/sc2731.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc2731.dtsi
@@ -63,6 +63,14 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			hwlocks = <&hwlock 12>;
+
+			adc_big_scale: calib@24 {
+				reg = <0x24 0x2>;
+			};
+
+			adc_small_scale: calib@26 {
+				reg = <0x26 0x2>;
+			};
 		};
 
 		pmic_adc: adc@480 {
@@ -72,6 +80,8 @@
 			interrupts = <0>;
 			#io-channel-cells = <1>;
 			hwlocks = <&hwlock 4>;
+			nvmem-cell-names = "big_scale_calib", "small_scale_calib";
+			nvmem-cells = <&adc_big_scale>, <&adc_small_scale>;
 		};
 
 		vibrator@ec8 {
-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
