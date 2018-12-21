Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99833C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:31:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 692B12176F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G6e5rrLU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="C7qZsZ4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 692B12176F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=mail.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=KFIjuzgHbQwdwXIRJU3i84tL2nCXfbpmLDELe4h/CyE=; b=G6e
	5rrLUji+djm+wBCzetgWjEHrKNuttHzWUJp5tXj5Bmvqi4xAEgDNGVaU7gUmhgozFlIE2/UuNMNDf
	j9yqSKxHKRCSgOT1ssWxl/P6LT6SlQPQnGVwzFUw8t3f2OSj2J8w4ZgN3ycrdEXvihiuRwvpMR0L7
	53Xng6nvzce993Dsg8GOndLfj3Slzj9FqnnaSzJFqqN8GDzhGPf9WaTloCnJisyqbCctYkVOnuw2J
	9PlMaYselZsCoPElH2qmLY3aZ3giZgH09i8mGFBa7CKrgMJgEUOrqBaFuKOsnsmQeMPT68QSQJqqN
	x+M/ioPXowMzvXFQXqKjq4KZxYl1KoA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaI5k-0004N7-1u; Fri, 21 Dec 2018 10:31:40 +0000
Received: from smtp52.i.mail.ru ([94.100.177.112])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaI4j-0003W6-Lu
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 10:30:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail2; h=Message-Id:Date:Subject:Cc:To:From;
 bh=NsiIsagkvJbOHhYQFvI4ffjDtaVXfUjV3PkW3QR2bRk=; 
 b=C7qZsZ4oD0FZu5unpd7M6n6tMowpzwS9LeRM0RPkYr1tT+vcNGcX+mQF7Kw1b8y5bAm9n3W1chj9qNPX46ciyrKBf6ZLgzPc4T3+IUJIxloShXz8HMzbXnIQozyV8XaLQDgR02K2L2QKpc0BIegb2UYYFApMamO1sQ3hbfJiT3k=;
Received: by smtp52.i.mail.ru with esmtpa (envelope-from <shc_work@mail.ru>)
 id 1gaI4T-0007db-W0; Fri, 21 Dec 2018 13:30:22 +0300
From: Alexander Shiyan <shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/4] ARM: dts: clps711x: Remove skeleton.dtsi
Date: Fri, 21 Dec 2018 13:30:16 +0300
Message-Id: <20181221103019.15374-1-shc_work@mail.ru>
X-Mailer: git-send-email 2.13.0
Authentication-Results: smtp52.i.mail.ru; auth=pass smtp.auth=shc_work@mail.ru
 smtp.mailfrom=shc_work@mail.ru
X-77F55803: 2D1AD755E866B1545A78504BD2AC29419868B496DAF47A9FEFBD78D4602E738533F5AC807D9D4A7B17000A265A227AA4
X-7FA49CB5: 0D63561A33F958A5591D8864483065B8B22B7DB495E7256A643F35113B56AFB38941B15DA834481FA18204E546F3947C1D471462564A2E19F6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8B2EE5AD8F952D28FBA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C2249E20791DD86E535D73AA81AA40904B5D9CF19DD082D7633A0E7DDDDC251EA7DABD81D268191BDAD3D78DA827A17800CE79C0DA0AD91AF617ECD04E86FAF290E2D40A5AABA2AD3711975ECD9A6C639B01B78DA827A17800CE7217D10A1E6374DE9EA51B706C899424F75ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC85D9B7C4F32B44FF57285124B2A10EEC6C00306258E7E6ABB4E4A6367B16DE6309
X-Mailru-Sender: 8261CADE3D3FA0B4C2F1292954F703E9B4DE5E4DD4446149DB1FD13B5CD75FF1FCB7861228910ADA6B3B2BD4812BFD4DC77752E0C033A69E93554C27080790AB3B25A7FBAAF806F0AE208404248635DF
X-Mras: OK
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_023038_097981_E0BAF6A2 
X-CRM114-Status: GOOD (  11.11  )
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

As explained by commit 9c0da3cc61f1233c ("ARM: dts: explicitly mark
skeleton.dtsi as deprecated"), including skeleton.dtsi is deprecated.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/ep7209.dtsi        | 11 +++++++++--
 arch/arm/boot/dts/ep7211-edb7211.dts |  1 +
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ep7209.dtsi b/arch/arm/boot/dts/ep7209.dtsi
index aaf1261d2ee4..bcaf54221145 100644
--- a/arch/arm/boot/dts/ep7209.dtsi
+++ b/arch/arm/boot/dts/ep7209.dtsi
@@ -6,14 +6,17 @@
 
 /dts-v1/;
 
-#include "skeleton.dtsi"
-
 #include <dt-bindings/clock/clps711x-clock.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
 	model = "Cirrus Logic EP7209";
 	compatible = "cirrus,ep7209";
 
+	chosen {};
+
 	aliases {
 		gpio0 = &porta;
 		gpio1 = &portb;
@@ -26,6 +29,10 @@
 		timer1 = &timer2;
 	};
 
+	memory {
+		device_type = "memory";
+	};
+
 	cpus {
 		#address-cells = <0>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/ep7211-edb7211.dts b/arch/arm/boot/dts/ep7211-edb7211.dts
index bc9d5b697452..3475c7777cbc 100644
--- a/arch/arm/boot/dts/ep7211-edb7211.dts
+++ b/arch/arm/boot/dts/ep7211-edb7211.dts
@@ -12,6 +12,7 @@
 	compatible = "cirrus,edb7211", "cirrus,ep7211", "cirrus,ep7209";
 
 	memory {
+		device_type = "memory";
 		reg = <0xc0000000 0x02000000>;
 	};
 
-- 
2.13.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
