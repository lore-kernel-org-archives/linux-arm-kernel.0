Return-Path: <SRS0=oMaZ=PE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74DEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:51:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83C8C214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G7pFsM1j";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kD97fW8f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83C8C214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z69kcK/6WKbVVSkEBiB7pZ5lxGwKMBGjkQ+CF4G26wg=; b=G7pFsM1jkuPkg/
	yV1kfJNNTL6PdLjdGKPz9N/Orl3mWYZFKC9DOpoWuR12xlr/tUFPvDHlsEmZU9A4CB2txfDD8xQp8
	WGUEN3zJoEoBDCMQOx3Tt7DXVV0cvSzKckKJDrP0thItUFWv3srGHhCQBjg6wf2A1+QCWUrmImDya
	m3J6L5nHMV59tEIa2y0AH4O+0zGmvDJOGKRp2S+GGgmHHdVwdtVFlKcBBym9n412L94P0aK6pAEsI
	Aumk6JjxThpikDHX4I2BxZ+xfSpFKCJX6ir+RhjnLq7NGRTV0wKGd6AvYBIL47Lu9THqT2bZaLV6o
	BzIpn/T/SyBjFluOvLeQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcdYV-0001zw-6j; Thu, 27 Dec 2018 21:51:03 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcdYQ-0001xO-G0; Thu, 27 Dec 2018 21:50:59 +0000
Received: by mail-wr1-x441.google.com with SMTP id 96so19465081wrb.2;
 Thu, 27 Dec 2018 13:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vwjI45tfNGokg0tQ5bvI2hO5i8EXM3XX5a012DEAbX0=;
 b=kD97fW8f4BIW1Dp2BscUjoKLy6dxZKcu/RDYP0FusvauFwMXuNiBIjOS4H22WWWm/U
 gUwGq+ox9b2Dxs2kyyNq8vO2/CSEtqKsQanjvDqwSYti+BzQi/EsDS8Xsn7RmS2OO6vW
 kg5Fpht89pPLhjreYktKtcDeuclxUEc2Oax4pTTwEknSwZVderdQrGI5roanjllObz+1
 R9xyJ4UlENObC/qrxlgvgVmwW7O0zEIi3uYWOeRwwmRvLNT0LInKSEbySLn/jfbf0UzP
 4wCjIOHssZ5zWArdqD4f0v7w9EHqYrKPE3dxaDLbjkZ4E9x+Yf0Mot8uxH+9CjNbUEXj
 EIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vwjI45tfNGokg0tQ5bvI2hO5i8EXM3XX5a012DEAbX0=;
 b=pFYJVhPQHvh8WWgZi5u7lpkMc3XMFqwoRV62KFStUfTRUM5Gda9mlQVUYAxcEyXRlo
 EgxVlmHwWVf5wwuAamwxMEVKGO/tI18Bc+1Pjlvql/1ETdkzyUZw+HozPy9DbC14J+xb
 MDTurSShi+bouZohnHopsd0x5jzah6NIjzFI1a+eI3ncwQ2gJgbLPTejtdTaysQNBfBT
 KFQSC4SwdIUzHMPOQmPYEzy8fYH7jThUEwRuGOlWYqcUTK0ORGX9Dqb5ttr8yProp1oY
 gRzTVkzxJpjfwq7fHyQJBmrKr/ucAc63EO7XtvsiuvklQFm2Garsj8w4m4fOaIfbndWY
 +UaA==
X-Gm-Message-State: AJcUukewnSfOuPETaxPLmx1ZFWOisHTnk5hGSJXGficN38QzsjwC3dv/
 BLoydEE6feBTfnlW/vuc81vgls7W
X-Google-Smtp-Source: ALg8bN5aFigp/wAZszU57y2/4eApQU0EgVujJSumDoMaGdpnm99RxIlzwQ/C/S5x71cqzLPyFlSECA==
X-Received: by 2002:adf:81b6:: with SMTP id 51mr24928584wra.240.1545947445287; 
 Thu, 27 Dec 2018 13:50:45 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD711B00071582302E30AD474.dip0.t-ipconnect.de.
 [2003:dc:d711:b000:7158:2302:e30a:d474])
 by smtp.googlemail.com with ESMTPSA id m4sm34538164wmi.3.2018.12.27.13.50.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Dec 2018 13:50:44 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
 pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com
Subject: [PATCH 1/2] dt-bindings: iio: adc: meson-saradc: update temperature
 sensor support
Date: Thu, 27 Dec 2018 22:50:19 +0100
Message-Id: <20181227215020.9803-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181227215020.9803-1-martin.blumenstingl@googlemail.com>
References: <20181227215020.9803-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181227_135058_537866_D8CFD4E9 
X-CRM114-Status: GOOD (  10.48  )
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
Cc: balbes-150@yandex.ru,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Meson8b and Meson8m2 use a 5-bit wide TSC (temperature sensor
coefficient). The SAR ADC registers however can only store (the lower)
4 bits. The fifth (upper-most) bit is stored inside the
MESON_HHI_DPLL_TOP_0[9] register from the HHI register area.
This adds a syscon property to the HHI register area so a driver can
fetch the HHI register map and store the fifth TSC bit in there.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../devicetree/bindings/iio/adc/amlogic,meson-saradc.txt      | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
index 325090e43ce6..75c775954102 100644
--- a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
@@ -23,6 +23,10 @@ Required properties:
 - #io-channel-cells: must be 1, see ../iio-bindings.txt
 
 Optional properties:
+- amlogic,hhi-sysctrl:	phandle to the syscon which contains the 5th bit
+			of the TSC (temperature sensor coefficient) on
+			Meson8b and Meson8m2 (which used to calibrate the
+			temperature sensor)
 - nvmem-cells:		phandle to the temperature_calib eFuse cells
 - nvmem-cell-names:	if present (to enable the temperature sensor
 			calibration) this must contain "temperature_calib"
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
