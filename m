Return-Path: <SRS0=qjmB=PN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AACC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 02:04:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4503421871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 02:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gm8Rucgl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4503421871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=57JfUflooqNPX8KM38pGmeYcLrq8AfwmbHFfbx0bIUo=; b=gm8RucglvfvKkSlN3vIPxlWYFl
	f8YoVB+6uuYPysVuP1OpfaZFxmu6EkaK67cG9WBYMB8BSnRZfM2hlIoLcexpiecDsAgjgCf73642n
	Ha4pXAhlEEE9fabYKsd6S16Bsy+R6IJvcFn1+qbcL4qlJqQJSiWFkVCQttrfbBP2Outv+tDfHteHl
	lhtGiKpxkTwYwfL4xXkAA/pfLPDXj2URj6K4U6sFIqqIbBFArXB8Fhll2bTNN8Y+ueJB3qyTh8OPx
	GdZF1eSvzAUBXu0ENf7+KfKKWaa2rCuVX/KAsbOkifcgOLoJeon0CTmC+bMqP/zP1QMKmRNV/OMYM
	ODYY6neA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfbKA-0000GJ-AT; Sat, 05 Jan 2019 02:04:30 +0000
Received: from mga14.intel.com ([192.55.52.115])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfbK6-0000Fc-QK; Sat, 05 Jan 2019 02:04:28 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Jan 2019 18:04:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,441,1539673200"; d="scan'208";a="307634826"
Received: from kgandham-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.251.139.169])
 by fmsmga006.fm.intel.com with ESMTP; 04 Jan 2019 18:04:21 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 17/21] ASoC: mt6351: remove unneeded variable
Date: Fri,  4 Jan 2019 20:02:45 -0600
Message-Id: <20190105020249.8639-18-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
References: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_180426_863090_E89CC8CD 
X-CRM114-Status: GOOD (  10.03  )
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
Cc: Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.de,
 open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Jaroslav Kysela <perex@perex.cz>, liam.r.girdwood@linux.intel.com,
 broonie@kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 Kai Chieh Chuang <kaichieh.chuang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Reported by Coccinelle:
mt6351.c:1418:5-8: Unneeded variable: "ret". Return "0" on line 1437

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/mt6351.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/mt6351.c b/sound/soc/codecs/mt6351.c
index f73dcd753584..4b3ce01c5a93 100644
--- a/sound/soc/codecs/mt6351.c
+++ b/sound/soc/codecs/mt6351.c
@@ -1415,8 +1415,6 @@ static const struct snd_soc_dapm_route mt6351_dapm_routes[] = {
 
 static int mt6351_codec_init_reg(struct snd_soc_component *cmpnt)
 {
-	int ret = 0;
-
 	/* Disable CLKSQ 26MHz */
 	regmap_update_bits(cmpnt->regmap, MT6351_TOP_CLKSQ, 0x0001, 0x0);
 	/* disable AUDGLB */
@@ -1434,7 +1432,7 @@ static int mt6351_codec_init_reg(struct snd_soc_component *cmpnt)
 	/* Reverse the PMIC clock*/
 	regmap_update_bits(cmpnt->regmap, MT6351_AFE_PMIC_NEWIF_CFG2,
 			   0x8000, 0x8000);
-	return ret;
+	return 0;
 }
 
 static int mt6351_codec_probe(struct snd_soc_component *cmpnt)
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
