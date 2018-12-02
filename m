Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6515FC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 09:31:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69E5320851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 09:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CvDpUU8P";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkRJHLa6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69E5320851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=eI+CvkQHXA7EQhzuAzuBeH4/biSZSfJYsOWTlyWcHyU=; b=CvD
	pUU8PvZcY3GeVo8OoozxeR8grhmUdIrWWPrlwvo4kxO/KhcCPLtgyI09jC8H8aP+JBi7yLiRoF6Nt
	GXtRTJO9EzhI4jcmF0r71u4AgnBrHREaOArT0IfOB1pUcqpaRTXywDW0tPMR+uZhIxzRMHhdOGKU/
	9HJmbwzkdz6rrGwMDQ/Zd2c2HmzD5DzBO1s2v7KYoXGOWmSIpQckCoU+W0WBoyIFh9vd9CZ9Wv+8N
	HnHE9ZohHpbWXXN0IHcCtFfKGpWlW2sA6Of3vDPeejOGwo2OZabR4ru8aqPeVzYNbekjqQEVYvtDL
	f0NzTsKQJzo5EqR40x5FsZyFFdI2QJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTO5m-0006RS-Jm; Sun, 02 Dec 2018 09:31:10 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTO5i-0006QU-6V; Sun, 02 Dec 2018 09:31:08 +0000
Received: by mail-pf1-x441.google.com with SMTP id h3so4897058pfg.1;
 Sun, 02 Dec 2018 01:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=iblu0xpW0gxi19Mu73b6gL5fVxeL/Yt8kNCV9stdqSw=;
 b=CkRJHLa6wyRFhYpEEp5wRCNzj5F+y4wD1yvCCWm6l5dHgsabOL2JXMazWJ/y441+Fc
 UgAb3fw/xMKzPt1Iw0Jsa+czlRa1iCJ3tVVkhRjr+OXHcsk7dxii/NxnhoBJXwI9IM54
 aoVkbEM61eN5bC2iwaSdFuzXVJ+OFLLY+mG+6Fp6qRMeE/fLH7v+qTloKbbuUUTkpd2K
 aKHcBXUttI2Tilt0l9/E0erWT0FeoLLObVZtaSzDFYaPdpFtOpVdzDPGQF1QjhFj3G+5
 0RmlaH+qElxIAioBeKK/4RC8binh1FOsNkWcppnnmydXrMPMBHsWev5EMIqUvz53Ri3a
 4PeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=iblu0xpW0gxi19Mu73b6gL5fVxeL/Yt8kNCV9stdqSw=;
 b=C0xt8ndM1xSpMMuBC8G25loMMRcziKHA/8JKAQ+Jip7UMQYmYNBlqURJrVGY+c8xgF
 WgkggkcFjlz+14mVR/WIcmlH8TUAIRokVwG9xL56yGUKpkqeuCpCSjBWQiZSTFAN7QTJ
 yhTl2V7XJyJTa3zot4ssoPpN1x+ZD4QiPJFQASeso8y7HGK0w3cN+3D7x2t7BIK4mxxI
 dkFpVkY80xzO19OVa+wnigvgqkSTmpJv6c43fuNFbM+lvXFFVINitqJDig69fGxZGERL
 szXvHozAWx3ytQhV7aLHRiutGeI258KbWR3QbcNs6oovmepLvoYJgjXS+jGDChjnavUx
 HvHw==
X-Gm-Message-State: AA+aEWakHwHLkfXjy5tlTu8K6UfwxomqB82zjxV6MoFVMuPKjrEsLBYL
 gRlKnyk0s4cncasqp8Avm+8=
X-Google-Smtp-Source: AFSGD/WP4XL/iYjF2Co4ayV6vAAtw/CMFvDr3wqmgUjAtDLUdQTs1bVFyhQSf7uqsOwfjiatBbXGSw==
X-Received: by 2002:a63:9a52:: with SMTP id e18mr9794528pgo.14.1543743049867; 
 Sun, 02 Dec 2018 01:30:49 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id y1sm13936202pfe.9.2018.12.02.01.30.48
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 02 Dec 2018 01:30:49 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: merez@codeaurora.org, kvalo@codeaurora.org, davem@davemloft.net,
 kubakici@wp.pl, pizza@shaftnet.org, matthias.bgg@gmail.com,
 lorenzo.bianconi@redhat.com, nbd@nbd.name, sgruszka@redhat.com,
 joe@perches.com
