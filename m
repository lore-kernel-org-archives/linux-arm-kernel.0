Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4993CC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:13:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 160E320672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jQBq4JNv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bpeZ4Ids"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 160E320672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=xVUFac0TQg73oq38+21TgnXt6MqSzlDI+DdOffXuXqY=; b=jQBq4JNvI5YTJMYAUx5mcFAKuU
	RwZwuw+ilx84OpGMGs+nknkIJo59oDac5JMFI0HNlxDePQRHJ55Uf+y65IdXfHQGauPK7oS9ipIyj
	eZVeWz7X6a2qRyDaW7k3LWJ4agfQZlkKxPuE9AuWIZXrF0ciU/fFS1S7MkKgUKKg+KJUkIFJrXiF9
	6NIzO+lFxgWG+QmotEZiOQwMVsFVHV2QFgmNkZ5pNKCZ5kv/ZgkzDmkFDujRiKft39c5NATIvCALs
	ju1D6TYNGV/GDmfauuDcs8rA3+FieGMZKs+2IZbUnqkSydW62PdUNTGE1IycB5EM2tBppnZkxzi6d
	/8mCI00A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWSrh-0005E4-K8; Mon, 10 Dec 2018 21:13:21 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWSiR-0007d6-7v
 for linux-arm-kernel@bombadil.infradead.org; Mon, 10 Dec 2018 21:03:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5nP14Rs2ILyXrFqI7+wA1+/YhUfMQVDZDkO9NSlh8Y8=; b=bpeZ4IdslHQ3GqcquTm3lczIp
 4gcO66LcHoXshBdOXS/Trh3VcrpNaMk7QObiLubaOQK5nPf8x+wuV2Aq5P+Wc2ggguQj1xGO3yIvP
 LeYlOxewI7qSRBgpCGx43r2+JOQ4mDA+2BoiCKZh380nXTFzop2N3MiKPBw2NKOX5imqeCqx5XgD+
 KZESPEil22SZifLQ8Yk//aC1y8ym6kzaekBNNdbihwXgQexEdKd0Ce74o0IHztMrdmYBvc5xhCffn
 lm6ymx4i4C2tBSgAuRhLPk7U9aeBJhI6D1/JM9S4KBEROej0gSJTAtrif6ozECHFu1WUufXQ3B+mV
 pDHvYlXEg==;
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWSiO-0008ND-9O
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 21:03:45 +0000
Received: from localhost (p54B335CF.dip0.t-ipconnect.de [84.179.53.207])
 by pokefinder.org (Postfix) with ESMTPSA id E8F174C3C6E;
 Mon, 10 Dec 2018 22:03:15 +0100 (CET)
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Subject: [RFC/RFT 04/10] i2c: brcmstb: use core helper to mark adapter
 suspended
Date: Mon, 10 Dec 2018 22:03:02 +0100
Message-Id: <20181210210310.12677-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_160344_449244_EAFCA355 
X-CRM114-Status: GOOD (  10.69  )
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
Cc: Florian Fainelli <f.fainelli@gmail.com>, Kamal Dasu <kdasu.kdev@gmail.com>,
 linux-pm@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>, bcm-kernel-feedback-list@broadcom.com,
 Gregory Fong <gregory.0xf0@gmail.com>,
 Brian Norris <computersforpeace@gmail.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Rejecting transfers should be handled by the core.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-brcmstb.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-brcmstb.c b/drivers/i2c/busses/i2c-brcmstb.c
index 826d32049996..05c822e5a3f6 100644
--- a/drivers/i2c/busses/i2c-brcmstb.c
+++ b/drivers/i2c/busses/i2c-brcmstb.c
@@ -170,7 +170,6 @@ struct brcmstb_i2c_dev {
 	struct bsc_regs *bsc_regmap;
 	struct i2c_adapter adapter;
 	struct completion done;
-	bool is_suspended;
 	u32 clk_freq_hz;
 	int data_regsz;
 };
@@ -467,9 +466,6 @@ static int brcmstb_i2c_xfer(struct i2c_adapter *adapter,
 	int xfersz = brcmstb_i2c_get_xfersz(dev);
 	u32 cond, cond_per_msg;
 
-	if (dev->is_suspended)
-		return -EBUSY;
-
 	/* Loop through all messages */
 	for (i = 0; i < num; i++) {
 		pmsg = &msgs[i];
@@ -689,10 +685,7 @@ static int brcmstb_i2c_suspend(struct device *dev)
 {
 	struct brcmstb_i2c_dev *i2c_dev = dev_get_drvdata(dev);
 
-	i2c_lock_bus(&i2c_dev->adapter, I2C_LOCK_ROOT_ADAPTER);
-	i2c_dev->is_suspended = true;
-	i2c_unlock_bus(&i2c_dev->adapter, I2C_LOCK_ROOT_ADAPTER);
-
+	i2c_mark_adapter_suspended(&i2c_dev->adapter, true);
 	return 0;
 }
 
@@ -700,10 +693,8 @@ static int brcmstb_i2c_resume(struct device *dev)
 {
 	struct brcmstb_i2c_dev *i2c_dev = dev_get_drvdata(dev);
 
-	i2c_lock_bus(&i2c_dev->adapter, I2C_LOCK_ROOT_ADAPTER);
 	brcmstb_i2c_set_bsc_reg_defaults(i2c_dev);
-	i2c_dev->is_suspended = false;
-	i2c_unlock_bus(&i2c_dev->adapter, I2C_LOCK_ROOT_ADAPTER);
+	i2c_mark_adapter_suspended(&i2c_dev->adapter, false);
 
 	return 0;
 }
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
