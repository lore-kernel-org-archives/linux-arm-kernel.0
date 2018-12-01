Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BB7C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 08:31:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 554A020834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 08:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="erZ2C6YB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 554A020834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=zH9MpkMuPQA3qARw7zO9y3ItaGgStp+LjUBW7tasQFg=; b=erZ2C6YBONGnxb
	Wi4G5yBfpxZAbZlkgjgjp7Kv2EyDX+W8EDyhC1ua5KqKVoWZEwb/NQNXckoSK27HRld9YURQNkozT
	5y96Gpiiy8AaKM8O/cYuh1LpUu0K7KoOsnkUzPM+cmCIVMOmcnHWw4/fTqUZAslcSQ51vZhHsnYGN
	dDAqN5pJPKc4ENOs+p6SAwxFFEjeFtWsKaWwR1mBlOZyoJ1VUeo9TgfIMG1cCvQBZBC9Y71v2udej
	uziO+STznRT83ZbS+Guf9/1J2cLgq3Xq9Nt0KG8zbVp2685UGuA6pZLhJH5kZy8HkREN+r53NNq4u
	QKrJM/ADHGZK7+ZIC6oA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gT0gh-0007Xq-PS; Sat, 01 Dec 2018 08:31:43 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gT0gd-0007Wj-Uk
 for linux-arm-kernel@lists.infradead.org; Sat, 01 Dec 2018 08:31:41 +0000
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 429468E462846;
 Sat,  1 Dec 2018 16:31:21 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.408.0; Sat, 1 Dec 2018 16:31:14 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH -next] coresight: stm: remove set but not used variable
 'res_size'
Date: Sat, 1 Dec 2018 08:39:45 +0000
Message-ID: <1543653585-108277-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181201_003140_162662_C053850D 
X-CRM114-Status: UNSURE (   9.90  )
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
Cc: kernel-janitors@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/hwtracing/coresight/coresight-stm.c: In function 'stm_probe':
drivers/hwtracing/coresight/coresight-stm.c:796:9: warning:
 variable 'res_size' set but not used [-Wunused-but-set-variable]

It never used since introduction in commit
237483aa5cf4 ("coresight: stm: adding driver for CoreSight STM component")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/hwtracing/coresight/coresight-stm.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index ef339ff..f07825d 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -793,7 +793,7 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 	struct stm_drvdata *drvdata;
 	struct resource *res = &adev->res;
 	struct resource ch_res;
-	size_t res_size, bitmap_size;
+	size_t bitmap_size;
 	struct coresight_desc desc = { 0 };
 	struct device_node *np = adev->dev.of_node;
 
@@ -833,15 +833,11 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 
 	drvdata->write_bytes = stm_fundamental_data_size(drvdata);
 
-	if (boot_nr_channel) {
+	if (boot_nr_channel)
 		drvdata->numsp = boot_nr_channel;
-		res_size = min((resource_size_t)(boot_nr_channel *
-				  BYTES_PER_CHANNEL), resource_size(res));
-	} else {
+	else
 		drvdata->numsp = stm_num_stimulus_port(drvdata);
-		res_size = min((resource_size_t)(drvdata->numsp *
-				 BYTES_PER_CHANNEL), resource_size(res));
-	}
+
 	bitmap_size = BITS_TO_LONGS(drvdata->numsp) * sizeof(long);
 
 	guaranteed = devm_kzalloc(dev, bitmap_size, GFP_KERNEL);




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