Subject: [PATCH] wireless: convert to DEFINE_SHOW_ATTRIBUTE
Date: Sun,  2 Dec 2018 04:30:47 -0500
Message-Id: <20181202093047.11174-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_013106_246443_DB51AAAC 
X-CRM114-Status: GOOD (  10.34  )
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
 wil6210@qti.qualcomm.com, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/net/wireless/ath/wil6210/debugfs.c    | 240 +++---------------
 .../wireless/mediatek/mt76/mt76x0/debugfs.c   |  20 +-
 .../wireless/mediatek/mt76/mt76x2/debugfs.c   |  38 +--
 .../net/wireless/mediatek/mt7601u/debugfs.c   |  40 +--
 drivers/net/wireless/st/cw1200/debug.c        |  32 +--
 5 files changed, 64 insertions(+), 306 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/debugfs.c b/drivers/net/wireless/ath/wil6210/debugfs.c
index aa50813a0595..f64e2e6e9a55 100644
--- a/drivers/net/wireless/ath/wil6210/debugfs.c
+++ b/drivers/net/wireless/ath/wil6210/debugfs.c
@@ -124,7 +124,7 @@ static void wil_print_ring(struct seq_file *s, struct wil6210_priv *wil,
 	seq_puts(s, "}\n");
 }
 
-static int wil_ring_debugfs_show(struct seq_file *s, void *data)
+static int ring_show(struct seq_file *s, void *data)
 {
 	uint i;
 	struct wil6210_priv *wil = s->private;
@@ -183,18 +183,7 @@ static int wil_ring_debugfs_show(struct seq_file *s, void *data)
 
 	return 0;
 }
-
-static int wil_ring_seq_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, wil_ring_debugfs_show, inode->i_private);
-}
-
-static const struct file_operations fops_ring = {
-	.open		= wil_ring_seq_open,
-	.release	= single_release,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-};
+DEFINE_SHOW_ATTRIBUTE(ring);
 
 static void wil_print_sring(struct seq_file *s, struct wil6210_priv *wil,
 			    struct wil_status_ring *sring)
@@ -240,7 +229,7 @@ static void wil_print_sring(struct seq_file *s, struct wil6210_priv *wil,
 	seq_puts(s, "}\n");
 }
 
-static int wil_srings_debugfs_show(struct seq_file *s, void *data)
+static int srings_show(struct seq_file *s, void *data)
 {
 	struct wil6210_priv *wil = s->private;
 	int i = 0;
@@ -251,18 +240,7 @@ static int wil_srings_debugfs_show(struct seq_file *s, void *data)
 
 	return 0;
 }
-
-static int wil_srings_seq_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, wil_srings_debugfs_show, inode->i_private);
-}
-
-static const struct file_operations fops_srings = {
-	.open		= wil_srings_seq_open,
-	.release	= single_release,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-};
+DEFINE_SHOW_ATTRIBUTE(srings);
 
 static void wil_seq_hexdump(struct seq_file *s, void *p, int len,
 			    const char *prefix)
@@ -348,7 +326,7 @@ static void wil_print_mbox_ring(struct seq_file *s, const char *prefix,
 	wil_halp_unvote(wil);
 }
 
-static int wil_mbox_debugfs_show(struct seq_file *s, void *data)
+static int mbox_show(struct seq_file *s, void *data)
 {
 	struct wil6210_priv *wil = s->private;
 	int ret;
@@ -366,18 +344,7 @@ static int wil_mbox_debugfs_show(struct seq_file *s, void *data)
 
 	return 0;
 }
-
-static int wil_mbox_seq_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, wil_mbox_debugfs_show, inode->i_private);
-}
-
-static const struct file_operations fops_mbox = {
-	.open		= wil_mbox_seq_open,
-	.release	= single_release,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-};
+DEFINE_SHOW_ATTRIBUTE(mbox);
 
 static int wil_debugfs_iomem_x32_set(void *data, u64 val)
 {
@@ -624,7 +591,7 @@ static int wil6210_debugfs_create_ITR_CNT(struct wil6210_priv *wil,
 	return 0;
 }
 
-static int wil_memread_debugfs_show(struct seq_file *s, void *data)
+static int memread_show(struct seq_file *s, void *data)
 {
 	struct wil6210_priv *wil = s->private;
 	void __iomem *a;
@@ -645,18 +612,7 @@ static int wil_memread_debugfs_show(struct seq_file *s, void *data)
 
 	return 0;
 }
-
-static int wil_memread_seq_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, wil_memread_debugfs_show, inode->i_private);
-}
-
-static const struct file_operations fops_memread = {
-	.open		= wil_memread_seq_open,
-	.release	= single_release,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-};
+DEFINE_SHOW_ATTRIBUTE(memread);
 
 static ssize_t wil_read_file_ioblob(struct file *file, char __user *user_buf,
 				    size_t count, loff_t *ppos)
