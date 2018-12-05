Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0288C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:19:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86C7A20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TXES7qrf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p9zyVDnL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86C7A20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=drWfatc6+vDVc1zikfdtj5q3lIzw39u6Zc+tXMHldAQ=; b=TXES7qrfwhWMQY/esywK18w/EK
	RrTdfTNAgaBVIhh/vcDVdibtUJEJmlI1ZsaUvGhJNUm+1VczJKEchjSGCnOcemiBjt5fJ3Yy0CO5u
	a9sRSgk5pi03eZ4EUBr3ezSI2JUoGmhRkTlAlomGvvlNHV3clIrwSCuGRRHr5NWW9wTkOEBivxMz/
	2oAepJYdRzedfXVjfh9Z4+KnGKP01CAJzzk0bsQ/V+ExZkH+wibnAOfVCVGoz8kgo9EpWahSwUo4W
	+dUqpoWxKUVXqaPud6IRhtT0fneWGbmR7xAyzjKwgzqid0lAaF1WrkAjMrlg5y/Kc5z1Jfgj71Xrr
	pv50uqFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUZta-0004hQ-Aw; Wed, 05 Dec 2018 16:19:30 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUZtQ-0004Wb-PJ
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 16:19:23 +0000
Received: by mail-pg1-x543.google.com with SMTP id z11so9249433pgu.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 08:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=UlVfIMfHrGtBTlZv/XK8koRNqWY+54IiT4Z9OFB2kBw=;
 b=p9zyVDnLTDccX6BjnfxuHmufgkGARQAWH6PNjDcQaP0d7RHLNfobAzQenhVX0TLyQJ
 DaPB/5OD5dd4IBHTHRb4J4mkeXn7DdZ/tEIkCP/TL2sUPW5NFoIKd9GMaaJSeIlsF32r
 Vfgh44k3f2+aOQD/A6SsnQQYwRFtvsFQjMkZ32HrGrq1lHXokB7+7mxpAm/YbAYW9Lwu
 YJc/kQJeYb8hZF5b0ikCCmCKy5MK08ecgte1WLilvRY7anHDTgWMY94YR0Zjf62Tsa8g
 4FP5T6QISdsUqOHkEVwFs/GVeCEHg0U4n0zAOoWbfbpUFfd5DApJ8fvNBtCwRb+kVlbH
 BNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=UlVfIMfHrGtBTlZv/XK8koRNqWY+54IiT4Z9OFB2kBw=;
 b=I+hzwG40Gsz+FnzSvhmHJiqNh/yJ3cV/XwkOERv9zIHJmmGuFEC3aHd15dMPt1r2K6
 yCzgyA7+XYasFlaWk7a2oVbPPgrtSGsi7vXu8r2eeQIWtk3JSY44/xE0hmMKa903WqQS
 H6DwhCy82O/mhkCzmdW829gGdyGcvv8uxWT0XjT3mzeziWTyCfkI4U2V4XA/I7ZIrrio
 ZTBTOoLUdRuofTW4jiMzQR+Lk6bXiRJApE6pWsNQAsUgtqQ6j9PRNwcSQfdJVvNkFZOp
 osVd/YM65l0vSNcOhtZcTxMq9bxhgUMWy5hS1SdnevakGNFVMmtlmX9428I7waHKxdjX
 q1Cw==
X-Gm-Message-State: AA+aEWbZ0d6yob9IzYY6rtdSwkpljrVQmzdFBbp05F7YcgEwcV2qH3sx
 dx0yVNlO7MBqjavIHuzt/WI=
X-Google-Smtp-Source: AFSGD/WzdxHmUE3nEUbxh/wpldUjRDSE4NVo39PlUajdmLspkBIg9fg85B0OrPZUxw+Y1Xob+V9PCA==
X-Received: by 2002:a65:41c2:: with SMTP id b2mr20775172pgq.67.1544026750169; 
 Wed, 05 Dec 2018 08:19:10 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id g65sm104654652pfa.63.2018.12.05.08.19.09
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 05 Dec 2018 08:19:09 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: vkoul@kernel.org, dan.j.williams@intel.com, sudeep.dutt@intel.com,
 ashutosh.dixit@intel.com, daniel@zonque.org, haojian.zhuang@gmail.com,
 robert.jarzmik@free.fr, okaya@kernel.org, andy.gross@linaro.org,
 david.brown@linaro.org
Subject: [PATCH 2/4] dmaengine: mic_x100_dma: convert to DEFINE_SHOW_ATTRIBUTE
Date: Wed,  5 Dec 2018 11:18:58 -0500
Message-Id: <20181205161900.16434-2-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181205161900.16434-1-tiny.windzz@gmail.com>
References: <20181205161900.16434-1-tiny.windzz@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_081921_168770_20446D7E 
X-CRM114-Status: GOOD (  12.19  )
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
Cc: dmaengine@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Yangtao Li <tiny.windzz@gmail.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/dma/mic_x100_dma.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/dma/mic_x100_dma.c b/drivers/dma/mic_x100_dma.c
index adfd316db1a8..6a91e28d537d 100644
--- a/drivers/dma/mic_x100_dma.c
+++ b/drivers/dma/mic_x100_dma.c
@@ -676,7 +676,7 @@ static void mic_dma_dev_unreg(struct mic_dma_device *mic_dma_dev)
 }
 
 /* DEBUGFS CODE */
-static int mic_dma_reg_seq_show(struct seq_file *s, void *pos)
+static int mic_dma_reg_show(struct seq_file *s, void *pos)
 {
 	struct mic_dma_device *mic_dma_dev = s->private;
 	int i, chan_num, first_chan = mic_dma_dev->start_ch;
@@ -707,23 +707,7 @@ static int mic_dma_reg_seq_show(struct seq_file *s, void *pos)
 	return 0;
 }
 
-static int mic_dma_reg_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, mic_dma_reg_seq_show, inode->i_private);
-}
-
-static int mic_dma_reg_debug_release(struct inode *inode, struct file *file)
-{
-	return single_release(inode, file);
-}
-
-static const struct file_operations mic_dma_reg_ops = {
-	.owner   = THIS_MODULE,
-	.open    = mic_dma_reg_debug_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = mic_dma_reg_debug_release
-};
+DEFINE_SHOW_ATTRIBUTE(mic_dma_reg);
 
 /* Debugfs parent dir */
 static struct dentry *mic_dma_dbg;
@@ -747,7 +731,7 @@ static int mic_dma_driver_probe(struct mbus_device *mbdev)
 		if (mic_dma_dev->dbg_dir)
 			debugfs_create_file("mic_dma_reg", 0444,
 					    mic_dma_dev->dbg_dir, mic_dma_dev,
-					    &mic_dma_reg_ops);
+					    &mic_dma_reg_fops);
 	}
 	return 0;
 }
-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
