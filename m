Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE14EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:30:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7C2221919
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aUFZY7oM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="OSJEFWcr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7C2221919
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=mail.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=7+jqw3fRi/RpOhMtto4dp0aSdE73rnafSaG2a6dRAys=; b=aUFZY7oMSWT1wT3BZZWmb1e9WF
	WkyebRrtuG5HRr9F+IAVeKXTT3bfXpTDbNIvdUCwL+eZfwtTSQfmvf2aHujLp14TUeLV4by7YiffE
	ak1gMUh2FXg3t8U7BY9Rh7awdxiKEsh4YEopIU6hl54qvEOWhY4/SH4khONuFfsvMlm6RG7VTAcbr
	IscrUoQhcFbHia+tRj40jtJyuZN+2bblbVOMtL2OU8JuQ1+Ypg1TREgANYoE0ICC/q2ahb1c0Ccdm
	yV+rSFhebfqBWlT6NEDDKIVTe6UqVQEyMh7Dw5jU80nR5ZVTYEiOeMI/GKlF6uXWB939j/5AmoEiS
	QVNuIbxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaI4o-0003XZ-22; Fri, 21 Dec 2018 10:30:42 +0000
Received: from smtp52.i.mail.ru ([94.100.177.112])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaI4j-0003WA-La
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 10:30:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail2; 
 h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=he+JO+e0b7ckY/Bt34DdTtuB3kI+4ZafvjpaiOmeDjU=; 
 b=OSJEFWcr/mM+jgpxnsRidW2lXpew8rSDVmm+wt1vpNbZ+Gidim1xPphiJzmvenQmjQoxBqtebsNmC/dx1GBWfdVwhoE1n80dBGMmJi+TmmTe8q0z6xePwmvt6riBISkwUSPISR0tXju6uR1vj44w8jQCt67s/xWx1CDzNmnSl6A=;
Received: by smtp52.i.mail.ru with esmtpa (envelope-from <shc_work@mail.ru>)
 id 1gaI4U-0007db-QQ; Fri, 21 Dec 2018 13:30:23 +0300
From: Alexander Shiyan <shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/4] ARM: dts: clps711x: rename uart device tree nodes
Date: Fri, 21 Dec 2018 13:30:17 +0300
Message-Id: <20181221103019.15374-2-shc_work@mail.ru>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20181221103019.15374-1-shc_work@mail.ru>
References: <20181221103019.15374-1-shc_work@mail.ru>
Authentication-Results: smtp52.i.mail.ru; auth=pass smtp.auth=shc_work@mail.ru
 smtp.mailfrom=shc_work@mail.ru
X-77F55803: 0014004E1F3277295A78504BD2AC29419868B496DAF47A9FC13E8B01DAA0A770E967A830D59455C362F6C0DF2C2DBB0D
X-7FA49CB5: 0D63561A33F958A5BF407F9698E026C5B22B7DB495E7256AD7BFC8E453A90EEC8941B15DA834481FA18204E546F3947CC2B5EEE3591E0D35F6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8BECADA55FE5B58BB7A471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C2249DA33821E755670D83AA81AA40904B5D9CF19DD082D7633A0E7DDDDC251EA7DABD81D268191BDAD3D78DA827A17800CE72CE3825EE585899DCD04E86FAF290E2D40A5AABA2AD3711975ECD9A6C639B01B78DA827A17800CE7DCBE8BAE9E61DE0A07070A87B953B59975ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC85D9B7C4F32B44FF57285124B2A10EEC6C00306258E7E6ABB4E4A6367B16DE6309
X-Mailru-Sender: 8261CADE3D3FA0B4C2F1292954F703E9B4DE5E4DD4446149E6D5D20F850E9ECBE9D6BBEAD5202E216B3B2BD4812BFD4DC77752E0C033A69E93554C27080790AB3B25A7FBAAF806F0AE208404248635DF
X-Mras: OK
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_023038_092137_0E580DA9 
X-CRM114-Status: GOOD (  10.23  )
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
 Rob Herring <robh+dt@kernel.org>, Alexander Shiyan <shc_work@mail.ru>,
 Arnd Bergmann <arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Use generic names 'serial' for UARTs.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/ep7209.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/ep7209.dtsi b/arch/arm/boot/dts/ep7209.dtsi
index bcaf54221145..48a1660a9cf2 100644
--- a/arch/arm/boot/dts/ep7209.dtsi
+++ b/arch/arm/boot/dts/ep7209.dtsi
@@ -22,8 +22,8 @@
 		gpio1 = &portb;
 		gpio3 = &portd;
 		gpio4 = &porte;
-		serial0 = &uart1;
-		serial1 = &uart2;
+		serial0 = &serial1;
+		serial1 = &serial2;
 		spi0 = &spi;
 		timer0 = &timer1;
 		timer1 = &timer2;
@@ -143,7 +143,7 @@
 			#pwm-cells = <1>;
 		};
 
-		uart1: uart@80000480 {
+		serial1: serial@80000480 {
 			compatible = "cirrus,ep7209-uart";
 			reg = <0x80000480 0x80>;
 			interrupts = <12 13>;
@@ -166,7 +166,7 @@
 			reg = <0x80001100 0x80>;
 		};
 
-		uart2: uart@80001480 {
+		serial2: serial@80001480 {
 			compatible = "cirrus,ep7209-uart";
 			reg = <0x80001480 0x80>;
 			interrupts = <28 29>;
-- 
2.13.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
