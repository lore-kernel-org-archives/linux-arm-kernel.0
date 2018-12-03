Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0BDC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:22:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8EE1206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X3fxVQDU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iub4ZF/L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8EE1206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=hTuIVAI7LDBCy7/LritypVY7jfdfs9ZOUSCKFJH1NTQ=; b=X3f
	xVQDUI7TaY+I6LOJMGyorlCEaUC6AM8DquQZg8Z2DGmNChMjTkpaSOsg8ZBAnE07caSx9sNoR8NXE
	0c+vDqDBsAny+9Hez3ZEXQL6x1CixJt55fkW1wlID3wm2fJUhc7RzVAijactOQdsEYnB3Lgqiq8Z2
	m6LkIqSzUNKN4xnXwTE3TCByVUE3Pnw8RjmPK1TNrpklGuqit8FsShRnRu9/XH2sbs4fMNriGMtov
	1CZEFpTfP+LiLn/eSzpyF/LRV1McnbBgInyoLwJWkAtmlez+0ZNaDAExDraZeWN1cQASFPVFZGxx+
	pNYPa+Olg9yleKedXez7bXyrcGAwQkg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTp7G-0005Hc-8D; Mon, 03 Dec 2018 14:22:30 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTp78-0005F8-LK
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 14:22:28 +0000
Received: by mail-pl1-x641.google.com with SMTP id g9so6564919plo.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 06:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=4YfiQXJj4yKrRnSl7nTTGshx8IYMROHD4JklpRJUxbw=;
 b=iub4ZF/LhjqW8D9jXPm752i4U4u+beZheyvvA8dOo8ug9yWELtwyP4fAsynnk46xOW
 oXG/gBvL97UJsPxWWl6HsbsL0Ac+oKix48fJ3zOThdVnO266ZRFR9zRtdHtvzrvlj4iE
 4T+5fFRAz5Da0oRTY4uzThMD/JG8B+Xn5lsXYgACEWgL29AVC9uk0xtPF9yKKBv2wPn0
 Nl7aTlD6f8FHfNg0gqG/lu+42KmV5oR6feekrU3HjKGZF4tkgSeJ6R/F02RPAIke7GLd
 U5rxjEhlUwCN5kNTjphcDA0Ox5IUt+JSwPbghGpiTCzBGEIep9MWRcqWxDtGH50D4Sj2
 b74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=4YfiQXJj4yKrRnSl7nTTGshx8IYMROHD4JklpRJUxbw=;
 b=rArlvKVAfRa+C5e8MH/aBQwVmuBuo9Tdv4f9OMVI0lZgQG+tFPlWu00mF+qRGUxokr
 vgGmHSQ20Tfcu7IZV80XmcL/62qStWJMKVTwllUEOpHI4fh/QTQGxrpyfhfdfhG6dT+D
 gkJGlzJeRTq0yH1nbAblCXP2oOqgpTANVlCvQLcAI55QT3hRTUxvQ9Mh632kCwjBHShF
 0YlmjCu2uJQ+Rbq9GjR6V25QW1VBXAES/HV/SqF0wopUT7L9bw3NdmNsPc14dx54ON99
 62rM+3DxIKqIQtQ2eS2bXVftJ3stIXfBLYh8DmNO0RiERh6CK2ORvAvCcd0OcJeF3s4+
 TGiQ==
X-Gm-Message-State: AA+aEWZdzuoxgWYgvWt2TfWDjls8NUuRoJZ2vrY3IQPBbxnfe1/lD1on
 wMf2CvpmL2E9fy4/O6sOjuk=
X-Google-Smtp-Source: AFSGD/Xp1J/ADngiBb8D/QBTRYHAKdnXfwAaff9FmSpn2imvcTAVk8/ycPwTMKbjZDY/gukoqOBp2w==
X-Received: by 2002:a17:902:298a:: with SMTP id
 h10mr16275009plb.312.1543846931773; 
 Mon, 03 Dec 2018 06:22:11 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id j70sm19325775pfc.43.2018.12.03.06.22.10
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 06:22:11 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: peppe.cavallaro@st.com, alexandre.torgue@st.com, joabreu@synopsys.com,
 davem@davemloft.net, mcoquelin.stm32@gmail.com
Subject: [PATCH] net: stmmac: convert to DEFINE_SHOW_ATTRIBUTE
Date: Mon,  3 Dec 2018 09:22:09 -0500
Message-Id: <20181203142209.13044-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_062222_694692_6DC1467B 
X-CRM114-Status: GOOD (  11.86  )
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
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 34 +++----------------
 1 file changed, 4 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 076a8be18d67..c728ed1375b2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3891,7 +3891,7 @@ static void sysfs_display_ring(void *head, int size, int extend_desc,
 	}
 }
 
-static int stmmac_sysfs_ring_read(struct seq_file *seq, void *v)
+static int stmmac_rings_status_show(struct seq_file *seq, void *v)
 {
 	struct net_device *dev = seq->private;
 	struct stmmac_priv *priv = netdev_priv(dev);
@@ -3933,23 +3933,9 @@ static int stmmac_sysfs_ring_read(struct seq_file *seq, void *v)
 
 	return 0;
 }
+DEFINE_SHOW_ATTRIBUTE(stmmac_rings_status);
 
-static int stmmac_sysfs_ring_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, stmmac_sysfs_ring_read, inode->i_private);
-}
-
-/* Debugfs files, should appear in /sys/kernel/debug/stmmaceth/eth0 */
-
-static const struct file_operations stmmac_rings_status_fops = {
-	.owner = THIS_MODULE,
-	.open = stmmac_sysfs_ring_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
-static int stmmac_sysfs_dma_cap_read(struct seq_file *seq, void *v)
+static int stmmac_dma_cap_show(struct seq_file *seq, void *v)
 {
 	struct net_device *dev = seq->private;
 	struct stmmac_priv *priv = netdev_priv(dev);
@@ -4012,19 +3998,7 @@ static int stmmac_sysfs_dma_cap_read(struct seq_file *seq, void *v)
 
 	return 0;
 }
-
-static int stmmac_sysfs_dma_cap_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, stmmac_sysfs_dma_cap_read, inode->i_private);
-}
-
-static const struct file_operations stmmac_dma_cap_fops = {
-	.owner = THIS_MODULE,
-	.open = stmmac_sysfs_dma_cap_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(stmmac_dma_cap);
 
 static int stmmac_init_fs(struct net_device *dev)
 {
-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
