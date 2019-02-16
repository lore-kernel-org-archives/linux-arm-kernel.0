Return-Path: <SRS0=BOBm=QX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3B1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 18:22:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF9B421A4C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 18:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ozLbp2BX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9B421A4C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mansr.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=lwuWFMetGV0coa9NZVTbzS8hff7nUhbrLOclxFf5+DM=; b=ozLbp2BXWb2xiD
	zD8lCJtD95kMIouPdkF29Ul9tbA7ghgdMfPChQrXRILM3dYg7VGJnE6lkV3KAuwI/TxGE370IAllN
	fIKvmDTNy0JfIycOJhqW3/Tjnt7UIi+TLf1KtqVKJ8wK/3gKttAyV8l8WbVhqhZgXUDE3KixPwT7J
	ZflTeAx2LjyZzRQ96/QrDRGOkmISUPkahxpvKUKIukT/ikQxERZFlx73M0rV57/ggLL15304ZzY9o
	jI65gC5hNInwnFabhcY5G6mzkkciPKBrGzgMbeNOqk1dpUl/TxlVbm+nci2q0H/Ruu9Br2HI7A5xb
	1skZe16PdwpIDeEZJxYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gv4bY-00088L-9V; Sat, 16 Feb 2019 18:22:24 +0000
Received: from unicorn.mansr.com ([81.2.72.234])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gv4bG-00087N-El
 for linux-arm-kernel@lists.infradead.org; Sat, 16 Feb 2019 18:22:07 +0000
Received: by unicorn.mansr.com (Postfix, from userid 51770)
 id 885EB17C56; Sat, 16 Feb 2019 18:21:43 +0000 (GMT)
From: Mans Rullgard <mans@mansr.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
	Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH] ARM: dts: sun7i: add pinctrl for missing uart mux options
Date: Sat, 16 Feb 2019 18:21:32 +0000
Message-Id: <20190216182132.12895-1-mans@mansr.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190216_102206_657104_07FEE303 
X-CRM114-Status: UNSURE (   7.98  )
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
 arch/arm/boot/dts/sun7i-a20.dtsi | 45 ++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index af5b067a5f83..2295ff5adf48 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -944,6 +944,31 @@
 				function = "uart0";
 			};
 
+			uart0_pf_pins: uart0-pf-pins {
+				pins = "PF2", "PF4";
+				function = "uart0";
+			};
+
+			uart1_pa_pins: uart1-pa-pins {
+				pins = "PA10", "PA11";
+				function = "uart1";
+			};
+
+			uart1_cts_rts_pa_pins: uart1-cts-rts-pa-pins {
+				pins = "PA12", "PIA13";
+				function = "uart2";
+			};
+
+			uart2_pa_pins: uart2-pa-pins {
+				pins = "PIA2", "PIA3";
+				function = "uart2";
+			};
+
+			uart2_cts_rts_pa_pins: uart2-cts-rts-pa-pins {
+				pins = "PA0", "PIA1";
+				function = "uart2";
+			};
+
 			uart2_pi_pins: uart2-pi-pins {
 				pins = "PI18", "PI19";
 				function = "uart2";
@@ -969,6 +994,11 @@
 				function = "uart3";
 			};
 
+			uart3_cts_rts_ph_pins: uart3-cts-rts-ph-pins {
+				pins = "PH2", "PH3";
+				function = "uart3";
+			};
+
 			uart4_pg_pins: uart4-pg-pins {
 				pins = "PG10", "PG11";
 				function = "uart4";
@@ -979,16 +1009,31 @@
 				function = "uart4";
 			};
 
+			uart5_ph_pins: uart5-ph-pins {
+				pins = "PH6", "PH7";
+				function = "uart5";
+			};
+
 			uart5_pi_pins: uart5-pi-pins {
 				pins = "PI10", "PI11";
 				function = "uart5";
 			};
 
+			uart6_pa_pins: uart6-pa-pins {
+				pins = "PA12", "PA13";
+				function = "uart6";
+			};
+
 			uart6_pi_pins: uart6-pi-pins {
 				pins = "PI12", "PI13";
 				function = "uart6";
 			};
 
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
