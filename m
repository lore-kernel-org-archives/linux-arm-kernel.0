Return-Path: <SRS0=5OaU=PA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59562C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 16:33:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 223772184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 16:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HkMG2wtU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="jwdPBbe9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 223772184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=mail.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=jkeK/fzaHec0jnniWvmV1ugp9b0cWxJ1O165jNGNH7k=; b=HkMG2wtU9pmZSMi46lgHqlWdJ6
	374Ko533KUEzxdg/aYkgrgBNQLGhTn7MQxBBHfiRRKJ54GQ0xQ7pQYpOColD4lwXNfxD5ddG2MxpA
	YMDmg7R1rsSbWraYMlVr3ZsDnUKS92g9/Ymjm0jKleIwwJc7s0hiCX8nklNXoAU81te+0Y1LEY5bD
	ntvQA2GqyGY+EiUYMjE+DeKVpMjhat1+IRAWntd79pz1fJZlyzeKLpt4cEp5B0vo0w/cc8435t+YP
	NBn5cz1NDL/Y3WHAWgWjmr0IM+zXDVFOEeIz9skksxy3j0GRiRzVm/EPCUjRHJJky2u/Klwdf7UVn
	GO9xFsAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gb6ge-00025l-M4; Sun, 23 Dec 2018 16:33:08 +0000
Received: from smtp34.i.mail.ru ([94.100.177.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gb6fb-0001GV-0y
 for linux-arm-kernel@lists.infradead.org; Sun, 23 Dec 2018 16:32:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail2; 
 h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=5lPjHqbNmAWl9gU6Th73KNCZiNI+fT47E6RlvZzdqBk=; 
 b=jwdPBbe9uVFwWepQ385WlRbjFrKojNsFS/f2tWY4Ar8JzbX6bWwnXJ4EUEb6VxgdDsPfd6BY/P/kynsZfruqJM6svWQBvDanHgFMnJQfgR9GJ4SDOPPA1g12dXj16OpTq7TG+u9aEqQdeICo7pWHu3kI7XV8tsFBjRzr1yCHGUU=;
Received: by smtp34.i.mail.ru with esmtpa (envelope-from <shc_work@mail.ru>)
 id 1gb6fN-00087P-Gw; Sun, 23 Dec 2018 19:31:49 +0300
From: Alexander Shiyan <shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/4] ARM: dts: imx6qdl-phytec-pfla02: Add some labels
Date: Sun, 23 Dec 2018 19:31:41 +0300
Message-Id: <20181223163141.6792-4-shc_work@mail.ru>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20181223163141.6792-1-shc_work@mail.ru>
References: <20181223163141.6792-1-shc_work@mail.ru>
Authentication-Results: smtp34.i.mail.ru; auth=pass smtp.auth=shc_work@mail.ru
 smtp.mailfrom=shc_work@mail.ru
X-77F55803: E14BCC6235C710295A78504BD2AC29417183463EAF47BFE34C282867D2D4FA0C80B54ACCCC20EBB7E7ED95722394493A
X-7FA49CB5: 0D63561A33F958A51AC0876731F395BAAE58B855DBA0FAC10C3273428A4AB2388941B15DA834481FA18204E546F3947C0839144E5BB460BAF6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8B55B19328CBC4F849A471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C2249DA33821E755670D83AA81AA40904B5D9CF19DD082D7633A0E7DDDDC251EA7DABD81D268191BDAD3D78DA827A17800CE72CE3825EE585899DCD04E86FAF290E2D40A5AABA2AD3711975ECD9A6C639B01B78DA827A17800CE744F493E7F1C8F1AA8F761D24840818F775ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC85D9B7C4F32B44FF57285124B2A10EEC6C00306258E7E6ABB4E4A6367B16DE6309
X-Mailru-Sender: 139A7956A63CACCF2A18077BC60D2445223CBA05F7F71A499FF4AA860F84897E1BC1145C96DC37836B3B2BD4812BFD4DC77752E0C033A69E93554C27080790AB3B25A7FBAAF806F0AE208404248635DF
X-Mras: OK
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181223_083203_407285_5C22DA09 
X-CRM114-Status: GOOD (  11.03  )
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
Cc: Alexander Shiyan <shc_work@mail.ru>, Shawn Guo <shawnguo@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch adds labels to devices that can be reused in top-level dts.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
index 81007d6..a685ff7 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
@@ -41,12 +41,12 @@
 	gpio_leds: leds {
 		compatible = "gpio-leds";
 
-		green {
+		led_green: led_green {
 			label = "phyflex:green";
 			gpios = <&gpio1 30 GPIO_ACTIVE_HIGH>;
 		};
 
-		red {
+		led_red: led_red {
 			label = "phyflex:red";
 			gpios = <&gpio2 31 GPIO_ACTIVE_HIGH>;
 		};
@@ -71,7 +71,7 @@
 	status = "okay";
 	cs-gpios = <&gpio4 24 GPIO_ACTIVE_LOW>;
 
-	flash@0 {
+	flash: flash@0 {
 		compatible = "m25p80", "jedec,spi-nor";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
@@ -99,12 +99,12 @@
 	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
 
-	eeprom@50 {
+	eeprom: eeprom@50 {
 		compatible = "atmel,24c32";
 		reg = <0x50>;
 	};
 
-	pmic@58 {
+	pmic: pmic@58 {
 		compatible = "dlg,da9063";
 		reg = <0x58>;
 		interrupt-parent = <&gpio2>;
-- 
2.10.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