@@ -1053,7 +1009,7 @@ static void wil_seq_print_skb(struct seq_file *s, struct sk_buff *skb)
 }
 
 /*---------Tx/Rx descriptor------------*/
-static int wil_txdesc_debugfs_show(struct seq_file *s, void *data)
+static int txdesc_show(struct seq_file *s, void *data)
 {
 	struct wil6210_priv *wil = s->private;
 	struct wil_ring *ring;
@@ -1146,21 +1102,10 @@ static int wil_txdesc_debugfs_show(struct seq_file *s, void *data)
 
 	return 0;
 }
-
-static int wil_txdesc_seq_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, wil_txdesc_debugfs_show, inode->i_private);
-}
-
-static const struct file_operations fops_txdesc = {
-	.open		= wil_txdesc_seq_open,
-	.release	= single_release,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-};
+DEFINE_SHOW_ATTRIBUTE(txdesc);
 
 /*---------Tx/Rx status message------------*/
-static int wil_status_msg_debugfs_show(struct seq_file *s, void *data)
+static int status_msg_show(struct seq_file *s, void *data)
 {
 	struct wil6210_priv *wil = s->private;
 	int sring_idx = dbg_sring_index;
@@ -1202,19 +1147,7 @@ static int wil_status_msg_debugfs_show(struct seq_file *s, void *data)
 
 	return 0;
 }
-
-static int wil_status_msg_seq_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, wil_status_msg_debugfs_show,
-			   inode->i_private);
-}
-
-static const struct file_operations fops_status_msg = {
-	.open		= wil_status_msg_seq_open,
-	.release	= single_release,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-};
+DEFINE_SHOW_ATTRIBUTE(status_msg);
 
 static int wil_print_rx_buff(struct seq_file *s, struct list_head *lh)
 {
@@ -1232,7 +1165,7 @@ static int wil_print_rx_buff(struct seq_file *s, struct list_head *lh)
 	return i;
 }
 
-static int wil_rx_buff_mgmt_debugfs_show(struct seq_file *s, void *data)
+static int rx_buff_mgmt_show(struct seq_file *s, void *data)
 {
 	struct wil6210_priv *wil = s->private;
 	struct wil_rx_buff_mgmt *rbm = &wil->rx_buff_mgmt;
@@ -1257,19 +1190,7 @@ static int wil_rx_buff_mgmt_debugfs_show(struct seq_file *s, void *data)
 
 	return 0;
 }
-
-static int wil_rx_buff_mgmt_seq_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, wil_rx_buff_mgmt_debugfs_show,
-			   inode->i_private);
-}
-
-static const struct file_operations fops_rx_buff_mgmt = {
-	.open		= wil_rx_buff_mgmt_seq_open,
-	.release	= single_release,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-};
+DEFINE_SHOW_ATTRIBUTE(rx_buff_mgmt);
 
 /*---------beamforming------------*/
 static char *wil_bfstatus_str(u32 status)
@@ -1299,7 +1220,7 @@ static bool is_all_zeros(void * const x_, size_t sz)
 	return true;
 }
 
-static int wil_bf_debugfs_show(struct seq_file *s, void *data)
+static int bf_show(struct seq_file *s, void *data)
 {
 	int rc;
 	int i;
@@ -1353,18 +1274,7 @@ static int wil_bf_debugfs_show(struct seq_file *s, void *data)
 	}
 	return 0;
 }
-
-static int wil_bf_seq_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, wil_bf_debugfs_show, inode->i_private);
-}
-
-static const struct file_operations fops_bf = {
-	.open		= wil_bf_seq_open,
-	.release	= single_release,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-};
+DEFINE_SHOW_ATTRIBUTE(bf);
 
 /*---------temp------------*/
 static void print_temp(struct seq_file *s, const char *prefix, s32 t)
@@ -1381,7 +1291,7 @@ static void print_temp(struct seq_file *s, const char *prefix, s32 t)
 	}
 }
 
-static int wil_temp_debugfs_show(struct seq_file *s, void *data)
+static int temp_show(struct seq_file *s, void *data)
 {
 	struct wil6210_priv *wil = s->private;
 	s32 t_m, t_r;
@@ -1397,21 +1307,10 @@ static int wil_temp_debugfs_show(struct seq_file *s, void *data)
 
 	return 0;
 }
