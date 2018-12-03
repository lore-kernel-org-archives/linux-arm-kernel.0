Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F91C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:40:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C25DC20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bgE59+5t";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJA71BEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25DC20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=SuBCCjQ1s40G1S8xKLhcPV2fLd6gxo3aLZidete4QqE=; b=bgE
	59+5tO7bcTJY2biA8wuLgi3EO1biMET/FGr5RBXyrP7RdP4W0HKFXX2uWeAC+psGmQoBVeLQhIqnT
	SQ9hHo86mnnC08jpUZ9LUh/gYdY08Aoi7O8qZ7lawF8gQFzxfz9uNGlq772B6TFg1sK+Yln/h+yu8
	j8tKJACXGXqRCSu+OaGQfb+PifYPIKPh4HigdIaElyiMRRzs8xgs4OtEiGaEbJCn4TUZtgiiV78Yu
	y50xMRW6cxM7sm2iN9X4po/S/mJzmApTtVHKcUM/o8u5eE3lAekKJyXINNDF1aQWuZjf5TwBCdYLI
	I1Gtt96FioPdE2NOxulPogDtlB02eVg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gToSs-0003Hy-Gh; Mon, 03 Dec 2018 13:40:46 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gToSp-0003Gp-GU; Mon, 03 Dec 2018 13:40:45 +0000
Received: by mail-pl1-x642.google.com with SMTP id z23so6508808plo.0;
 Mon, 03 Dec 2018 05:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=Qxtg4nICqbh9KhYtdOejhTeV2HFcYiVkS+B7edaqSxc=;
 b=SJA71BEC1RzVknAOKHjvq9Q5EKe10rw/Wo+SRs6hZyTEL9j/WbC7ZYmGcrnIAPIKvP
 oTVewRyFM498vwLBSqHbNXNgFiUpQ9onGaaiqzSTNVN+IBAnLMeGIHbGKIvtH6Pr2FxZ
 Jt+H3i5RcMGNe/qByF/y1yvVVA7QKVHR4uH/ZHVLz4tXb7fcWsu0Sr2z51nKMHZT/IVn
 Z/PBkTbLlxf2qtxudYKnCDUhMkuXHo6aQ/FWX+Nxmy0dgVPbm0DL/1FQefaRDxkEDOJw
 n7m2qi38kOmkOQjddz8Z3Ry5GIRk4ToOQSzy1evRFId1AV9yBaZdfL10CDH16u5yM1mt
 Vx+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Qxtg4nICqbh9KhYtdOejhTeV2HFcYiVkS+B7edaqSxc=;
 b=U/QVDode4X1a2OShMrKCcb9hu3ZUdhLvRvbwvT23xLJzT+ZgXTmMzGWK4NRZ/M+0To
 tNHj80eKDqLOFyB6+1LsAZhxaAhavpdXSSwvNt6m1b7wA024X9WoZHHrMASVWm0CMU0F
 nj6dPhUBQUmUtef4zX9nMlb23zijQOUj7+uT9Rnr6ILw8aCXiq6AypaedtH2BD+MLOCh
 K+5/bt7InUGh5d9aZcoDdrH0rZ71MV8mX0HS9VrMHxgcidP2yOP+X8IbZFmir5QXHbDx
 aCWlQsOVz4IZZmAPzkHAbFuctEArrQ0N8y+JOgGWJ24KnTKgZx52UkLcqDaTpPMek2j3
 cwSg==
X-Gm-Message-State: AA+aEWbIAojDCs7voUsXDuI/rAlFnBkj1wOBDXyYIILv3bS5n1NKHzXb
 1LoNJqHdU7InhiSIMcI1sak=
X-Google-Smtp-Source: AFSGD/UE+jkOy64iwgg2DeVrr/5Xh5SlWXXlKEkTCj8m2ennjqaiYSpaY/fYstpTVIzEde5ExL2ncw==
X-Received: by 2002:a17:902:27e6:: with SMTP id
 i35mr15701908plg.222.1543844432477; 
 Mon, 03 Dec 2018 05:40:32 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id u78sm31132346pfi.2.2018.12.03.05.40.31
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 05:40:31 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: davem@davemloft.net, kubakici@wp.pl, matthias.bgg@gmail.com, nbd@nbd.name,
 lorenzo.bianconi@redhat.com, joe@perches.com, sgruszka@redhat.com,
 kvalo@codeaurora.org
