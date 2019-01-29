Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369FDC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:23:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8A8120882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="suwBw1EN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8A8120882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2KoEL+XZ+6T9DSi0RvoRGKQqA1LE1q7SrHeMuyoO0wo=; b=suwBw1ENiFn1at
	807RDtTota1eTIpbYf2Lj0DmMF0BRh7M36yDIGvDsWTeNDSicuYreM0fFT1/M6rMMEfYB8Jy7KZj+
	7xwhjBRkYyJaYTha2HB8wDkQsA4btDiLElwFZ80/I2aCrkYIjbrLEDqGSesLikrdBoPLPzMfFLtAl
	gnjozYziWhim16xY4xkJADisjfUSZeYERVaxuG+wOF2of/7wHkpv6S50IKW2It0dl92FdScQINq+P
	U5y/Jh3pgFsflu8/aS09CeMVe1YEnC7pxqX215tujY9elUc1d5YRbNt160BCvywok2dRudH6FTgfe
	6VnSSg7n+61IoO/WI+QQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goYyK-0003Ya-C5; Tue, 29 Jan 2019 19:23:00 +0000
Received: from mleia.com ([178.79.152.223] helo=mail.mleia.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goYwU-0001p8-9q
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 19:21:08 +0000
Received: from mail.mleia.com (localhost [127.0.0.1])
 by mail.mleia.com (Postfix) with ESMTP id B23B643EF29;
 Tue, 29 Jan 2019 19:21:00 +0000 (GMT)
From: Vladimir Zapolskiy <vz@mleia.com>
To: Sylvain Lemieux <slemieux.tyco@gmail.com>,
 Russell King <linux@armlinux.org.uk>
Subject: [PATCH 08/13] ARM: dts: lpc32xx: phy3250: setup LCD controller to
 panel interface
Date: Tue, 29 Jan 2019 21:20:44 +0200
Message-Id: <20190129192049.11223-9-vz@mleia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129192049.11223-1-vz@mleia.com>
References: <20190129192049.11223-1-vz@mleia.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20190129_192100_754916_3EA3C038 
X-CRM114-Status: GOOD (  11.11  )
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_192100_754916_3EA3C038 
X-CRM114-Status: UNSURE (   8.77  )
X-CRM114-Notice: Please train this message.
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The change adds description of Sharp LQ035Q7DB03 3.5" 320x240 TFT panel,
which is connected to Phytec phyCORE-LPC3250 board, ARM PrimeCell PL111
LCD controller on NXP LPC3250 SoC gets its configuration appropriately
to support graphics output to the panel.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/boot/dts/lpc3250-phy3250.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/lpc3250-phy3250.dts b/arch/arm/boot/dts/lpc3250-phy3250.dts
index d2dad2b541ff..aff72f14ad83 100644
--- a/arch/arm/boot/dts/lpc3250-phy3250.dts
+++ b/arch/arm/boot/dts/lpc3250-phy3250.dts
@@ -39,6 +39,17 @@
 		};
 	};
 
+	panel: panel {
+		compatible = "sharp,lq035q7db03";
+		power-supply = <&reg_lcd>;
+
+		port {
+			panel_input: endpoint {
+				remote-endpoint = <&cldc_output>;
+			};
+		};
+	};
+
 	reg_backlight: regulator-backlight {
 		compatible = "regulator-fixed";
 		regulator-name = "backlight";
@@ -71,7 +82,15 @@
 };
 
 &clcd {
+	max-memory-bandwidth = <18710000>;
 	status = "okay";
+
+	port {
+		cldc_output: endpoint {
+			remote-endpoint = <&panel_input>;
+			arm,pl11x,tft-r0g0b0-pads = <0 8 16>;
+		};
+	};
 };
 
 &i2c1 {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
