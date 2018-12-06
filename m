Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9239EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:00:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60ADD214C1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dnBJk2ZS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="sF8sJRmu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60ADD214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=D3G5bU/w364TkYGJ7YGhRbRlCmvHPswxbiLiWvjvFfQ=; b=dnBJk2ZStsDj3ww2xjeRaUBpVD
	SyU+XnDYhb4Nz+X3MipP1XiSMfc74MWJlbgu1S+Qc/0zOEmPxY4fk6FQKjnXQK5e2P1O34J1RHP89
	oL+q+x1w6ImGonYgkfjltj6lTwIt8rATKr4rRJFRfTOt7b32Zfn1wYoMEc6rMYiy3h4UCn9UGcJTb
	uF28qZuRMdUApMWdyuexT7+Kxhn2y3FolWLYGe29zEchUTzJIE4mRCIEtiRaAVvQfSUr4RT5yGT/n
	LsmFdQvTh51Ki4rU0h0/4qtcxLW9pbocCOeZjesU/AUoOwZppC7tuRUTPf6DQSlKKBVrGWIqDYzmF
	VC2VUfDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV1gx-0002L5-44; Thu, 06 Dec 2018 22:00:19 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV1gX-00077Q-Qu
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 22:00:03 +0000
Received: from penelope.horms.nl (unknown [64.124.208.80])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 37CE225B7CA;
 Fri,  7 Dec 2018 08:58:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544133512; bh=xQWJNQdlM8K++2SMyxIggJxeBqzUQAjjWlW4fkU5Po4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sF8sJRmuHFGZBO8SF7YfypzQKqsEVMTlsd1PM4Z8x0GIlyFIP0ow2ZAYnNkR4rowB
 EhfxIDDQbp6eBbIi8JCu3LPEBkuHQDfX1OcXksSi2gJlyrkkTKh0OKKv6PAqToYCpr
 DKd02ROwnRj9wvXtKcJmpS6Q8vIV5hbSoWZdjUEI=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id 0F7D0E21700; Thu,  6 Dec 2018 13:58:31 -0800 (PST)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 01/34] ARM: dts: r8a7743: Remove legacy "renesas,
 rcar-thermal" compatibility
Date: Thu,  6 Dec 2018 13:57:56 -0800
Message-Id: <6d2372fc77e45f23b1d20d9fe2844d2978ad9c93.1544125558.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1544125558.git.horms+renesas@verge.net.au>
References: <cover.1544125558.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_135954_571471_1A27F792 
X-CRM114-Status: GOOD (  11.73  )
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
 Geert Uytterhoeven <geert+renesas@glider.be>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The thermal hardware description for the RZ/G1M SoC was added to its DTS
after the introduction of support for thermal zones, and included a
thermal-zones node from the beginning.

Hence there is no need to claim compatibility with
"renesas,rcar-thermal", which would be needed only for backwards
compatibility with kernels predating thermal zone support.

Fixes: 6c76b4f7d89e89f0 ("ARM: dts: r8a7743: Add thermal device to DT")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7743.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 24715f74ae08..3cc33f7ff7fe 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -348,8 +348,7 @@
 
 		thermal: thermal@e61f0000 {
 			compatible = "renesas,thermal-r8a7743",
-				     "renesas,rcar-gen2-thermal",
-				     "renesas,rcar-thermal";
+				     "renesas,rcar-gen2-thermal";
 			reg = <0 0xe61f0000 0 0x10>, <0 0xe61f0100 0 0x38>;
 			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 522>;
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
