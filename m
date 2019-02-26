Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393E8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:23:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03AF22173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LTicsmxZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="EybjA7Fp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03AF22173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:Message-Id:
	In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	References:List-Owner; bh=ulZzcLaJiS2QgB1t2n+RFEbJ3pyG1NpnsYCAn439RXE=; b=LTi
	csmxZO1Besh0z+/cfx2fJjLra8iNT+lVEFEMP/vZK3g1bpFgnMEhBK8S1EqFz/FHDk/iqc6Y6k7+G
	lgc/9TDd8xq8aooZIYLAWCBkroMYAGyYXzfhX+uO7d+PT3S9JwcI8M2A8fQB9YxktehDYQ1vSurTy
	UaynXWJKAKBCj++MgmeB1Yaa86mCOZmFQeyEPjgTdk5EUMzim08wroo85ym5jJUnmxlQmdw7KIK8O
	WYIVp18jK18bZY7cQI0zz0ZnrrZwwYzvGgV77ECfxNmkN5qD7g3UMt6Bqc24TsXq8nlb7TVajhFVX
	/JN7BbWqvR0KbTEm2llreOweYrqgg7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyfW8-0001vd-SC; Tue, 26 Feb 2019 16:23:40 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyfVB-0000a0-IL
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 16:22:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=CsiXLuPX7iUWE73DoVzUKNQczrazZ6zsIbdcwSI/GQc=; b=EybjA7FpFQpM
 16e7Abu1v6P00IgFkDrBfamNPPjcZFvLe4LQMGbsuhyEY6dT6MS6P4vga4SG2PnTypXaf8rC40RLm
 OfOFI8/+2F1/m412SBOmhh/RIs/Oud7yjK4kGIWCN3gQbqYEFZafKMwifl2uYsdfwGkMbNwIlTPBQ
 llcno=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gyfV2-00009D-69; Tue, 26 Feb 2019 16:22:32 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id CD2071121A0A; Tue, 26 Feb 2019 16:22:31 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Olivier Moysan <olivier.moysan@st.com>
Subject: Applied "ASoC: stm32: i2s: fix stream count management" to the asoc
 tree
In-Reply-To: <1551189070-15469-4-git-send-email-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190226162231.CD2071121A0A@debutante.sirena.org.uk>
Date: Tue, 26 Feb 2019 16:22:31 +0000 (GMT)
X-Bad-Reply: In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_082241_867955_C4384EA8 
X-CRM114-Status: GOOD (  13.08  )
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
Cc: alsa-devel@alsa-project.org, olivier.moysan@st.com, alexandre.torgue@st.com,
 linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com, tiwai@suse.com,
 lgirdwood@gmail.com, broonie@kernel.org, mcoquelin.stm32@gmail.com,
 perex@perex.cz, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, benjamin.gaignard@st.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The patch

   ASoC: stm32: i2s: fix stream count management

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

From ebf629d502cf7aa138b86f36dc016faf6c8e39e3 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Tue, 26 Feb 2019 14:51:06 +0100
Subject: [PATCH] ASoC: stm32: i2s: fix stream count management

Move counter handling to trigger start section
to manage multiple start/stop events.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_i2s.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 7d4c67433916..7f56d7b51ba3 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -554,10 +554,6 @@ static int stm32_i2s_startup(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	spin_lock(&i2s->lock_fd);
-	i2s->refcount++;
-	spin_unlock(&i2s->lock_fd);
-
 	return regmap_write_bits(i2s->regmap, STM32_I2S_IFCR_REG,
 				 I2S_IFCR_MASK, I2S_IFCR_MASK);
 }
@@ -613,18 +609,19 @@ static int stm32_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 		regmap_write_bits(i2s->regmap, STM32_I2S_IFCR_REG,
 				  I2S_IFCR_MASK, I2S_IFCR_MASK);
 
+		spin_lock(&i2s->lock_fd);
+		i2s->refcount++;
 		if (playback_flg) {
 			ier = I2S_IER_UDRIE;
 		} else {
 			ier = I2S_IER_OVRIE;
 
-			spin_lock(&i2s->lock_fd);
 			if (i2s->refcount == 1)
 				/* dummy write to trigger capture */
 				regmap_write(i2s->regmap,
 					     STM32_I2S_TXDR_REG, 0);
-			spin_unlock(&i2s->lock_fd);
 		}
+		spin_unlock(&i2s->lock_fd);
 
 		if (STM32_I2S_IS_SLAVE(i2s))
 			ier |= I2S_IER_TIFREIE;
@@ -649,7 +646,6 @@ static int stm32_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 			spin_unlock(&i2s->lock_fd);
 			break;
 		}
-		spin_unlock(&i2s->lock_fd);
 
 		dev_dbg(cpu_dai->dev, "stop I2S\n");
 
@@ -657,8 +653,10 @@ static int stm32_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 					 I2S_CR1_SPE, 0);
 		if (ret < 0) {
 			dev_err(cpu_dai->dev, "Error %d disabling I2S\n", ret);
+			spin_unlock(&i2s->lock_fd);
 			return ret;
 		}
+		spin_unlock(&i2s->lock_fd);
 
 		cfg1_mask = I2S_CFG1_RXDMAEN | I2S_CFG1_TXDMAEN;
 		regmap_update_bits(i2s->regmap, STM32_I2S_CFG1_REG,
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