-
-static int wil_temp_seq_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, wil_temp_debugfs_show, inode->i_private);
-}
-
-static const struct file_operations fops_temp = {
-	.open		= wil_temp_seq_open,
-	.release	= single_release,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-};
+DEFINE_SHOW_ATTRIBUTE(temp);
 
 /*---------freq------------*/
-static int wil_freq_debugfs_show(struct seq_file *s, void *data)
+static int freq_show(struct seq_file *s, void *data)
 {
 	struct wil6210_priv *wil = s->private;
 	struct wireless_dev *wdev = wil->main_ndev->ieee80211_ptr;
@@ -1421,21 +1320,10 @@ static int wil_freq_debugfs_show(struct seq_file *s, void *data)
 
 	return 0;
 }
-
-static int wil_freq_seq_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, wil_freq_debugfs_show, inode->i_private);
-}
-
-static const struct file_operations fops_freq = {
-	.open		= wil_freq_seq_open,
-	.release	= single_release,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-};
+DEFINE_SHOW_ATTRIBUTE(freq);
 
 /*---------link------------*/
-static int wil_link_debugfs_show(struct seq_file *s, void *data)
+static int link_show(struct seq_file *s, void *data)
 {
 	struct wil6210_priv *wil = s->private;
 	struct station_info *sinfo;
@@ -1487,21 +1375,10 @@ static int wil_link_debugfs_show(struct seq_file *s, void *data)
 	kfree(sinfo);
 	return rc;
 }
-
-static int wil_link_seq_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, wil_link_debugfs_show, inode->i_private);
-}
-
-static const struct file_operations fops_link = {
-	.open		= wil_link_seq_open,
-	.release	= single_release,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-};
+DEFINE_SHOW_ATTRIBUTE(link);
 
 /*---------info------------*/
-static int wil_info_debugfs_show(struct seq_file *s, void *data)
+static int info_show(struct seq_file *s, void *data)
 {
 	struct wil6210_priv *wil = s->private;
 	struct net_device *ndev = wil->main_ndev;
@@ -1536,18 +1413,7 @@ static int wil_info_debugfs_show(struct seq_file *s, void *data)
 #undef CHECK_QSTATE
 	return 0;
 }
