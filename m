Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABF2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:49:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F5D42177E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZZhGUpRv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="G0kq8j3f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F5D42177E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:Message-Id:
	In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	References:List-Owner; bh=owXx07kHFmEZTTcGjUT6xGuRFFB3BBYTpLkzeo253HA=; b=ZZh
	GUpRvPOdhpDSgk/pATr+8v8UY7IupoLcyx+9nOD1HqL5sB5zrHZC+JamtMSqP26yISFYz52RjOy5H
	BmSucO9fynG032iZCpNW0gbZD+D/JuNirujuwHMsyWvBslwVf9WODxt5aR8iAENS5K3EOpohmiMSz
	voR25Sq2XOxSfsYDN0Amd8zwWcAW7l/HtsocAv/HIf1ANduv6CkbzFalY2q3V/zYZqoWA5YiSOF0v
	pGoz+XzOGWc5UHoGM2iPqh4ziqQNQTF1MS8V4tSV/aqlPMdD8MVvfP3ko4WSMFfDr3HFhvZLCV+mo
	51fD9uc+zykcDIkQG2z/HXrGNUdQWHQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvnyv-00058h-Gz; Mon, 18 Feb 2019 18:49:33 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvnys-00057u-6t
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 18:49:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=39BnjRBP3mAF1mj98V17S7lBxoprAgwGQFFxs8scGXw=; b=G0kq8j3fA/nT
 WsohoCUvuOH3V2iTvkp3rNj/ClOXcSjW0TSr0qalCpXG1LLzr5+ohQbOjJ7Cs3iJnmJFwPSU9sU8a
 dlPagFXxQz9tYBwYjZN+tKio7ezI1gXfn2jfHQRjCHpRBVXMaSkbEBPPeKhgNaPGrqKpQsHpZBupB
 y6hTI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gvnyg-0001dc-CQ; Mon, 18 Feb 2019 18:49:18 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id CDEC21128008; Mon, 18 Feb 2019 18:49:17 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: YueHaibing <yuehaibing@huawei.com>
Subject: Applied "ASoC: stm32: sai: remove set but not used variables 'mask,
 cr1'" to the asoc tree
In-Reply-To: <20190218145026.142805-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190218184917.CDEC21128008@debutante.sirena.org.uk>
Date: Mon, 18 Feb 2019 18:49:17 +0000 (GMT)
X-Bad-Reply: In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_104930_397132_EBF472D6 
X-CRM114-Status: GOOD (  14.96  )
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
Cc: alsa-devel@alsa-project.org, Olivier Moysan <olivier.moysan@st.com>,
 kernel-janitors@vger.kernel.org, Arnaud Pouliquen <arnaud.pouliquen@st.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The patch

   ASoC: stm32: sai: remove set but not used variables 'mask, cr1'

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

From 70605450fd42060783b0072a61a30f42a74f2917 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Mon, 18 Feb 2019 14:50:26 +0000
Subject: [PATCH] ASoC: stm32: sai: remove set but not used variables 'mask,
 cr1'

Fixes gcc '-Wunused-but-set-variable' warning:

sound/soc/stm/stm32_sai_sub.c: In function 'stm32_sai_configure_clock':
sound/soc/stm/stm32_sai_sub.c:902:11: warning:
 variable 'mask' set but not used [-Wunused-but-set-variable]
sound/soc/stm/stm32_sai_sub.c:902:6: warning:
 variable 'cr1' set but not used [-Wunused-but-set-variable]

It's not used any more after 8307b2afd386 ("ASoC: stm32: sai: set sai as
mclk clock provider")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index d4825700b63f..f9297228c41c 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -898,7 +898,7 @@ static int stm32_sai_configure_clock(struct snd_soc_dai *cpu_dai,
 				     struct snd_pcm_hw_params *params)
 {
 	struct stm32_sai_sub_data *sai = snd_soc_dai_get_drvdata(cpu_dai);
-	int cr1, mask, div = 0;
+	int div = 0;
 	int sai_clk_rate, mclk_ratio, den;
 	unsigned int rate = params_rate(params);
 
@@ -943,10 +943,8 @@ static int stm32_sai_configure_clock(struct snd_soc_dai *cpu_dai,
 		} else {
 			if (sai->mclk_rate) {
 				mclk_ratio = sai->mclk_rate / rate;
-				if (mclk_ratio == 512) {
-					mask = SAI_XCR1_OSR;
-					cr1 = SAI_XCR1_OSR;
-				} else if (mclk_ratio != 256) {
+				if ((mclk_ratio != 512) &&
+				    (mclk_ratio != 256)) {
 					dev_err(cpu_dai->dev,
 						"Wrong mclk ratio %d\n",
 						mclk_ratio);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
