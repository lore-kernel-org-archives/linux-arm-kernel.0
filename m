Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E990FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:09:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE01F21872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sWHMDRFo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="OpGcAA4I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE01F21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:Message-Id:
	In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	References:List-Owner; bh=TvIrKk/Rdn0uF1dRDK4M1wdqo/YMJtlGE+rvWzUW6F4=; b=sWH
	MDRFoOIYtRNDI36gZjMC/2GUiKjUYyQ2JNjO8G4YadvSSmtJrxv+Uz1GOUhmO33LiLFFQGBjuKJtC
	JZIo3NICK+GPZ6FLpDGlDpzsjXOoEv2rxtEl69oRjtvc+VtU+eFgdmelV2oBqxG9ytnG8tADit/7z
	/n18nPoQFgJHljnPd0NnbunLmt38hWun1r/9JNjLrxRNYzrXNj4TrQUpvtz+lDl+5C+m7saJr1VOo
	CDWmJuA2YXRPrV7G9A6dCQ3Pkd2iX8Ce6A1OqnvIMl7B0oMAytrESBZeKj1h8BgGGZv5VJPnvdQKi
	WBM6BBrWa8uUZMg8mO2o5Mdx6ssnOhw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfSyN-0004lZ-Ug; Fri, 04 Jan 2019 17:09:27 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfSyA-0004az-Ai
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 17:09:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=3y1c1EwtmnNivFTAO73FR96MsE0ZaeLS1CkdLRIO7wY=; b=OpGcAA4I50lT
 KO/UVxKahoJ/rSQd45NbYbMRzWx9Lo8BrLX9m2hzK2Apuz4UuKnRnvjix5WisY/jicXcA7RYvg9lO
 68NANLUhDQb1eMuVed14RuIt+Hs8xkQtCdkBKJxkfH1gh1Aa5vHaWzOJyIx4aj8VLgtapLh1shV7e
 Uqo9M=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gfSy3-0001pK-3m; Fri, 04 Jan 2019 17:09:07 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id A911711270A3; Fri,  4 Jan 2019 17:09:06 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Gustavo A. R. Silva <gustavo@embeddedor.com>
Subject: Applied "ASoC: xlnx: fix error handling in xlnx_formatter_pcm_probe"
 to the asoc tree
In-Reply-To: <20181226211106.GA16692@embeddedor>
X-Patchwork-Hint: ignore
Message-Id: <20190104170906.A911711270A3@debutante.sirena.org.uk>
Date: Fri,  4 Jan 2019 17:09:06 +0000 (GMT)
X-Bad-Reply: In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_090914_587078_6F582860 
X-CRM114-Status: GOOD (  14.64  )
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Takashi Iwai <tiwai@suse.com>,
 Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>,
 Michal Simek <michal.simek@xilinx.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The patch

   ASoC: xlnx: fix error handling in xlnx_formatter_pcm_probe

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 1d38b4e903d577f05393eb0ac6727f40d90dd6c6 Mon Sep 17 00:00:00 2001
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Wed, 26 Dec 2018 15:11:06 -0600
Subject: [PATCH] ASoC: xlnx: fix error handling in xlnx_formatter_pcm_probe

Currently, if platform_get_irq_byname() fails, the returned error
turns into a huge value, once it is being store into a variable
of type unsigned int, hence never actually reporting any error
and causing unexpected behavior when using the values stored
in aud_drv_data->s2mm_irq and aud_drv_data->mm2s_irq.

Fix this by changing the type of variables s2mm_irq and mm2s_irq in
structure xlnx_pcm_drv_data from unsigned int to int.

Addresses-Coverity-ID: 1476096 ("Unsigned compared against 0")
Fixes: 796175a94a7f ("ASoC: xlnx: add pcm formatter platform driver")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/xilinx/xlnx_formatter_pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/xilinx/xlnx_formatter_pcm.c b/sound/soc/xilinx/xlnx_formatter_pcm.c
index f7235f7664d7..d2194da928e7 100644
--- a/sound/soc/xilinx/xlnx_formatter_pcm.c
+++ b/sound/soc/xilinx/xlnx_formatter_pcm.c
@@ -76,8 +76,8 @@ struct xlnx_pcm_drv_data {
 	void __iomem *mmio;
 	bool s2mm_presence;
 	bool mm2s_presence;
-	unsigned int s2mm_irq;
-	unsigned int mm2s_irq;
+	int s2mm_irq;
+	int mm2s_irq;
 	struct snd_pcm_substream *play_stream;
 	struct snd_pcm_substream *capture_stream;
 	struct clk *axi_clk;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
