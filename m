Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53140C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:34:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2275020857
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cnNJb3M3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="G56+r7bl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2275020857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=9Stzq/JHe1dKNXkeApzlGelQrlvpgx2mW6kMUBr7kBw=; b=cnN
	Jb3M3zP2A8EcoMNwmYmOAy2rsWN67e63gxClaG9pAFn3oV+13YS2BUzkC7X4k0q6s4lSzDAR3usmh
	o1gRoV7I04NQU0B6Lva12Q/GisJq36t6l2DLd+JA2Hjo5lj5LaE7lJL/hhyGNhpiPWcwNzF7gfS+S
	YQUe+Ga+AdYJm+FbgGDbpDQfcGMSEcPxuveLw+Drga3vEL4T2iflQP5ac94I0B+Le2Qoo8Pr9zKxn
	a6jCgjHbsOhVUe7E+sr1DU8wppf4RoihoW2ti/JiNDAvp6w+ndB3BchVjrosiHnqNU/fOZ8vThzic
	A8QPzFfr21mhlTTSjqOhR/rwCMMtgGw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goqwR-0007v2-KW; Wed, 30 Jan 2019 14:34:15 +0000
Received: from m50-132.163.com ([123.125.50.132])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goqwM-0007u7-QK; Wed, 30 Jan 2019 14:34:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=uE4/UP5wc0l4lhT37E
 UPqa3KyorclaOmvJ65eSZXlfA=; b=G56+r7blu6cYyLBmu59XFOvXAzLlzT9M77
 8e2nzkm5TbuAPfYo2/y0fulYDApJMAMVMAesECP88nPuXMQrdu11NuuWSylFIm8o
 r25HPaOVQFzYBdYucRJt/M2ThLkTkPRLc2lMCVK6mTS9cZEhCSb82OrqlQO+YiNL
 oX6jRmxoM=
Received: from localhost.localdomain (unknown [27.42.92.102])
 by smtp2 (Coremail) with SMTP id DNGowAC30CfBtVFcdxHPAg--.1390S3;
 Wed, 30 Jan 2019 22:33:53 +0800 (CST)
From: lsh <lshua312@163.com>
To: lgirdwood@gmail.com
Subject: [PATCH] ASoC: rockchip: fix small typo
Date: Wed, 30 Jan 2019 22:33:35 +0800
Message-Id: <1548858815-20161-1-git-send-email-lshua312@163.com>
X-Mailer: git-send-email 1.9.1
X-CM-TRANSID: DNGowAC30CfBtVFcdxHPAg--.1390S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr1UJF1DWr43ZrWrXFy5Jwb_yoWDGrg_t3
 47WFyUu3y8urWfA3yUGasxAws3Z3ZIkFyUGF1YyF4UJFn8Ca4rGFy8Jw17uFZxWa1Sg3sY
 9r1YvrW3Jr1rtjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRf-P5UUUUU==
X-Originating-IP: [27.42.92.102]
X-CM-SenderInfo: 5ovk3tqtrsqiywtou0bp/xtbBDgRLalra-A3ZCQABsL
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_063411_314560_F59CA514 
X-CRM114-Status: UNSURE (   7.62  )
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
Cc: alsa-devel@alsa-project.org, heiko@sntech.de, linux-kernel@vger.kernel.org,
 lsh <lshua312@163.com>, tiwai@suse.com, perex@perex.cz,
 linux-rockchip@lists.infradead.org, broonie@kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

codec_dai -> cpu_dai

Signed-off-by: lsh <lshua312@163.com>
---
 sound/soc/rockchip/rockchip_rt5645.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_rt5645.c b/sound/soc/rockchip/rockchip_rt5645.c
index 881c324..f88adf0 100644
--- a/sound/soc/rockchip/rockchip_rt5645.c
+++ b/sound/soc/rockchip/rockchip_rt5645.c
@@ -95,14 +95,16 @@ static int rk_aif1_hw_params(struct snd_pcm_substream *substream,
 	ret = snd_soc_dai_set_sysclk(cpu_dai, 0, mclk,
 				     SND_SOC_CLOCK_OUT);
 	if (ret < 0) {
-		dev_err(codec_dai->dev, "Can't set codec clock %d\n", ret);
+		dev_err(cpu_dai->dev,
+			"Can't set clock for cpu_dai %d\n", ret);
 		return ret;
 	}
 
 	ret = snd_soc_dai_set_sysclk(codec_dai, 0, mclk,
 				     SND_SOC_CLOCK_IN);
 	if (ret < 0) {
-		dev_err(codec_dai->dev, "Can't set codec clock %d\n", ret);
+		dev_err(codec_dai->dev,
+			"Can't set clock for codec_dai %d\n", ret);
 		return ret;
 	}
 
-- 
1.9.1



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
