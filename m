Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A440FC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:25:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7038020882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p33Lo2uC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7038020882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d9nPWwwGehFsejnvdz0YISnS5/ZqNiNhf74Vde4P5uA=; b=p33Lo2uCWP+qub
	q8cfKdkgYH6syaSRDrBBbKDQDoGWJ0/phglNU9gDC+fBjM5lCfgppQXc16JOdYJ40KBpzSNeWdjxQ
	IYnrlciFw7/kAGPMFpyuYpcRl/u9mWVQ9PeG8NK1/ILd1aIDSZReQRg6PyHXq8emC9r9bRM8pEaDT
	LO92xsHoLnZfnz1JKEaPUPBV/ttk49oMbWsHV0D7NS09hWUG4VhHhxF0LaFiXkChEyxs74BLS3byF
	TEolYVOCVeayrIVU8xl2PWK7meFRhn51TAXbY2qNetavlBJt9rbpHLifqcQqV5wCDj7zpkERVYOMm
	h1TfvnQQt/DjX6C3cW3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goZ0n-0006Z8-On; Tue, 29 Jan 2019 19:25:33 +0000
Received: from mleia.com ([178.79.152.223] helo=mail.mleia.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goYwU-0001p5-2u
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 19:21:07 +0000
Received: from mail.mleia.com (localhost [127.0.0.1])
 by mail.mleia.com (Postfix) with ESMTP id 034B943EF24;
 Tue, 29 Jan 2019 19:20:59 +0000 (GMT)
From: Vladimir Zapolskiy <vz@mleia.com>
To: Sylvain Lemieux <slemieux.tyco@gmail.com>,
 Russell King <linux@armlinux.org.uk>
Subject: [PATCH 05/13] ARM: dts: lpc32xx: phy3250: fix SD card regulator
 voltage
Date: Tue, 29 Jan 2019 21:20:41 +0200
Message-Id: <20190129192049.11223-6-vz@mleia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129192049.11223-1-vz@mleia.com>
References: <20190129192049.11223-1-vz@mleia.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20190129_192059_037116_C6C5F903 
X-CRM114-Status: GOOD (  10.42  )
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_192059_037116_C6C5F903 
X-CRM114-Status: UNSURE (   9.33  )
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

The fixed voltage regulator on Phytec phyCORE-LPC3250 board, which
supplies SD/MMC card's power, has a constant output voltage level
of either 3.15V or 3.3V, the actual value depends on JP4 position,
the power rail is referenced as VCC_SDIO in the board hardware manual.

Fixes: d06670e96267 ("arm: dts: phy3250: add SD fixed regulator")
Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/boot/dts/lpc3250-phy3250.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/lpc3250-phy3250.dts b/arch/arm/boot/dts/lpc3250-phy3250.dts
index 1e1c2f517a82..ffcf78631b22 100644
--- a/arch/arm/boot/dts/lpc3250-phy3250.dts
+++ b/arch/arm/boot/dts/lpc3250-phy3250.dts
@@ -49,8 +49,8 @@
 		sd_reg: regulator@2 {
 			compatible = "regulator-fixed";
 			regulator-name = "sd_reg";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
 			gpio = <&gpio 5 5 0>;
 			enable-active-high;
 		};
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
