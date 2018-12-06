Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,TVD_SUBJ_WIPE_DEBT,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E335C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:11:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 482E22082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="deSPeVnZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="mBiu1gqu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 482E22082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=b73BIKDTThJ9npAEyEjQ/E8Gcvu2jXNeuGfCfH5j3R8=; b=deSPeVnZvvcMWBS7hz36mSf38m
	jkwu73cmmdeV2eakqOpNcgMGs2rtfeJsUA5DKXID96YD/fZMcy41N64wQ1vMiDDOaWfB+TVQi6LkR
	cAAeHIatHozKKJP440bTbyb/1RMt3HbAvpea0xzohm0lUlXEhZdC9yUWVfrqKPYfYfoCCo3McnvmS
	mML1JiZ8/Dj8jspA0SawaCorbJMQugFiaQF6X3FKX3RpIHeRsiLA4ukBTNt4bV7lP6DfmRztJXbZJ
	zr/SnlmCnOitDO/z00i821o4O5dWyzz5BeYUgqfSMdTNnVAAibcst2S/Tl02eaGgpkU5P5sBOW/Rv
	RFlnTF+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV1rD-00067O-Co; Thu, 06 Dec 2018 22:10:55 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV1qr-00021y-2Y
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 22:10:45 +0000
Received: from penelope.horms.nl (unknown [64.124.208.80])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 2DCE525BF34;
 Fri,  7 Dec 2018 08:58:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544133539; bh=Ca//DX0CxDcZuAYIPTnxewv+63JMcO9rNwQxC5D7MTs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mBiu1gqu2ipMzFXomKJwCFFX3Xv92sff3BgODfsCzM2K5OpLZfJOtNDq8wLZwxId5
 EvnQlOgYxrhEPzEoEu5eENvIge1/RkSU19d6xIdhY+LwWeZNNpQeAT22pCjpQA57M2
 7H1lGgGSmt5qZ4r9bCsavxmGG22bpRHeC5UvELE0=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id 1B1BEE21709; Thu,  6 Dec 2018 13:58:58 -0800 (PST)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 1/9] soc: renesas: r8a77965-sysc: Remove non-existent A3IR
 power domain
Date: Thu,  6 Dec 2018 13:58:49 -0800
Message-Id: <a93913cecb3c98c2310da42a9650cfd817fb00b8.1544131943.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1544131943.git.horms+renesas@verge.net.au>
References: <cover.1544131943.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_141033_413894_D75ACAA3 
X-CRM114-Status: UNSURE (   9.05  )
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
 Geert Uytterhoeven <geert+renesas@glider.be>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The R-Car Gen3 HardWare Manual Errata for Rev. 0.80 (Feb 28, 2018)
removed the A3IR power domain on R-Car M3-N, as this SoC does not have
an Image Processing Unit (IMP-X5).

The definition in the DT bindings header cannot be removed yet, until
its (incorrect) user has been removed.

Fixes: a527709b78b3c997 ("soc: renesas: rcar-sysc: Add R-Car M3-N support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/soc/renesas/r8a77965-sysc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soc/renesas/r8a77965-sysc.c b/drivers/soc/renesas/r8a77965-sysc.c
index d7f7928e3c07..e0533beb50fd 100644
--- a/drivers/soc/renesas/r8a77965-sysc.c
+++ b/drivers/soc/renesas/r8a77965-sysc.c
@@ -28,7 +28,6 @@ static const struct rcar_sysc_area r8a77965_areas[] __initconst = {
 	{ "a2vc1",	0x3c0, 1, R8A77965_PD_A2VC1,	R8A77965_PD_A3VC },
 	{ "3dg-a",	0x100, 0, R8A77965_PD_3DG_A,	R8A77965_PD_ALWAYS_ON },
 	{ "3dg-b",	0x100, 1, R8A77965_PD_3DG_B,	R8A77965_PD_3DG_A },
-	{ "a3ir",	0x180, 0, R8A77965_PD_A3IR,	R8A77965_PD_ALWAYS_ON },
 };
 
 const struct rcar_sysc_info r8a77965_sysc_info __initconst = {
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
