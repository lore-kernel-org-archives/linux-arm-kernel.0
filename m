Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85186C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:25:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E2C721855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WI+yvy3F";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="mTX+r55Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E2C721855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=6G0wsWFJBVUZhD118wuI9GEuqo3DlRd3Kwpr+/FumaM=; b=WI+yvy3FpfUWvizDLcK1R1HtCr
	AN3bMwyjps0trttWdb4FZztI8jX/DgL09luOlRrNn4Av9at1ofrEStmWkZIS9ZuE7fqO4owSJxerL
	2v08jZHVxZ9ZuvclNrHZRsu/IEJb36WeV2yrRXwkP5nKVxeU+DyZwfvmq58JeQBfD/nng1q7jdhyC
	andqdPdt7GDMLMYgUvk8kfFI8NA2Xe9wDHi6lgvqUQ4fSkT+AHXl46WW8D98Ln/Y1e3J18XUhzgKn
	l2ChsplOlWM19NZ3bvZMW4z/uiokLOqjyOdwrYkGnTvjMp+Ui2Y5ReCXHnq9KQx74FY1cIu8w95po
	gdloE8YA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmgsF-0005JL-1a; Thu, 24 Jan 2019 15:24:59 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmgnw-0007Ii-4X
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 15:21:14 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 3744D25BF07;
 Fri, 25 Jan 2019 02:12:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1548342765; bh=TreSCN3Pe5S2++jf2ABiYkjw/BXPtHBQKTYnlv+x3Vc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mTX+r55QjvwiInVMNRYbvf4vrZkTRhrL+vY+LgcsQWL2PsOfO2a0sgoKm6JJ74/VR
 fyRpuqXNbiU8r7EhHdrk1JemBavOkr8/SFCpUjNQfJWPMH07jvQB2/ZIJYv575Y/VN
 g/UCDoGO53jPQXoi+OzydfUn20QtKmQ84Fmoc3Js=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 5EFCD940E09; Thu, 24 Jan 2019 16:12:41 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 39/44] arm64: dts: renesas: r8a77990-ebisu: use
 simple-audio-card
Date: Thu, 24 Jan 2019 16:12:33 +0100
Message-Id: <868a49d6f9d915a16f4fa223083eab6fbcbefcbf.1548233325.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1548233325.git.horms+renesas@verge.net.au>
References: <cover.1548233325.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_072032_730631_C7147032 
X-CRM114-Status: UNSURE (   9.72  )
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

Current Ebisu board is using simple-scu-audio-card
which is used for Sampling Rate Convert, or MIXer, etc.
But, Ebisu is not using such feature.
Then, simple-audio-card is very enough.
This patch fixup it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
index 8b66ee86e7bb..e0590c0af4c4 100644
--- a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
@@ -169,16 +169,13 @@
 	};
 
 	rsnd_ak4613: sound {
-		compatible = "simple-scu-audio-card";
+		compatible = "simple-audio-card";
 
 		simple-audio-card,name = "rsnd-ak4613";
 		simple-audio-card,format = "left_j";
 		simple-audio-card,bitclock-master = <&sndcpu>;
 		simple-audio-card,frame-master = <&sndcpu>;
 
-		simple-audio-card,prefix = "ak4613";
-		simple-audio-card,routing = "ak4613 Playback", "DAI0 Playback",
-		"DAI0 Capture", "ak4613 Capture";
 		sndcpu: simple-audio-card,cpu {
 			sound-dai = <&rcar_sound>;
 		};
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
