Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79BEC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:44:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D08E20868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="esp3vz98";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="i8F6CGCO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D08E20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=MMiJ4N3DvXOp5xYCg7gkMQEPo+mxy7RoN86Gu2BUAmw=; b=esp3vz981R8KCq3wfAaQN/gbg3
	3dswg5SNZKuZjySCncOp6MqbdyU7f34aXzpE4qMR5Q4acmPmz4o94ds60o430ywjbwh+WIBtkSddj
	MBnY89che8CvkmtDrnuhuvc3OoIIxf1fUoQHP5vRlQNxrw82D/fEwiNEZ+dpcCbvpbs7YX4kheUds
	xjxAAt1BGZ6fFlJk6c3RhGc+5ZRs1UKyD8lyP3uFdF/xJbDsAxvMprrhh4XI19kzvKztjWBmEP59r
	fruZ5Nihe/S7K+yekT0zciszq0riiLmzOjoWrWfpKMkfmgrDL56bhi71S76B5+WM9D1nIF5jTkahC
	Ta00Cdfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSnmQ-0001O3-24; Fri, 30 Nov 2018 18:44:46 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSnl3-00008d-Js
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 18:43:23 +0000
Received: by mail-pg1-x541.google.com with SMTP id y4so2848285pgc.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 10:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=OXwnhYG6hQi1Mbl3UXmr0yioawjZlr4QoOQbaBfX9RQ=;
 b=i8F6CGCOfAYjBRuRriccxKKihlxKdkJTiuAsuI6Rq1UYlMykqzsgSxTWcNZx/3bOHZ
 /1AgbfSqt6i639mZt5TdOoUi4CbHFTV6TpjFSNET1okOzpwje2RZCNlXpn2zcCpPOHX+
 R8BLpWofEXs+urLmVufc6Pa4eMSj0HY5czx08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=OXwnhYG6hQi1Mbl3UXmr0yioawjZlr4QoOQbaBfX9RQ=;
 b=I0a9ZS5BT6AqZ0rZwLlmLRG9rbtazcSUfbNUgOAa+wo13N2doHQfxP6mDPyBnUFFIy
 ooGJRXzu8BJ3520uEH7Q//dCXt/t/ms7WkV6XT90Nrlkm7CkjCQZJTbIqSsJ/fY19cco
 Wk0ps0kUAiBRn01sHSUu+8wwZyigU4C/26XJh8bepIk9zeTY8f6sex1IKfPVRqCkKsbF
 WhukWWwYpQqFRL5s7bixjAXJIPncdI1U2vW5pp8IjXN5F7D9vvlTbVylpk2NafSXWfkZ
 H7qvLGHW1WoyR8YpwYa5JY6TOMRY6nHwqYtkG5hWKEQh1U4+z/IXZ4adcHJTfVZ8a8xc
 h4pw==
X-Gm-Message-State: AA+aEWYhrnVgRigkCT5bMVj7cKixnOVcq//kVndIEDaDBitF42rnzbm4
 Zhfr+waW7qxz/dIf2dkNbUYKQw==
X-Google-Smtp-Source: AFSGD/VE5EDFBI0bjI0ygEYfWERifZ67R/F6hxXNy/YWh0YkeVg1IRgMC1z0Jeq/xRXvQke1Fjsugg==
X-Received: by 2002:a63:e80e:: with SMTP id s14mr5726174pgh.30.1543603391042; 
 Fri, 30 Nov 2018 10:43:11 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id l184sm12743147pfc.112.2018.11.30.10.43.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 30 Nov 2018 10:43:10 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: gregkh@linuxfoundation.org
Subject: [PATCH 2/6] coresight: etb10: Add support for CLAIM tag
Date: Fri, 30 Nov 2018 11:43:03 -0700
Message-Id: <1543603387-32645-3-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543603387-32645-1-git-send-email-mathieu.poirier@linaro.org>
References: <1543603387-32645-1-git-send-email-mathieu.poirier@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_104321_648157_6DF54B6C 
X-CRM114-Status: GOOD (  16.34  )
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
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Following in the footstep of what was done for other CoreSight devices,
add CLAIM tag support to ETB10 in order to synchronise access to the
HW between the kernel and an external agent.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 824be0c5f592..105782ea64c7 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -136,6 +136,11 @@ static void __etb_enable_hw(struct etb_drvdata *drvdata)
 
 static int etb_enable_hw(struct etb_drvdata *drvdata)
 {
+	int rc = coresight_claim_device(drvdata->base);
+
+	if (rc)
+		return rc;
+
 	__etb_enable_hw(drvdata);
 	return 0;
 }
@@ -223,7 +228,7 @@ static int etb_enable(struct coresight_device *csdev, u32 mode, void *data)
 	return 0;
 }
 
-static void etb_disable_hw(struct etb_drvdata *drvdata)
+static void __etb_disable_hw(struct etb_drvdata *drvdata)
 {
 	u32 ffcr;
 
@@ -313,6 +318,13 @@ static void etb_dump_hw(struct etb_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
+static void etb_disable_hw(struct etb_drvdata *drvdata)
+{
+	__etb_disable_hw(drvdata);
+	etb_dump_hw(drvdata);
+	coresight_disclaim_device(drvdata->base);
+}
+
 static void etb_disable(struct coresight_device *csdev)
 {
 	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
@@ -323,7 +335,6 @@ static void etb_disable(struct coresight_device *csdev)
 	/* Disable the ETB only if it needs to */
 	if (drvdata->mode != CS_MODE_DISABLED) {
 		etb_disable_hw(drvdata);
-		etb_dump_hw(drvdata);
 		drvdata->mode = CS_MODE_DISABLED;
 	}
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
@@ -402,7 +413,7 @@ static unsigned long etb_update_buffer(struct coresight_device *csdev,
 
 	capacity = drvdata->buffer_depth * ETB_FRAME_SIZE_WORDS;
 
-	etb_disable_hw(drvdata);
+	__etb_disable_hw(drvdata);
 	CS_UNLOCK(drvdata->base);
 
 	/* unit is in words, not bytes */
@@ -510,7 +521,7 @@ static unsigned long etb_update_buffer(struct coresight_device *csdev,
 		handle->head = (cur * PAGE_SIZE) + offset;
 		to_read = buf->nr_pages << PAGE_SHIFT;
 	}
-	etb_enable_hw(drvdata);
+	__etb_enable_hw(drvdata);
 	CS_LOCK(drvdata->base);
 
 	return to_read;
@@ -534,9 +545,9 @@ static void etb_dump(struct etb_drvdata *drvdata)
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 	if (drvdata->mode == CS_MODE_SYSFS) {
-		etb_disable_hw(drvdata);
+		__etb_disable_hw(drvdata);
 		etb_dump_hw(drvdata);
-		etb_enable_hw(drvdata);
+		__etb_enable_hw(drvdata);
 	}
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
