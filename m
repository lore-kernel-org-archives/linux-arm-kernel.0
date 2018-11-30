Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E95C64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:44:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0843120868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oip8a1WF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MNfo2gVn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0843120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=3r9etLEHGU2T4hjI21vcqPKAnUKvIATtmPRNEB1/0B4=; b=oip8a1WFfRKVT0i9royzYH3/jx
	HdIF1mtiKvxOKbpRNt3EDKDG6010CsjFFmyBHWREkfBpoBvvdIx9Sz0SLb6h/J76+npfT5lGlHoXC
	gEEfo16klW29fCy9nbXSs07S5VpV9m9p+oztNshvBjDK0XqkPQFMBRPxwDijhAWVqBgDk5/EtzeSx
	WQSGdJ3ePnMZCiK+H1fQZOXWB6ewlrQKjwqthE3sPcP8U7UPetjI1PJOWUN1EePo4Vv38/RRDraUG
	PNnGkGvMm6t/PkGdrEPBzC60nX0sHi9slByBDbfwiBUhsjRuAc6Hk9Fkdlt6WSZeip0yZ+UGsVX5F
	d3J3TlkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSnlx-0000tr-GX; Fri, 30 Nov 2018 18:44:17 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSnl4-00009m-H9
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 18:43:24 +0000
Received: by mail-pg1-x542.google.com with SMTP id z11so2879266pgu.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 10:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Vzhe1k+4Sg0ipa3ln5fdFCWCmxq09KTUkxbptlEwH0o=;
 b=MNfo2gVn4M21WigIT/e+iaNN9ezDzgUXXWXSfwDo6u8q7wl0e60KnDGwCVXDsPm4hw
 vGgJ6SDizOsZu+A7J39csL3PzLfeo7a8ZE2fACs5tsPKjnE7IciTWbA3BpmortyQr5Zv
 0CwpP4AXmrzSuXAd+4YgQQMaw597TfE0vRN+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Vzhe1k+4Sg0ipa3ln5fdFCWCmxq09KTUkxbptlEwH0o=;
 b=kQMl/UeWgc4Oe47nB1YDl9FIkME6gVz5KpgAvq/3Aw5CK8KKrqvrbNgdjFnLPDGKvY
 GcyRu6CxiN5HjAQ4vLs6KJxW1CIm/kv/JAfvyG7YUcdxanc4YgzJ9APvDZAF/+9MVoCo
 rNSCkcmPwmx6Jod65ebbkcIpVxEM6W57Z0mPsgsCOAz41x20UXiq4s1/+5DCGUX2sE9R
 XkItRvtKj7spDtWJU5cIYogbKWwbOxs8ptmG0lcLliMJWMBeCVbNGewI81fARg3CRhDY
 7xC23GVgRgs5LQfzFMTUotGo+vTN32/XLtx6Gy+EvAJivtdIZHIcoj6Uf+iVlIDunam8
 51uw==
X-Gm-Message-State: AA+aEWZM7k1fzjA5Vx0wuCwIRosZu4S1owblErOTWK0kKdT9m4RCkD1t
 wrmg6DiKK+G/MNsB0AEl/7HJaw==
X-Google-Smtp-Source: AFSGD/W3ekytdVJf2nhR+dvTK42U7K/Xnadujo5YqyNEAmBTMNMTRtiirtvTtCqBqMduV3Ba7VgQyw==
X-Received: by 2002:a62:29c3:: with SMTP id p186mr6786256pfp.117.1543603392931; 
 Fri, 30 Nov 2018 10:43:12 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id l184sm12743147pfc.112.2018.11.30.10.43.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 30 Nov 2018 10:43:12 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: gregkh@linuxfoundation.org
Subject: [PATCH 4/6] coresight: etm3x: Deal with CLAIM tag before and after
 accessing HW
Date: Fri, 30 Nov 2018 11:43:05 -0700
Message-Id: <1543603387-32645-5-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543603387-32645-1-git-send-email-mathieu.poirier@linaro.org>
References: <1543603387-32645-1-git-send-email-mathieu.poirier@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_104322_562107_B085EBB0 
X-CRM114-Status: GOOD (  14.00  )
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

This patch moves access to the CLAIM tag so that no modification to the HW
happens before and after the CLAIM operation has been carried.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index fd5c4cca7db5..6f30d52da9e4 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -363,15 +363,16 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
 
 	CS_UNLOCK(drvdata->base);
 
+	rc = coresight_claim_device_unlocked(drvdata->base);
+	if (rc)
+		goto done;
+
 	/* Turn engine on */
 	etm_clr_pwrdwn(drvdata);
 	/* Apply power to trace registers */
 	etm_set_pwrup(drvdata);
 	/* Make sure all registers are accessible */
 	etm_os_unlock(drvdata);
-	rc = coresight_claim_device_unlocked(drvdata->base);
-	if (rc)
-		goto done;
 
 	etm_set_prog(drvdata);
 
@@ -422,8 +423,6 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
 	etm_clr_prog(drvdata);
 
 done:
-	if (rc)
-		etm_set_pwrdwn(drvdata);
 	CS_LOCK(drvdata->base);
 
 	dev_dbg(drvdata->dev, "cpu: %d enable smp call done: %d\n",
@@ -577,9 +576,9 @@ static void etm_disable_hw(void *info)
 	for (i = 0; i < drvdata->nr_cntr; i++)
 		config->cntr_val[i] = etm_readl(drvdata, ETMCNTVRn(i));
 
+	etm_set_pwrdwn(drvdata);
 	coresight_disclaim_device_unlocked(drvdata->base);
 
-	etm_set_pwrdwn(drvdata);
 	CS_LOCK(drvdata->base);
 
 	dev_dbg(drvdata->dev, "cpu: %d disable smp call done\n", drvdata->cpu);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
