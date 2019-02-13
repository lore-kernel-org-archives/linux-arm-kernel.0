Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8856C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:34:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77DC0222B2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EV08V4Mu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mjbD1SBB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77DC0222B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=aKtYrNQY9qQlC0kS8iV6j/vtA+XgiRUYxAqtXWGbAEo=; b=EV08V4MucNlCBoBJVHMQc22LqY
	yv8C+USlPF4m/c0nxJEwfbuYyGKqlBDtQEGYJgpk6vs2K1Wwc7J4vk5lEOp1cSboylbnmxxxtXmgE
	Ip4F+y3e5kkNe8HaQ9GIT17mENCvZuYsS/vkLP/x1VhY2BK08WkEpPvMbD+BRXC8xSpoiO3Nwfk1t
	zryeR1Qzy0lsQ3x7QoJeK3tdZ3/bix9IKR5i8/UerLdqc+y8rVJQFVBgiF9Mu2CmfjuO0ikUOdeYW
	C5Lw7Mme8B6uT3/qj0Ae5eN7cBPjtEgXit6K7jMmrJ12inGq5KOQeYfXw8QvwunD5AdKGaZT0vVh1
	Axx7EsIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gttkZ-0006lu-HL; Wed, 13 Feb 2019 12:34:51 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gttkC-0006Ih-R8
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 12:34:34 +0000
Received: by mail-pg1-x541.google.com with SMTP id s198so1084326pgs.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 04:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :in-reply-to:references;
 bh=AM3cPOYZnTTguViecu0E1+Ba1m1zZ0u7N8ID6CDTa4A=;
 b=mjbD1SBBY26BMfhUfCRIgG32/jSSvduWH75bBY9R+Gq8IKSJAyNuD1XTxDS6WD7nbg
 A8PgPX0v4hbV6BjeRZHIXdNS0Y3pMDuED7wGRjCDjV39Z+CRqbO+hwi2rgOu14TcLBI6
 0b0qB0f9CPF7He27o4CY7rZnLpyAD2OiyK84OBw1z8t6IR0QGMkC1xDpPGWAQwJIewfP
 ZTiHb5tFQ+twVP4YTz8DzbSsu0Yy+777EIlqOSWOdkvfleOwhb/mHwC1NrlnJIEKJbnq
 BaPUSQ2mf9yRtuUSZrhJ8gyd/1TcckbIjffnOLeWY+Mv5/aN3+BrtjTqJ0OrADw/VAWb
 iF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:in-reply-to:references;
 bh=AM3cPOYZnTTguViecu0E1+Ba1m1zZ0u7N8ID6CDTa4A=;
 b=p3qLBdZnXEmmthpqxXBVrJ3CCT0IrDEEoIAnKB+6YmwFwtla940G1tmYwog7GssYsO
 P/1Z2RGkBejNx29SjC5krr49bqQPig9BJR8fCEzNSmKm6gSVvDAHtbxrbGOsR3q8fbmd
 fpcLbr6HCW6W+1gR6v+Guj/2bsRe8T/38CKeV8LZ+9OmbUA4ZHj24nAOY2qFe9SzbqK6
 /3HDS3CqotnIsYHqmhoKO5j2kK6c212NnS4O1D2SRzHEAJvu7jTpzFdTwhV4fN8j5qz4
 fom9wAMsxP9lF6tplQ2f9KojPrnrDbF/V8w13r/V2BxgMBLN7PnA0zS5VG/EqYVxQoJU
 JQdw==
X-Gm-Message-State: AHQUAubO0Ja752eefdRyafkUprxxjphQh4eKOsouOIDhVN7d1w6tLZxJ
 Db5w84QBIIEQQIVApQqg72WW9g==
X-Google-Smtp-Source: AHgI3IYzBUqBlJxj3lN55vuJ9Qse/YMpgygqbXFQINAsrgnurSDtJojuYPg/iAOOErNhfmUP17PsaA==
X-Received: by 2002:a65:62ce:: with SMTP id m14mr262963pgv.101.1550061268236; 
 Wed, 13 Feb 2019 04:34:28 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
 by smtp.gmail.com with ESMTPSA id l5sm21223640pgl.51.2019.02.13.04.34.24
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 13 Feb 2019 04:34:27 -0800 (PST)
From: Baolin Wang <baolin.wang@linaro.org>
To: robh+dt@kernel.org,
	mark.rutland@arm.com,
	arnd@arndb.de
Subject: [PATCH v2 5/5] arm64: dts: sprd: Remove wildcard compatible string
Date: Wed, 13 Feb 2019 20:32:49 +0800
Message-Id: <f34970a034946bacda19202e2ce9973ca732c925.1550060544.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1550060543.git.baolin.wang@linaro.org>
References: <cover.1550060543.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1550060543.git.baolin.wang@linaro.org>
References: <cover.1550060543.git.baolin.wang@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_043429_450407_A8329E50 
X-CRM114-Status: UNSURE (   9.82  )
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
Cc: devicetree@vger.kernel.org, baolin.wang@linaro.org, zhang.lyra@gmail.com,
 broonie@kernel.org, linux-kernel@vger.kernel.org, arm@kernel.org,
 olof@lixom.net, orsonzhai@gmail.com, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Remove wildcard compatible string.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/sc2731.dtsi |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/sprd/sc2731.dtsi b/arch/arm64/boot/dts/sprd/sc2731.dtsi
index 4a79ddf..e15409f 100644
--- a/arch/arm64/boot/dts/sprd/sc2731.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc2731.dtsi
@@ -24,7 +24,7 @@
 		};
 
 		led-controller@200 {
-			compatible = "sprd,sc27xx-bltc", "sprd,sc2731-bltc";
+			compatible = "sprd,sc2731-bltc";
 			reg = <0x200>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -46,14 +46,14 @@
 		};
 
 		rtc@280 {
-			compatible = "sprd,sc27xx-rtc", "sprd,sc2731-rtc";
+			compatible = "sprd,sc2731-rtc";
 			reg = <0x280>;
 			interrupt-parent = <&sc2731_pmic>;
 			interrupts = <2>;
 		};
 
 		pmic_eic: gpio@300 {
-			compatible = "sprd,sc27xx-eic";
+			compatible = "sprd,sc2731-eic";
 			reg = <0x300>;
 			interrupt-parent = <&sc2731_pmic>;
 			interrupts = <5>;
@@ -64,7 +64,7 @@
 		};
 
 		efuse@380 {
-			compatible = "sprd,sc27xx-efuse", "sprd,sc2731-efuse";
+			compatible = "sprd,sc2731-efuse";
 			reg = <0x380>;
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -85,7 +85,7 @@
 		};
 
 		pmic_adc: adc@480 {
-			compatible = "sprd,sc27xx-adc", "sprd,sc2731-adc";
+			compatible = "sprd,sc2731-adc";
 			reg = <0x480>;
 			interrupt-parent = <&sc2731_pmic>;
 			interrupts = <0>;
@@ -109,12 +109,12 @@
 		};
 
 		vibrator@ec8 {
-			compatible = "sprd,sc27xx-vibrator", "sprd,sc2731-vibrator";
+			compatible = "sprd,sc2731-vibrator";
 			reg = <0xec8>;
 		};
 
 		regulators {
-			compatible = "sprd,sc27xx-regulator";
+			compatible = "sprd,sc2731-regulator";
 
 			vddarm0: BUCK_CPU0 {
 				regulator-name = "vddarm0";
-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