Subject: [PATCH] mt76: convert to DEFINE_SHOW_ATTRIBUTE
Date: Mon,  3 Dec 2018 08:40:28 -0500
Message-Id: <20181203134028.12645-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_054043_572126_059838DB 
X-CRM114-Status: GOOD (  10.77  )
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
Cc: Yangtao Li <tiny.windzz@gmail.com>, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 .../wireless/mediatek/mt76/mt76x0/debugfs.c   | 20 ++--------
 .../wireless/mediatek/mt76/mt76x2/debugfs.c   | 38 +++---------------
 .../net/wireless/mediatek/mt7601u/debugfs.c   | 40 ++++---------------
 3 files changed, 18 insertions(+), 80 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt76x0/debugfs.c
index 3224e5b1a1e5..21fde45b1b20 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/debugfs.c
@@ -18,8 +18,7 @@
 #include "mt76x0.h"
 #include "eeprom.h"
 
-static int
-mt76x0_ampdu_stat_read(struct seq_file *file, void *data)
+static int ampdu_stat_show(struct seq_file *file, void *data)
 {
 	struct mt76x02_dev *dev = file->private;
 	int i, j;
@@ -61,19 +60,7 @@ mt76x0_ampdu_stat_read(struct seq_file *file, void *data)
 
 	return 0;
 }
