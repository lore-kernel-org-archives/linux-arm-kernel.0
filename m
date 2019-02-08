Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F98C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:50:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0445D21919
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sh1BMD54"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0445D21919
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5UPqoDYh6c7c9m8ucOFqgpSV3XlVdsFAyeFEVLVtDL4=; b=sh1BMD54MyIaUc
	Oje27jaHkzz1tQNfKF3cQPZqAxBrvOBjLQ/GoCESYQUuNdoy7nxMSZ6UrDz65ibyqgSO3DS/koeBW
	wX4ZMJIGCOIqCXkhNSwh91B/9/c/XY/KebEMCZ2Zs2AsOb/sxLGLmgE66AXFhmj0jViweZ9AmtVKq
	zPuzbKARqrTtFrJvmK3FKCVLX7Fz5RiFlGVeT1RHE1SjwcldqsnxCco/IlBA/Tlm/2uOf1OZX9zmZ
	Oqz2wmR2U1NAltA2vgkrWI7R/6NnKNQF9xLGlUdM95D5IzMj8Z0vqGG8SwA0fnqHcClWxrwUDXBwJ
	TJB9BP3XBMrLenLER6hA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs3k0-0007c3-J9; Fri, 08 Feb 2019 10:50:40 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs3jU-0006TN-W9
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 10:50:13 +0000
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x18AkGbf006838; Fri, 8 Feb 2019 11:49:59 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2qfv9nkb44-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Fri, 08 Feb 2019 11:49:59 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B4A2331;
 Fri,  8 Feb 2019 10:49:58 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2EDDA28CA;
 Fri,  8 Feb 2019 10:49:58 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 8 Feb 2019
 11:49:58 +0100
Received: from localhost (10.201.23.16) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 8 Feb 2019 11:49:56
 +0100
From: Olivier Moysan <olivier.moysan@st.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>, <mcoquelin.stm32@gmail.com>,
 <alexandre.torgue@st.com>, <alsa-devel@alsa-project.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>,
 <arnaud.pouliquen@st.com>, <benjamin.gaignard@st.com>
Subject: [PATCH 1/2] ASoC: stm32: i2s: add power management
Date: Fri, 8 Feb 2019 11:49:53 +0100
Message-ID: <1549622994-13810-2-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549622994-13810-1-git-send-email-olivier.moysan@st.com>
References: <1549622994-13810-1-git-send-email-olivier.moysan@st.com>
MIME-Version: 1.0
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-08_07:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_025009_334320_2900BD23 
X-CRM114-Status: GOOD (  12.88  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add suspend and resume sleep callbacks,
to support system low power modes.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_i2s.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 6d0bf78d114d..dbe23a709d24 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -186,8 +186,9 @@ enum i2s_datlen {
 #define STM32_I2S_IS_SLAVE(x)		((x)->ms_flg == I2S_MS_SLAVE)
 
 /**
+ * struct stm32_i2s_data - private data of I2S
  * @regmap_conf: I2S register map configuration pointer
- * @egmap: I2S register map pointer
+ * @regmap: I2S register map pointer
  * @pdev: device data pointer
  * @dai_drv: DAI driver pointer
  * @dma_data_tx: dma configuration data for tx channel
@@ -596,8 +597,8 @@ static int stm32_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 			return ret;
 		}
 
-		ret = regmap_update_bits(i2s->regmap, STM32_I2S_CR1_REG,
-					 I2S_CR1_CSTART, I2S_CR1_CSTART);
+		ret = regmap_write_bits(i2s->regmap, STM32_I2S_CR1_REG,
+					I2S_CR1_CSTART, I2S_CR1_CSTART);
 		if (ret < 0) {
 			dev_err(cpu_dai->dev, "Error %d starting I2S\n", ret);
 			return ret;
@@ -703,6 +704,7 @@ static const struct regmap_config stm32_h7_i2s_regmap_conf = {
 	.volatile_reg = stm32_i2s_volatile_reg,
 	.writeable_reg = stm32_i2s_writeable_reg,
 	.fast_io = true,
+	.cache_type = REGCACHE_FLAT,
 };
 
 static const struct snd_soc_dai_ops stm32_i2s_pcm_dai_ops = {
@@ -929,10 +931,35 @@ static int stm32_i2s_remove(struct platform_device *pdev)
 
 MODULE_DEVICE_TABLE(of, stm32_i2s_ids);
 
+#ifdef CONFIG_PM_SLEEP
+static int stm32_i2s_suspend(struct device *dev)
+{
+	struct stm32_i2s_data *i2s = dev_get_drvdata(dev);
+
+	regcache_cache_only(i2s->regmap, true);
+	regcache_mark_dirty(i2s->regmap);
+
+	return 0;
+}
+
+static int stm32_i2s_resume(struct device *dev)
+{
+	struct stm32_i2s_data *i2s = dev_get_drvdata(dev);
+
+	regcache_cache_only(i2s->regmap, false);
+	return regcache_sync(i2s->regmap);
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops stm32_i2s_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(stm32_i2s_suspend, stm32_i2s_resume)
+};
+
 static struct platform_driver stm32_i2s_driver = {
 	.driver = {
 		.name = "st,stm32-i2s",
 		.of_match_table = stm32_i2s_ids,
+		.pm = &stm32_i2s_pm_ops,
 	},
 	.probe = stm32_i2s_probe,
 	.remove = stm32_i2s_remove,
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
