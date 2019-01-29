Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01C9C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:43:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2E542087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GfX4YgHT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="Wf9CoRoA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2E542087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=TvGVkAOYiyIRq27MA5fYLbo0hwyPvvorxpSORwTlMW8=; b=GfX4YgHThNgbDQ
	4I/5yTyA4PTo+2piiOg2MV2qNQoo3SxTJb0VGmlh/Os/EfAzKEDVfIXhC4fpNUilwtXus8BrsCbrv
	Ya4tJAv2yKUaVdlfcBwtxufER1Jece8/B8XI7faGjTrAZ2oJ1MxSlAGFduL/seY/yeoMYliz0OAOY
	/BWDv5XrZTeQav0rHEBI4jYHw0ydePqeobFE0p4vBG1gkehpPYmECYQoY1/dJAXA7dW4nC4qXxcLZ
	H1xnDfcpgMIlfnAA8PURGGBSv1YQOoFs/s66ZKivc7tygP0QR9QJZyR4QXg//hayhwkg711/bQ2Yd
	rBVUEY0fD8sOP+Twi2Eg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gomOn-00076Q-Fe; Wed, 30 Jan 2019 09:43:13 +0000
Received: from m12-11.163.com ([220.181.12.11])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gomOJ-0006bJ-As
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 09:42:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=hBdMe
 YqWOgwoCMrt5lUW7Gyey2VQfeeIjvvw5BlxhRw=; b=Wf9CoRoADJFNPfxz+Gar+
 wodcD1wPp40pjrZLquHUpiBzxSE23+KeuMu5dq06AFG90KZfkZC0MiRHPyhw62SB
 FYWmh66kuDbeYdhhbUL0d0LLq6sURGQJh+Bg+ie5Toy6E9pZ5J0lGnvWiCObW94J
 t3N6jCgFfbkKNSEhfHgBxk=
Received: from localhost.localdomain (unknown [117.36.119.152])
 by smtp7 (Coremail) with SMTP id C8CowACnVnuOcVFc23h4Dg--.63966S3;
 Wed, 30 Jan 2019 17:42:39 +0800 (CST)
From: sxauwsk <sxauwsk@163.com>
To: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH] i2c: cadence: try reset when master receive error interrupts
Date: Wed, 30 Jan 2019 03:52:14 +0800
Message-Id: <20190129195214.30272-1-sxauwsk@163.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CM-TRANSID: C8CowACnVnuOcVFc23h4Dg--.63966S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww1rXrW5AFy5Jr1UZryfXrb_yoW8XrWkpa
 1UG39IkrWIqF4IvFs7Zr17ZFy5uwsYga4jkr4Fk3sruF15Crn8Ka43tF98WF4xCry5X342
 qrZ8t39rG3W2vF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uoc_hUUUUU=
X-Originating-IP: [117.36.119.152]
X-CM-SenderInfo: 5v0d34lvn6il2tof0z/xtbBZA9MJlQHDeqMrgAAsX
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_014244_362853_0607BBD0 
X-CRM114-Status: GOOD (  11.85  )
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
Cc: sxauwsk@163.com, linux-i2c@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When the adapter receive error interrupts, such as NACK, arbitration lost,
cdns_i2c_master_xfer return to the caller directly instead of resuming 
the adapter which resulted in the adapter being out of control.

So when driver detect err_status then try to repair and fix it.

Signed-off-by: sxauwsk <sxauwsk@163.com>
---
 drivers/i2c/busses/i2c-cadence.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index b13605718291..e10048d7524a 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -548,10 +548,6 @@ static int cdns_i2c_process_msg(struct cdns_i2c *id, struct i2c_msg *msg,
 	cdns_i2c_writereg(CDNS_I2C_IXR_ALL_INTR_MASK,
 			  CDNS_I2C_IDR_OFFSET);
 
-	/* If it is bus arbitration error, try again */
-	if (id->err_status & CDNS_I2C_IXR_ARB_LOST)
-		return -EAGAIN;
-
 	return 0;
 }
 
@@ -617,13 +613,19 @@ static int cdns_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 			id->bus_hold_flag = 0;
 
 		ret = cdns_i2c_process_msg(id, msgs, adap);
-		if (ret)
+		if (!ret)
 			goto out;
 
 		/* Report the other error interrupts to application */
 		if (id->err_status) {
 			cdns_i2c_master_reset(adap);
 
+			/* If it is bus arbitration error, try again */
+			if (id->err_status & CDNS_I2C_IXR_ARB_LOST) {
+				ret = -EAGAIN;
+				goto out;
+			}
+
 			if (id->err_status & CDNS_I2C_IXR_NACK) {
 				ret = -ENXIO;
 				goto out;
-- 
2.19.2



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
