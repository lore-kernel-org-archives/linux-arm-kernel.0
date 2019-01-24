Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15707C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:21:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4BB32184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NRvB1iiA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="c/JKp9cb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4BB32184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=4dJvDOapkywA9kDRNZydNP2T7a+OFf9epyz/2EE4Hyw=; b=NRvB1iiA6xqJPijuLC/whA2nfd
	XIDNJsjotYz/8YUziYvGwNVo9oQVDja0T5jioyk6wetOt175hr8l5xWgfOU8vGDhMW/OxKdl/As89
	G8P14yT2Iq81Db1Fk8udcR3UfCnqZyULI5TiFq4aTGjS5m9bJV7ptCwJHHQdFbVgRUaw+Z+RLU5MZ
	e7UK0uRmXtb8ggMda3Ac449iTXDuGaYiE8hazE2jCJDQmUjAVIbFDjuNn4J9WfUMo4O0j2mB04YiM
	c7E1btr72FI2mmzOhhBJmZSPs20BvrPI0ElsQoALuZlYKQfomwzVt6L3nR9SB3FY97YrHGVqc0SKT
	6A0EYqsg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmgpF-00039b-9B; Thu, 24 Jan 2019 15:21:53 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmgl1-0001GQ-62
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 15:17:38 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 9FD6925BF01;
 Fri, 25 Jan 2019 02:12:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1548342764; bh=UL3/AaVgzHyo666PafMYIJplrOvJCelX3JYLzEMeb6Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=c/JKp9cb+7MgZfoNXXeZdP9k0OKg/63T7xWuq6uXj2QdhujTDyS5ppPRImzHibxqy
 rUAsiL6DN7q+VwPQB3GD3LrgtrZzPLjtlIqNg0AfEeFGCq+2Lw6LujvoyGCKFFQD+9
 4bYTkKVypdjmUUcUJF6g5v0iUVvct7ClotbVD3eE=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 2B732940D7F; Thu, 24 Jan 2019 16:12:41 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 35/44] arm64: dts: renesas: ulcb: add HDMI sound support
Date: Thu, 24 Jan 2019 16:12:29 +0100
Message-Id: <c693b2101c9f84af65b128e6f834ef1ccf99ca23.1548233325.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1548233325.git.horms+renesas@verge.net.au>
References: <cover.1548233325.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_071732_146752_72BBF542 
X-CRM114-Status: GOOD (  11.74  )
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
Cc: Simon Horman <horms+renesas@verge.net.au>,
 Magnus Damm <magnus.damm@gmail.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch adds missing ULCB HDMI sound support.
To use sound card, HDMI video is mandatory.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/ulcb.dtsi | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/ulcb.dtsi b/arch/arm64/boot/dts/renesas/ulcb.dtsi
index 8c6c45863ac8..a3878fb3c3f1 100644
--- a/arch/arm64/boot/dts/renesas/ulcb.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb.dtsi
@@ -6,6 +6,14 @@
  * Copyright (C) 2016 Cogent Embedded, Inc.
  */
 
+/*
+ * SSI-AK4613
+ *	aplay   -D plughw:0,0 xxx.wav
+ *	arecord -D plughw:0,0 xxx.wav
+ * SSI-HDMI
+ *	aplay   -D plughw:0,1 xxx.wav
+ */
+
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 
@@ -87,7 +95,9 @@
 		compatible = "audio-graph-card";
 		label = "rcar-sound";
 
-		dais = <&rsnd_port0>;
+		dais = <&rsnd_port0	/* ak4613 */
+			&rsnd_port1	/* HDMI0  */
+			>;
 	};
 
 	vcc_sdhi0: regulator-vcc-sdhi0 {
@@ -173,6 +183,12 @@
 				remote-endpoint = <&hdmi0_con>;
 			};
 		};
+		port@2 {
+			reg = <2>;
+			dw_hdmi0_snd_in: endpoint {
+				remote-endpoint = <&rsnd_for_hdmi>;
+			};
+		};
 	};
 };
 
@@ -382,7 +398,10 @@
 		 <&cpg CPG_CORE CPG_AUDIO_CLK_I>;
 
 	ports {
-		rsnd_port0: port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		rsnd_port0: port@0 {
+			reg = <0>;
 			rsnd_for_ak4613: endpoint {
 				remote-endpoint = <&ak4613_endpoint>;
 
@@ -394,6 +413,18 @@
 				capture  = <&ssi1 &src1 &dvc1>;
 			};
 		};
+		rsnd_port1: port@1 {
+			reg = <1>;
+			rsnd_for_hdmi: endpoint {
+				remote-endpoint = <&dw_hdmi0_snd_in>;
+
+				dai-format = "i2s";
+				bitclock-master = <&rsnd_for_hdmi>;
+				frame-master = <&rsnd_for_hdmi>;
+
+				playback = <&ssi2>;
+			};
+		};
 	};
 };
 
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
