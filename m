Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5452FC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:20:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22A24206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X7Cy6gb/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pZ/O6676"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A24206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=XMQtJl5wPonYexU21p6YMvseCvUgTit/pH+dQ8mYl/s=; b=X7Cy6gb/tgKLrRsdGAjL4qjbG4
	hAl1k9Z4bEHrqJ/tW1Aa9w8rQA1nZnqnLAHDFJq/+9Ho+o6C3RCiYkGe3QiYaFGb0izWVv2cQwhxc
	lo2cpOGlt/GuGQNycaAzd0uZ4VIlGgcuf8zWGBO8NdoKuC3/a7cT2AQ6bIcpqfuwu+tVwn081nfrI
	iDFJDgvs1XrWSsm1xm4B0KlsEL+BcqXRGYh2B2COu+rxVVShVqSPiHt/ig2UGgFwir2kJbz6+Cxzx
	X/twDZOb8YZhz+KsVogJeV3yRY6LdfGSPky/MlHofc1exIAxMWFNJ4HHpNWDjChHwKVmrdtl9acTh
	FL7FIWeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUZuD-0005We-06; Wed, 05 Dec 2018 16:20:09 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUZta-0004Xd-IN
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 16:19:41 +0000
Received: by mail-pf1-x441.google.com with SMTP id c72so10239036pfc.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 08:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=U5AyLvvPtL5q9Hq4lLjNeXGltOkPp9aVeP+7Rj9S6G4=;
 b=pZ/O66767u/rju7GV0hExJzk4xER5YpDmZBVbLQR1ZPXoBifETBSmkHWjhuxoMk0tt
 6EL2v4x6RYeLQ1k/2gESxWcg4UNPGaZLJhE9IuxaYZf3Li974d3yYYEb6mETlQ+I7PsE
 Vfb4Ro1ynCGwsetRSyuqcEv0ybE7hOjh+DYS0gIBX4sEZuqc+39U4k437HaaBAEKk83m
 Vlrz+A1madK3qDoef9UdDzp0YA0jUjsUurLPIk3g70ALBFr36w22qyFMcaUmZr2nhCSr
 igm5OoCmvzl4vorfgzH3YZZK7G7bkzZqIUGWDbxCoRZefotnEIvsAqs2rTJ5y3oQtaQW
 3gSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=U5AyLvvPtL5q9Hq4lLjNeXGltOkPp9aVeP+7Rj9S6G4=;
 b=gr1K8QfYf6WmIgRxk8t/jHNkwxAJWXpoCh6jnXMDOTJnoUnyAuzsPeUmaidpC7Mex1
 v72i1Zx1OqkdoEasWMhUjeQeVf8ZV5m2aDzAVIeMauHKu9VkX0p0Z2rPG/ve7s71pdm7
 en4rRMtpaipq500xGkIDLW5ijZpzcd3zDx5UCceBAfcfhRNjKFYTRkAMN6UxgWS0jVhZ
 xb4yhFy+rrJRQ/NpVCdiGvMVSs9rdkOAEPPYY/FzbLzw8qpFcOmdUk3DLSiXlu3i9uJi
 bmoXCT+/EhbrbiYdxyxhrYhMjnpAuNVmnX0BBn1MlOR1mraXEAwH5MfEhvw3E5fNIgfR
 Gw/A==
X-Gm-Message-State: AA+aEWaBkV58yx/dTFK8X7/M3j3Ipv1E7eoAih3lBv6Tk0TuDZaBcJSX
 +ky9oSbW8DeFRSuSd/7Q02U=
X-Google-Smtp-Source: AFSGD/XRuMnsK25fid0v5zdBmNLshJ9g2ojqO8x9OsAVhaID02pKR/H65XtOEy1CVvhAsOp3pOucnQ==
X-Received: by 2002:a63:5907:: with SMTP id n7mr20874313pgb.435.1544026759113; 
 Wed, 05 Dec 2018 08:19:19 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id o7sm26868095pfb.34.2018.12.05.08.19.18
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 05 Dec 2018 08:19:18 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: vkoul@kernel.org, dan.j.williams@intel.com, sudeep.dutt@intel.com,
 ashutosh.dixit@intel.com, daniel@zonque.org, haojian.zhuang@gmail.com,
 robert.jarzmik@free.fr, okaya@kernel.org, andy.gross@linaro.org,
 david.brown@linaro.org
Subject: [PATCH 4/4] dmaengine: qcom_hidma: convert to DEFINE_SHOW_ATTRIBUTE
Date: Wed,  5 Dec 2018 11:19:00 -0500
Message-Id: <20181205161900.16434-4-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181205161900.16434-1-tiny.windzz@gmail.com>
References: <20181205161900.16434-1-tiny.windzz@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_081931_320495_A24471E4 
X-CRM114-Status: GOOD (  11.40  )
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
Acked-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/dma/qcom/hidma_dbg.c | 33 ++++++---------------------------
 1 file changed, 6 insertions(+), 27 deletions(-)

diff --git a/drivers/dma/qcom/hidma_dbg.c b/drivers/dma/qcom/hidma_dbg.c
index 3bdcb8056a36..9523faf7acdc 100644
--- a/drivers/dma/qcom/hidma_dbg.c
+++ b/drivers/dma/qcom/hidma_dbg.c
@@ -85,11 +85,11 @@ static void hidma_ll_devstats(struct seq_file *s, void *llhndl)
 }
 
 /*
- * hidma_chan_stats: display HIDMA channel statistics
+ * hidma_chan_show: display HIDMA channel statistics
  *
  * Display the statistics for the current HIDMA virtual channel device.
  */
-static int hidma_chan_stats(struct seq_file *s, void *unused)
+static int hidma_chan_show(struct seq_file *s, void *unused)
 {
 	struct hidma_chan *mchan = s->private;
 	struct hidma_desc *mdesc;
@@ -117,11 +117,11 @@ static int hidma_chan_stats(struct seq_file *s, void *unused)
 }
 
 /*
- * hidma_dma_info: display HIDMA device info
+ * hidma_dma_show: display HIDMA device info
  *
  * Display the info for the current HIDMA device.
  */
-static int hidma_dma_info(struct seq_file *s, void *unused)
+static int hidma_dma_show(struct seq_file *s, void *unused)
 {
 	struct hidma_dev *dmadev = s->private;
 	resource_size_t sz;
@@ -138,29 +138,8 @@ static int hidma_dma_info(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int hidma_chan_stats_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, hidma_chan_stats, inode->i_private);
-}
-
-static int hidma_dma_info_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, hidma_dma_info, inode->i_private);
-}
-
-static const struct file_operations hidma_chan_fops = {
-	.open = hidma_chan_stats_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
-static const struct file_operations hidma_dma_fops = {
-	.open = hidma_dma_info_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(hidma_chan);
+DEFINE_SHOW_ATTRIBUTE(hidma_dma);
 
 void hidma_debug_uninit(struct hidma_dev *dmadev)
 {
-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
