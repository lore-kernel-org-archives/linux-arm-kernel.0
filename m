Return-Path: <SRS0=tR0U=PB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15635C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:20:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA50D2171F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BHhHnHR5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA50D2171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=EWcrfxzSWx1mKSzxWuJV8KoH+XDAH09yQzh7kP5pUt4=; b=BHhHnHR5i9IF6W
	DxX767w+iG2hY929i+Antt18XiZxIGB+P9sOK6lR/dfiuSEnAmGq8NUzwwRwg9Q38KrQ2V6M3GGB2
	o1V2ttAkTOGFdV5poPM8uHtBUsGk5O9Mr57orPXkQbdFfa8aJnYmpLCica++plxqg/XXvpotKyneP
	8UNWZ3+GaXJeaog/Ptdv7v4tGn0Qiqtc+qpYenjC5gzyXJpdK1BgcyQH8Zd+N1wzyOZBoiwPotZBG
	QCZO7Bk0Ffl2JB8m9dV2E2G3o5KdtL5fnF4OAm6jZlwHLyxYIBRgRjBh/UzZPqfYbnnWJ11LgPZQW
	reO2I3oJXF20o0cpDzxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbLTc-0007On-5E; Mon, 24 Dec 2018 08:20:40 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbLTY-0007J3-2F; Mon, 24 Dec 2018 08:20:38 +0000
Received: from [46.183.103.8] (helo=phil.sntech)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gbLTI-0003FL-0R; Mon, 24 Dec 2018 09:20:20 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org
Subject: [PATCH] ARM: dts: rockchip: move rk3036 i2s sound-dail-cells into soc
 dtsi
Date: Mon, 24 Dec 2018 09:20:14 +0100
Message-Id: <20181224082014.23310-1-heiko@sntech.de>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181224_002036_258149_708AEB03 
X-CRM114-Status: GOOD (  12.79  )
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
Cc: Heiko Stuebner <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The Rockchip i2s controller always only has one output connection
hence #sound-dai-cells is always 0. Therefore define it in the soc
dtsi itself instead of in individual boards.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3036-kylin.dts | 1 -
 arch/arm/boot/dts/rk3036.dtsi      | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3036-kylin.dts b/arch/arm/boot/dts/rk3036-kylin.dts
index 0fd19f9723df..0173eb11ec28 100644
--- a/arch/arm/boot/dts/rk3036-kylin.dts
+++ b/arch/arm/boot/dts/rk3036-kylin.dts
@@ -310,7 +310,6 @@
 };
 
 &i2s {
-	#sound-dai-cells = <0>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index d560fc4051c5..59c90863b0e7 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -289,6 +289,7 @@
 		dma-names = "tx", "rx";
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s_bus>;
+		#sound-dai-cells = <0>;
 		status = "disabled";
 	};
 
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
