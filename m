Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07F0C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:37:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE7BF21736
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qNc5Y+5N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE7BF21736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U8kK9upl2GB0qsLh6sCN0NJN45LNC20dZPj1yC6L/t8=; b=qNc5Y+5NNzLVgu
	YhWLWJeisoQP91K5uJ0SlBeBS4a0CRcNBpWr2slZPQa7ip81zWMSzAkILYQIPSB1jTwJSvcZNxabh
	z6qZHxfAtoYUM0LlZ7v1smvTlPTtLakuk8Z1FKXYuXVRwIV5NwW2EpfuxF5JhWSyo78tdHG9bKf+n
	t+ICjtS42HH/QadEVjAs7r8/g6TK3MES3Rda00EJX3+nIAmqJogHiMYJhm9FnAOWQuMyspj/5MORs
	4iELeDy0KAuXV5Nt/cvThl3zHWPBwc6SdwZ0yTPZrl0JPm8a09EY+939oy5xMSQtHmcEUFBjolV/v
	OhWaU/P1qvVCfu8ymXKg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvk2X-0008Fa-EQ; Mon, 18 Feb 2019 14:37:01 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvk2S-0008Bx-0P
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 14:36:59 +0000
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id EBB41BB4D30A6FB9883D;
 Mon, 18 Feb 2019 22:36:47 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.408.0; Mon, 18 Feb 2019 22:36:39 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: Olivier Moysan <olivier.moysan@st.com>, Arnaud Pouliquen
 <arnaud.pouliquen@st.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: [PATCH v2 -next] ASoC: stm32: sai: remove set but not used variables
 'mask, cr1'
Date: Mon, 18 Feb 2019 14:50:26 +0000
Message-ID: <20190218145026.142805-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218134836.107220-1-yuehaibing@huawei.com>
References: <20190218134836.107220-1-yuehaibing@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_063656_282255_7239708F 
X-CRM114-Status: GOOD (  11.10  )
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
Cc: alsa-devel@alsa-project.org, YueHaibing <yuehaibing@huawei.com>,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Fixes gcc '-Wunused-but-set-variable' warning:

sound/soc/stm/stm32_sai_sub.c: In function 'stm32_sai_configure_clock':
sound/soc/stm/stm32_sai_sub.c:902:11: warning:
 variable 'mask' set but not used [-Wunused-but-set-variable]
sound/soc/stm/stm32_sai_sub.c:902:6: warning:
 variable 'cr1' set but not used [-Wunused-but-set-variable]

It's not used any more after 8307b2afd386 ("ASoC: stm32: sai: set sai as
mclk clock provider")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: remove unnessesary if branch.
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




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