-
-static int
-mt76x0_ampdu_stat_open(struct inode *inode, struct file *f)
-{
-	return single_open(f, mt76x0_ampdu_stat_read, inode->i_private);
-}
-
-static const struct file_operations fops_ampdu_stat = {
-	.open = mt76x0_ampdu_stat_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(ampdu_stat);
 
 void mt76x0_init_debugfs(struct mt76x02_dev *dev)
 {
@@ -83,5 +70,6 @@ void mt76x0_init_debugfs(struct mt76x02_dev *dev)
 	if (!dir)
 		return;
 
-	debugfs_create_file("ampdu_stat", S_IRUSR, dir, dev, &fops_ampdu_stat);
+	debugfs_create_file("ampdu_stat", S_IRUSR, dir, dev,
+				&ampdu_stat_fops);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt76x2/debugfs.c
index e8f8ccc0a5ed..04711cd09d21 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/debugfs.c
@@ -17,8 +17,7 @@
 #include <linux/debugfs.h>
 #include "mt76x2.h"
 
-static int
-mt76x2_ampdu_stat_read(struct seq_file *file, void *data)
+static int ampdu_stat_show(struct seq_file *file, void *data)
 {
 	struct mt76x02_dev *dev = file->private;
 	int i, j;
@@ -40,12 +39,7 @@ mt76x2_ampdu_stat_read(struct seq_file *file, void *data)
 
 	return 0;
 }
-
-static int
-mt76x2_ampdu_stat_open(struct inode *inode, struct file *f)
-{
-	return single_open(f, mt76x2_ampdu_stat_read, inode->i_private);
-}
+DEFINE_SHOW_ATTRIBUTE(ampdu_stat);
 
 static int read_txpower(struct seq_file *file, void *data)
 {
@@ -58,15 +52,7 @@ static int read_txpower(struct seq_file *file, void *data)
 	return 0;
 }
 
-static const struct file_operations fops_ampdu_stat = {
-	.open = mt76x2_ampdu_stat_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
-static int
-mt76x2_dfs_stat_read(struct seq_file *file, void *data)
+static int dfs_stat_show(struct seq_file *file, void *data)
 {
 	struct mt76x02_dev *dev = file->private;
 	struct mt76x02_dfs_pattern_detector *dfs_pd = &dev->dfs_pd;
@@ -90,19 +76,7 @@ mt76x2_dfs_stat_read(struct seq_file *file, void *data)
 
 	return 0;
 }
-
-static int
-mt76x2_dfs_stat_open(struct inode *inode, struct file *f)
-{
-	return single_open(f, mt76x2_dfs_stat_read, inode->i_private);
-}
-
-static const struct file_operations fops_dfs_stat = {
-	.open = mt76x2_dfs_stat_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(dfs_stat);
 
 static int read_agc(struct seq_file *file, void *data)
 {
@@ -127,8 +101,8 @@ void mt76x2_init_debugfs(struct mt76x02_dev *dev)
 	debugfs_create_u8("temperature", 0400, dir, &dev->cal.temp);
 	debugfs_create_bool("tpc", 0600, dir, &dev->enable_tpc);
 
-	debugfs_create_file("ampdu_stat", 0400, dir, dev, &fops_ampdu_stat);
-	debugfs_create_file("dfs_stats", 0400, dir, dev, &fops_dfs_stat);
+	debugfs_create_file("ampdu_stat", 0400, dir, dev, &ampdu_stat_fops);
+	debugfs_create_file("dfs_stats", 0400, dir, dev, &dfs_stat_fops);
 	debugfs_create_devm_seqfile(dev->mt76.dev, "txpower", dir,
 				    read_txpower);
 
diff --git a/drivers/net/wireless/mediatek/mt7601u/debugfs.c b/drivers/net/wireless/mediatek/mt7601u/debugfs.c
index 991a6a729b1e..0be3084fee01 100644
--- a/drivers/net/wireless/mediatek/mt7601u/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt7601u/debugfs.c
@@ -37,8 +37,7 @@ mt76_reg_get(void *data, u64 *val)
 
 DEFINE_SIMPLE_ATTRIBUTE(fops_regval, mt76_reg_get, mt76_reg_set, "0x%08llx\n");
 
-static int
-mt7601u_ampdu_stat_read(struct seq_file *file, void *data)
+static int ampdu_stat_show(struct seq_file *file, void *data)
 {
 	struct mt7601u_dev *dev = file->private;
 	int i, j;
@@ -80,22 +79,9 @@ mt7601u_ampdu_stat_read(struct seq_file *file, void *data)
 
 	return 0;
 }
+DEFINE_SHOW_ATTRIBUTE(ampdu_stat);
 
-static int
-mt7601u_ampdu_stat_open(struct inode *inode, struct file *f)
-{
-	return single_open(f, mt7601u_ampdu_stat_read, inode->i_private);
-}
-
-static const struct file_operations fops_ampdu_stat = {
-	.open = mt7601u_ampdu_stat_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
-static int
-mt7601u_eeprom_param_read(struct seq_file *file, void *data)
+static int eeprom_param_show(struct seq_file *file, void *data)
 {
 	struct mt7601u_dev *dev = file->private;
 	struct mt7601u_rate_power *rp = &dev->ee->power_rate_table;
@@ -138,19 +124,7 @@ mt7601u_eeprom_param_read(struct seq_file *file, void *data)
 
 	return 0;
 }
-
-static int
-mt7601u_eeprom_param_open(struct inode *inode, struct file *f)
-{
-	return single_open(f, mt7601u_eeprom_param_read, inode->i_private);
-}
-
-static const struct file_operations fops_eeprom_param = {
-	.open = mt7601u_eeprom_param_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(eeprom_param);
 
 void mt7601u_init_debugfs(struct mt7601u_dev *dev)
 {
@@ -165,6 +139,8 @@ void mt7601u_init_debugfs(struct mt7601u_dev *dev)
 
 	debugfs_create_u32("regidx", 0600, dir, &dev->debugfs_reg);
 	debugfs_create_file("regval", 0600, dir, dev, &fops_regval);
-	debugfs_create_file("ampdu_stat", 0400, dir, dev, &fops_ampdu_stat);
-	debugfs_create_file("eeprom_param", 0400, dir, dev, &fops_eeprom_param);
+	debugfs_create_file("ampdu_stat", 0400, dir, dev, 
+				&ampdu_stat_fops);
+	debugfs_create_file("eeprom_param", 0400, dir, dev,
+				&eeprom_param_fops);
 }
-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