-
-static int wil_info_seq_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, wil_info_debugfs_show, inode->i_private);
-}
-
-static const struct file_operations fops_info = {
-	.open		= wil_info_seq_open,
-	.release	= single_release,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-};
+DEFINE_SHOW_ATTRIBUTE(info);
 
 /*---------recovery------------*/
 /* mode = [manual|auto]
@@ -1663,7 +1529,7 @@ static void wil_print_rxtid_crypto(struct seq_file *s, int tid,
 	seq_puts(s, "\n");
 }
 
-static int wil_sta_debugfs_show(struct seq_file *s, void *data)
+static int sta_show(struct seq_file *s, void *data)
 __acquires(&p->tid_rx_lock) __releases(&p->tid_rx_lock)
 {
 	struct wil6210_priv *wil = s->private;
@@ -1745,20 +1611,9 @@ __acquires(&p->tid_rx_lock) __releases(&p->tid_rx_lock)
 
 	return 0;
 }
+DEFINE_SHOW_ATTRIBUTE(sta);
 
-static int wil_sta_seq_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, wil_sta_debugfs_show, inode->i_private);
-}
-
-static const struct file_operations fops_sta = {
-	.open		= wil_sta_seq_open,
-	.release	= single_release,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-};
-
-static int wil_mids_debugfs_show(struct seq_file *s, void *data)
+static int mids_show(struct seq_file *s, void *data)
 {
 	struct wil6210_priv *wil = s->private;
 	struct wil6210_vif *vif;
@@ -1781,18 +1636,7 @@ static int wil_mids_debugfs_show(struct seq_file *s, void *data)
 
 	return 0;
 }
-
-static int wil_mids_seq_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, wil_mids_debugfs_show, inode->i_private);
-}
-
-static const struct file_operations fops_mids = {
-	.open		= wil_mids_seq_open,
-	.release	= single_release,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-};
+DEFINE_SHOW_ATTRIBUTE(mids);
 
 static int wil_tx_latency_debugfs_show(struct seq_file *s, void *data)
 __acquires(&p->tid_rx_lock) __releases(&p->tid_rx_lock)
@@ -2436,23 +2280,23 @@ static const struct {
 	umode_t mode;
 	const struct file_operations *fops;
 } dbg_files[] = {
-	{"mbox",	0444,		&fops_mbox},
-	{"rings",	0444,		&fops_ring},
-	{"stations", 0444,		&fops_sta},
-	{"mids",	0444,		&fops_mids},
-	{"desc",	0444,		&fops_txdesc},
-	{"bf",		0444,		&fops_bf},
-	{"mem_val",	0644,		&fops_memread},
+	{"mbox",	0444,		&mbox_fops},
+	{"rings",	0444,		&ring_fops},
+	{"stations", 0444,		&sta_fops},
+	{"mids",	0444,		&mids_fops},
+	{"desc",	0444,		&txdesc_fops},
+	{"bf",		0444,		&bf_fops},
+	{"mem_val",	0644,		&memread_fops},
 	{"rxon",	0244,		&fops_rxon},
 	{"tx_mgmt",	0244,		&fops_txmgmt},
 	{"wmi_send", 0244,		&fops_wmi},
 	{"back",	0644,		&fops_back},
 	{"pmccfg",	0644,		&fops_pmccfg},
 	{"pmcdata",	0444,		&fops_pmcdata},
-	{"temp",	0444,		&fops_temp},
-	{"freq",	0444,		&fops_freq},
-	{"link",	0444,		&fops_link},
-	{"info",	0444,		&fops_info},
+	{"temp",	0444,		&temp_fops},
+	{"freq",	0444,		&freq_fops},
+	{"link",	0444,		&link_fops},
+	{"info",	0444,		&info_fops},
 	{"recovery", 0644,		&fops_recovery},
 	{"led_cfg",	0644,		&fops_led_cfg},
 	{"led_blink_time",	0644,	&fops_led_blink_time},
@@ -2460,9 +2304,9 @@ static const struct {
 	{"fw_version",	0444,		&fops_fw_version},
 	{"suspend_stats",	0644,	&fops_suspend_stats},
 	{"compressed_rx_status", 0644,	&fops_compressed_rx_status},
-	{"srings",	0444,		&fops_srings},
-	{"status_msg",	0444,		&fops_status_msg},
-	{"rx_buff_mgmt",	0444,	&fops_rx_buff_mgmt},
+	{"srings",	0444,		&srings_fops},
+	{"status_msg",	0444,		&status_msg_fops},
+	{"rx_buff_mgmt",	0444,	&rx_buff_mgmt_fops},
 	{"tx_latency",	0644,		&fops_tx_latency},
 	{"link_stats",	0644,		&fops_link_stats},
 	{"link_stats_global",	0644,	&fops_link_stats_global},
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
diff --git a/drivers/net/wireless/st/cw1200/debug.c b/drivers/net/wireless/st/cw1200/debug.c
index 295cb1a29f25..2231ba08bc1f 100644
--- a/drivers/net/wireless/st/cw1200/debug.c
+++ b/drivers/net/wireless/st/cw1200/debug.c
@@ -289,19 +289,7 @@ static int cw1200_status_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
-static int cw1200_status_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, &cw1200_status_show,
-		inode->i_private);
-}
-
-static const struct file_operations fops_status = {
-	.open = cw1200_status_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
+DEFINE_SHOW_ATTRIBUTE(cw1200_status);
 
 static int cw1200_counters_show(struct seq_file *seq, void *v)
 {
@@ -345,19 +333,7 @@ static int cw1200_counters_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
-static int cw1200_counters_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, &cw1200_counters_show,
-		inode->i_private);
-}
-
-static const struct file_operations fops_counters = {
-	.open = cw1200_counters_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
+DEFINE_SHOW_ATTRIBUTE(cw1200_counters);
 
 static ssize_t cw1200_wsm_dumps(struct file *file,
 	const char __user *user_buf, size_t count, loff_t *ppos)
@@ -399,11 +375,11 @@ int cw1200_debug_init(struct cw1200_common *priv)
 		goto err;
 
 	if (!debugfs_create_file("status", 0400, d->debugfs_phy,
-				 priv, &fops_status))
+				 priv, &cw1200_status_fops))
 		goto err;
 
 	if (!debugfs_create_file("counters", 0400, d->debugfs_phy,
-				 priv, &fops_counters))
+				 priv, &cw1200_counters_fops))
 		goto err;
 
 	if (!debugfs_create_file("wsm_dumps", 0200, d->debugfs_phy,
-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
