Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B99C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:15:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8B1921906
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S3sWcDhy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="TM2KODKV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8B1921906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:Message-Id:
	In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	References:List-Owner; bh=+paj6Tux8IfOG/4PbzpxmRtdcgHt26c32P6btFJmKDc=; b=S3s
	WcDhyheJ4yVMNo7wM0smh+lelonidaASCPtfmlYNQgZViEtq7aJqPn6QBG3g5mgrHe9GK9ni1b+qK
	pA8ywEW5WFFMSBBspAQakpKtK9bdh75pWoZC8YWCez0pD+ReGZaOTFFveKkKcOIBTmwyelFThoZFQ
	Qx527NZjpkQC73bZdDSMzwGQjz2DocaGz+U/MtwCIAg1BhL3u3dT6T0+p77URvJJKD/8Xznd6KxEv
	c3gHvPB0YTys7FszwS2BNN288KzabS7clngHw9ide/rP2kn/En9N86iHi5sz2DEWh1nNxph4NxaB1
	250bVAIWKKXt/62i3mK9/QbDYfOLt1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaPKS-00004r-6V; Fri, 21 Dec 2018 18:15:20 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaPKP-0007TM-7U
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 18:15:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=nGj0bkijnCx3gJMubzNqFQYa/+Sd/+6on7euzubTFrc=; b=TM2KODKVb7ie
 ype7Gjq52Z+SS6K4mS4AHdMMbhCLLcAPzcs2TLmYrArAl3UVmllre1H4nxvCiOdrPPXk3C0HNhrj/
 /KimsXzs18dub3aT2PGx/kjBM9ZlUrc+uBFpigh73MiG9W03GVIN8MrCKqz/5fnZZcHNb8WP6iQpR
 nStKQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gaPK7-0003q7-A4; Fri, 21 Dec 2018 18:14:59 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id EB54D1121B93; Fri, 21 Dec 2018 18:14:58 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: Applied "ASoC: rockchip: add workaround for silence of rk3288 ACODEC"
 to the asoc tree
In-Reply-To: <20181220153636.5213-2-katsuhiro@katsuster.net>
X-Patchwork-Hint: ignore
Message-Id: <20181221181458.EB54D1121B93@debutante.sirena.org.uk>
Date: Fri, 21 Dec 2018 18:14:58 +0000 (GMT)
X-Bad-Reply: In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_101517_414948_FDE2719E 
X-CRM114-Status: GOOD (  15.33  )
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The patch

   ASoC: rockchip: add workaround for silence of rk3288 ACODEC

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

From 25af20ae05b95b63cfe655ca248b9dcbf904104c Mon Sep 17 00:00:00 2001
From: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Date: Fri, 21 Dec 2018 00:36:36 +0900
Subject: [PATCH] ASoC: rockchip: add workaround for silence of rk3288 ACODEC

This patch adds reset and precharge in shutdown of PCM device.

ACODEC goes to silence if we change Fs to 44.1kHz from 48kHz. This
workaround seems to work but I don't know this workaround is correct
sequence or not for ACODEC.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rk3328_codec.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rk3328_codec.c b/sound/soc/codecs/rk3328_codec.c
index 71f3fc2d970c..f3442a2283ea 100644
--- a/sound/soc/codecs/rk3328_codec.c
+++ b/sound/soc/codecs/rk3328_codec.c
@@ -261,9 +261,12 @@ static int rk3328_codec_close_playback(struct rk3328_codec_priv *rk3328)
 		mdelay(1);
 	}
 
+	/* Workaround for silence when changed Fs 48 -> 44.1kHz */
+	rk3328_codec_reset(rk3328);
+
 	regmap_update_bits(rk3328->regmap, DAC_PRECHARGE_CTRL,
 			   DAC_CHARGE_CURRENT_ALL_MASK,
-			   DAC_CHARGE_CURRENT_I);
+			   DAC_CHARGE_CURRENT_ALL_ON);
 
 	return 0;
 }
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
