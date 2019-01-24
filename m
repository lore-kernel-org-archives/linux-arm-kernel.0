Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A29AC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:27:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDA8B218AE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="exEat2DM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="NrocfVFy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA8B218AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=tOj4v8FTUKNhLPZJz9gn+vSxt55EpUJ+a6PtvbCB9J8=; b=exEat2DM+/ylDh9AXO7LA/itlj
	dh61pASF4fytJyHuT2JItlk2pmspsM+zX2nf0CVjUZGRiRyJ0+vfBKmRuxAdFXfstNZOIlr2/ziP9
	xBsxoCZKcSMBOcO6i0wJL0dSZghc0p26im/AOWsFcKE5aZ4GKdrEzksIA9LOHhVOwcTGYOKCv1+yh
	Py/vulJCH1p1qMGpQncdk1TIehTze4w4OgQLDAG0QeQCtGVn+ywFD97mjmBK2Zh1pCeS+/Wr7bDqq
	EVaoMYhXuTCeDEuDlpcsjNgJTIZ9fUiDl5WMXrqxYuMPPWFp8ZwgFqWiy7RvUP1KAZIsoJFTa3xa6
	jCcwodxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmguq-0000rT-TK; Thu, 24 Jan 2019 15:27:40 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmgqP-0007Ii-Rf
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 15:23:07 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 04FB325BF19;
 Fri, 25 Jan 2019 02:12:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1548342769; bh=FVv2yxGQcEYPDbykkdoY1N9O1as+GmnTeHaydBwLxjg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NrocfVFyKs1JJhS0XAIn+qLmnaSRMagWsoP6Dz9LUf+OoBDJpcka1uUQKwrwVWM7J
 rYaMaNgQ02e/2BLDv8IkT2iG58VsdjW+6RathX8p2EiwE62ri1YW67tM2VgNvD0Tr3
 sRD0/va+OZq59PnAwudiqwEXYBaCQGwhqcYfRaxU=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 229C2940DB0; Thu, 24 Jan 2019 16:12:41 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 34/44] arm64: dts: renesas: ulcb: use audio-graph-card
Date: Thu, 24 Jan 2019 16:12:28 +0100
Message-Id: <5d3b226ace6d8d6f1a9fecbfb21e7e743a88f33c.1548233325.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1548233325.git.horms+renesas@verge.net.au>
References: <cover.1548233325.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_072306_044284_9B2E9502 
X-CRM114-Status: GOOD (  11.08  )
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

ULCB can use daughter board which is called as KingFisher.
It has extra sound interface, thus we want to use it.
But, basically, ALSA SoC can't use Multiple sound card with single
CPU sound interface (= SSI). Thus we need to use Single Sound Card
with multiple DAI interface.

To be easy to expand ULCB sound card on KingFisher, it is better to
use multi-dai-link style sound card on ULCB sound DT.

Now, "simple-audio-card" / "audio-graph-card" both can support
multi-dai-link style, but HDMI sound support (which is not yet supported
on ULCB) needs "audio-graph-card".
Using audio-graph-card is better selection.
This patch exchange current sound card to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/ulcb.dtsi | 39 ++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/ulcb.dtsi b/arch/arm64/boot/dts/renesas/ulcb.dtsi
index de694fdae067..8c6c45863ac8 100644
--- a/arch/arm64/boot/dts/renesas/ulcb.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb.dtsi
@@ -83,20 +83,11 @@
 		regulator-always-on;
 	};
 
-	rsnd_ak4613: sound {
-		compatible = "simple-audio-card";
+	sound_card: sound {
+		compatible = "audio-graph-card";
+		label = "rcar-sound";
 
-		simple-audio-card,format = "left_j";
-		simple-audio-card,bitclock-master = <&sndcpu>;
-		simple-audio-card,frame-master = <&sndcpu>;
-
-		sndcpu: simple-audio-card,cpu {
-			sound-dai = <&rcar_sound>;
-		};
-
-		sndcodec: simple-audio-card,codec {
-			sound-dai = <&ak4613>;
-		};
+		dais = <&rsnd_port0>;
 	};
 
 	vcc_sdhi0: regulator-vcc-sdhi0 {
@@ -211,6 +202,12 @@
 		asahi-kasei,out4-single-end;
 		asahi-kasei,out5-single-end;
 		asahi-kasei,out6-single-end;
+
+		port {
+			ak4613_endpoint: endpoint {
+				remote-endpoint = <&rsnd_for_ak4613>;
+			};
+		};
 	};
 
 	cs2000: clk-multiplier@4f {
@@ -384,10 +381,18 @@
 		 <&audio_clk_c>,
 		 <&cpg CPG_CORE CPG_AUDIO_CLK_I>;
 
-	rcar_sound,dai {
-		dai0 {
-			playback = <&ssi0 &src0 &dvc0>;
-			capture  = <&ssi1 &src1 &dvc1>;
+	ports {
+		rsnd_port0: port {
+			rsnd_for_ak4613: endpoint {
+				remote-endpoint = <&ak4613_endpoint>;
+
+				dai-format = "left_j";
+				bitclock-master = <&rsnd_for_ak4613>;
+				frame-master = <&rsnd_for_ak4613>;
+
+				playback = <&ssi0 &src0 &dvc0>;
+				capture  = <&ssi1 &src1 &dvc1>;
+			};
 		};
 	};
 };
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
