Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC78EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:41:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B1F92084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OrnSVWK9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKQ5BkKh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B1F92084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=FFHDaeoPMyW+aBC3mVikB62LlfVt+7Vrr75YpgAyErE=; b=OrnSVWK9Xl+UNw
	Xv9CD9wF1khBA3bk2M8LAZLkkZWPrpJq0tNAuo+BuEnhNS9SHg8PtUH/WP8UbcnZGSlN/f8YZEDGy
	MDvhAP7puP7EPp4sRyEyQ42BiDz5ARHM/YeLBPThKz/0gn+fqqM9/olSazOJo+7SI6Z4IQFqmhbsW
	ZxhAGyX6o/iFNkaHdh1eM8Z6/r7olamWSbmQBEYtzvshMMVycbSdUs1pNcFVULMmQpgtCtQeBKE0r
	yeHuCKU5ndhnS7AJNlIfi0RbZRHCjwYunu0XJAqs5uQqIU6ZE6K9f+AANgeunaEVkOOytk/CPpf3A
	e4gg8kRyw6yNkAXrEVkw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWW7I-0003WP-8Z; Tue, 11 Dec 2018 00:41:40 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWW7D-0003Ve-UP
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 00:41:37 +0000
Received: by mail-wr1-x443.google.com with SMTP id 96so12355083wrb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 16:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZKq2htSNW/TcYrKCBtc+NHz3ZdYLc4gE7+TEtkC+ZXI=;
 b=mKQ5BkKhzSTs3VUSUrY9uPEaigPPxjvg7bA+zFRkHQR75lOMsOLQpHReo31n4HCN6u
 l819sqQ5frM5Dm0RdCzuqj/3e6wv6FfrGD/77a1bvg27zxo5n9ANyfHJU9KWE2rloejP
 Bq/zmsGUsmhYhlS0/TGcT26umDeJEbsR+vcVDZi+dIXDvPopSLVGpqXzPOLjjPkbwX5Y
 odqnZ0X/nxKURU7XjZq/NnWdwcIK9yRB7u5gfkGJw6GEehreRk05VGEAjPx63UeJWBKk
 Wo9Yc0B6LAS6grQnH/9jSpYFEGHiHiJno7WNH7TixxUMZbAeQCSY//acYmWy5xxeq9LX
 kb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZKq2htSNW/TcYrKCBtc+NHz3ZdYLc4gE7+TEtkC+ZXI=;
 b=rmmMPGKhMJ9qRuJdj0BKMc/LerX8Sj1SJ82W1/YVEknmJqDH9yiHie/pbzf2S78tCh
 YtDPl1HEl6KAI6AD793GLDBxpTBr9pLs6ss1Ft4S4dAi2Br1/n0dhLE7mwrzzufrOym7
 UbLt3aFWk6KZ42RmQB2xJrbXRCuwCOCkKtWVNR4AeW2BaqIZxtv2e9P6lAWK8b+eQdTB
 uwbk/P5GMbFx7vvkCflgbjgX5JwVEiao31cnbbEoE2GVkPF1CkTg6E0A8vdCKjXakfiy
 D98oxsGqQWXhjrxQTKmRe2O++wwFQizyQp8nc8WLy06+CiVz5Q6YGpqqUULJvRuG+QCx
 4Stw==
X-Gm-Message-State: AA+aEWYk8T0gUlx5+YhTdugvrkiPAZ4zzAgD1Rt/wVfBSvIXLOgGOWjq
 gxTTAU8cCaOmjZqPxEJ7nbA=
X-Google-Smtp-Source: AFSGD/XfB9wjbo3b5JotaoiMUEbwHmWXpSFXm/yfYQLz57D3YfU9Nsn+jArIks9JdzpFYPIOXHDD3A==
X-Received: by 2002:a5d:56d2:: with SMTP id m18mr12472045wrw.113.1544488883368; 
 Mon, 10 Dec 2018 16:41:23 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
 by smtp.gmail.com with ESMTPSA id l20sm34624627wrb.93.2018.12.10.16.41.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 16:41:22 -0800 (PST)
From: Nathan Chancellor <natechancellor@gmail.com>
To: Santosh Shilimkar <ssantosh@kernel.org>
Subject: [PATCH] soc: ti: knav_dma: Use proper enum in pktdma_init_chan
Date: Mon, 10 Dec 2018 17:41:14 -0700
Message-Id: <20181211004114.28029-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_164136_144640_BA2D502F 
X-CRM114-Status: GOOD (  12.80  )
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
Cc: Nathan Chancellor <natechancellor@gmail.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Clang warns when one enumerated type is implicitly converted to another:

drivers/soc/ti/knav_dma.c:601:20: warning: implicit conversion from
enumeration type 'enum dma_data_direction' to different enumeration type
'enum dma_transfer_direction' [-Wenum-conversion]
        chan->direction = DMA_NONE;
                        ~ ^~~~~~~~
1 warning generated.

While DMA_NONE and DMA_TRANS_NONE have different values, there is no
functional change because direction is never checked against DMA_NONE,
only against DMA_MEM_TO_DEV and DMA_DEV_TO_MEM.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/soc/ti/knav_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
index e05ab16d9a9e..6285cd8efb21 100644
--- a/drivers/soc/ti/knav_dma.c
+++ b/drivers/soc/ti/knav_dma.c
@@ -598,7 +598,7 @@ static int pktdma_init_chan(struct knav_dma_device *dma,
 
 	INIT_LIST_HEAD(&chan->list);
 	chan->dma	= dma;
-	chan->direction	= DMA_NONE;
+	chan->direction	= DMA_TRANS_NONE;
 	atomic_set(&chan->ref_count, 0);
 	spin_lock_init(&chan->lock);
 
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
