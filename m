Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649D2C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:16:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CE18222BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jPdXCcuI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE18222BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=pRn98tJGnCfQANvKMbC9p/RC9J4BCBoLOigjSkiT770=; b=jPdXCcuIPjbTGD
	c2A4R8sf1fI9nahqhTZDsY42CBQjLxq83CnXJVuUYwdiel0w7GTZuLLIt2fPZ/uY4+J06TAf3zohF
	62fBYpyOKWSaAbSiqXBxKoXqMBBbqGXs/2+JH63/6vkNz//UgqICiH+uxAF30Ubdx2l5GqOeG6L+8
	XHsW2PR3M3K6rf09+rliTAVmmYC7GBqxJCJVoqL0nrTPYiAS9NiBQ0MwyFPKKw3FFKWU/5QxlCfW5
	NEHlA7lYE4Ob0BvqLsBqwmcGnnZSBleEzmVDg56slpfML/apoQlaDgoUirhaMN5EEftdRhpM3FAWL
	j/71/dJauChbVbLitQRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtnpw-0001da-Uh; Wed, 13 Feb 2019 06:16:00 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtnpu-0001d2-6P; Wed, 13 Feb 2019 06:15:59 +0000
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id E4EE4AA3299B7F6C5ED5;
 Wed, 13 Feb 2019 14:15:47 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.408.0; Wed, 13 Feb 2019 14:15:41 +0800
From: Wei Yongjun <weiyongjun1@huawei.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, Shunli Wang <shunli.wang@mediatek.com>
Subject: [PATCH -next] ASoC: mediatek: mt8183: make some functions static
Date: Wed, 13 Feb 2019 06:29:44 +0000
Message-ID: <20190213062944.146366-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_221558_407974_F3DBCDE6 
X-CRM114-Status: UNSURE (   8.46  )
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
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 Wei Yongjun <weiyongjun1@huawei.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Fixes the following sparse warnings:

sound/soc/mediatek/mt8183/mt8183-dai-i2s.c:966:5: warning:
 symbol 'mt8183_dai_i2s_get_share' was not declared. Should it be static?
sound/soc/mediatek/mt8183/mt8183-dai-i2s.c:986:5: warning:
 symbol 'mt8183_dai_i2s_set_priv' was not declared. Should it be static?

Fixes: a94aec035a12 ("ASoC: mediatek: mt8183: add platform driver")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/mediatek/mt8183/mt8183-dai-i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-dai-i2s.c b/sound/soc/mediatek/mt8183/mt8183-dai-i2s.c
index c25024f72e72..777e93d70bea 100644
--- a/sound/soc/mediatek/mt8183/mt8183-dai-i2s.c
+++ b/sound/soc/mediatek/mt8183/mt8183-dai-i2s.c
@@ -963,7 +963,7 @@ static const struct mtk_afe_i2s_priv mt8183_i2s_priv[DAI_I2S_NUM] = {
 	},
 };
 
-int mt8183_dai_i2s_get_share(struct mtk_base_afe *afe)
+static int mt8183_dai_i2s_get_share(struct mtk_base_afe *afe)
 {
 	struct mt8183_afe_private *afe_priv = afe->platform_priv;
 	const struct device_node *of_node = afe->dev->of_node;
@@ -983,7 +983,7 @@ int mt8183_dai_i2s_get_share(struct mtk_base_afe *afe)
 	return 0;
 }
 
-int mt8183_dai_i2s_set_priv(struct mtk_base_afe *afe)
+static int mt8183_dai_i2s_set_priv(struct mtk_base_afe *afe)
 {
 	struct mt8183_afe_private *afe_priv = afe->platform_priv;
 	struct mtk_afe_i2s_priv *i2s_priv;




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
