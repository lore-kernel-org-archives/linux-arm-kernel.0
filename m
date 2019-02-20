Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5FBC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:07:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D62F20880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iafs9ZER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D62F20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mansr.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=in7yrLq9Md6c2wi6ZDlJ1dPeKkX06/joxhiRIwd4PgY=; b=iafs9ZERIKLzue
	qfwy5Yi97s+k37h9qbhRZw4DwvmnU7diHshkfaKadx7mlL6cCe4ywyw9GouzaG8RLZPfKz+gppHus
	C9fzsVWyDKwnkzO484KHHpxMXN5pF7mggqctGHxG2fJzT3tt7ngsletLu+90WXK3V+ngm3L7PqFjL
	/tYkusxsBHehXwiue7jAPFLZkuMIUry4ADnb1GWj+CXFzqdmb+uikEY71XAmLwikg2r801Oh20UAa
	ciUVJm20xiRLJVIDBn/v4F9HbI3s73o1F4npwJzP9bsSNoZGbe9dx24KxgU0obIpoPvgD1s+l5Z7J
	/KyAmRjnskxV94zQ/6Fg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwQfC-00075b-2j; Wed, 20 Feb 2019 12:07:46 +0000
Received: from unicorn.mansr.com ([2001:8b0:ca0d:8d8e::2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwQf9-00074u-Er
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 12:07:44 +0000
Received: by unicorn.mansr.com (Postfix, from userid 51770)
 id 6DC5A15632; Wed, 20 Feb 2019 12:07:36 +0000 (GMT)
From: Mans Rullgard <mans@mansr.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
	Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v2] ARM: dts: sun7i: add pinctrl for missing uart mux options
Date: Wed, 20 Feb 2019 12:07:17 +0000
Message-Id: <20190220120717.30650-1-mans@mansr.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190216182132.12895-1-mans@mansr.com>
References: <20190216182132.12895-1-mans@mansr.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_040743_660670_43DC68AA 
X-CRM114-Status: UNSURE (   8.92  )
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
 Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds pinctrl settings for various missing uart options.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
Changed in v2:
- add /omit-if-no-ref/ tags to new nodes
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 54 ++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index af5b067a5f83..76d0c961f01e 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -944,6 +944,36 @@
 				function = "uart0";
 			};
 
+			/omit-if-no-ref/
+			uart0_pf_pins: uart0-pf-pins {
+				pins = "PF2", "PF4";
+				function = "uart0";
+			};
+
+			/omit-if-no-ref/
+			uart1_pa_pins: uart1-pa-pins {
+				pins = "PA10", "PA11";
+				function = "uart1";
+			};
+
+			/omit-if-no-ref/
+			uart1_cts_rts_pa_pins: uart1-cts-rts-pa-pins {
+				pins = "PA12", "PIA13";
+				function = "uart2";
+			};
+
+			/omit-if-no-ref/
+			uart2_pa_pins: uart2-pa-pins {
+				pins = "PIA2", "PIA3";
+				function = "uart2";
+			};
+
+			/omit-if-no-ref/
+			uart2_cts_rts_pa_pins: uart2-cts-rts-pa-pins {
+				pins = "PA0", "PIA1";
+				function = "uart2";
+			};
+
 			uart2_pi_pins: uart2-pi-pins {
 				pins = "PI18", "PI19";
 				function = "uart2";
@@ -969,6 +999,12 @@
 				function = "uart3";
 			};
 
+			/omit-if-no-ref/
+			uart3_cts_rts_ph_pins: uart3-cts-rts-ph-pins {
+				pins = "PH2", "PH3";
+				function = "uart3";
+			};
+
 			uart4_pg_pins: uart4-pg-pins {
 				pins = "PG10", "PG11";
 				function = "uart4";
@@ -979,16 +1015,34 @@
 				function = "uart4";
 			};
 
+			/omit-if-no-ref/
+			uart5_ph_pins: uart5-ph-pins {
+				pins = "PH6", "PH7";
+				function = "uart5";
+			};
+
 			uart5_pi_pins: uart5-pi-pins {
 				pins = "PI10", "PI11";
 				function = "uart5";
 			};
 
+			/omit-if-no-ref/
+			uart6_pa_pins: uart6-pa-pins {
+				pins = "PA12", "PA13";
+				function = "uart6";
+			};
+
 			uart6_pi_pins: uart6-pi-pins {
 				pins = "PI12", "PI13";
 				function = "uart6";
 			};
 
+			/omit-if-no-ref/
+			uart7_pa_pins: uart7-pa-pins {
+				pins = "PA14", "PA15";
+				function = "uart7";
+			};
+
 			uart7_pi_pins: uart7-pi-pins {
 				pins = "PI20", "PI21";
 				function = "uart7";
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
