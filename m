Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D8AC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:43:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B66C320868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BHV5T7WH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HasY6LQt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B66C320868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=NahXxWku/pBIXDC9VjwO+Z00A8EnG6McRMrMQe2rvUA=; b=BHV5T7WHnGVaf1nf6Rfm9IW0Bb
	ixVX6cyi4IofU9rAI+ebBfCrFTm3k8FyFmC2ghPHccbfI36+GkxPiEh++wyN/Wn02OoaOYellsv8U
	z0mXF+IYC75WDTt2I9fAVEm6Z1wEsW4agUeKEAdRqghjGgJGdr0BMrBAPR9w2qkkTx6ZpMikUYQCn
	WgpsPf5r5OShsk6aUDZ4y4Xqw62wTmDRa7zzJxLDce2pDq7OiuNZybFPunbLWl66jaiZsLJ35SPdh
	ugEDSTqB33kneex1rM4Z5m71uZG0JLh7dQftrNxxxCW9xz/TCJ4ukgU4ILJvoGZq1ysAnjxx8XckZ
	frMWVvrw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSnl5-0000DR-Jz; Fri, 30 Nov 2018 18:43:23 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSnl2-0000A6-8p
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 18:43:21 +0000
Received: by mail-pg1-x544.google.com with SMTP id d72so2859876pga.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 10:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=c70yC8nTUX49YKlETWoE+QkSk9SIJlmG5ulj2mcAOIQ=;
 b=HasY6LQt1kbAfq6HXFV0B4/cxttvkZ5qDQxWLYxJwURXGtGt+IFNl6b7i/Le9BSliE
 N1hXLFUfFfhxNcZVFV/YhkWv6metAzkUiggaHlRr5tl8WUxqLnDFSJTOeQter7MuF0/+
 p/asvmqul8e5yGAsEwGJmPoIW6ni/dnP0qpZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=c70yC8nTUX49YKlETWoE+QkSk9SIJlmG5ulj2mcAOIQ=;
 b=rFkiihMXH9YdioEIME0rV4faHgnf7P4sllgRZQdgn6IXDyGjxd0DEtsKAuXKorDxPb
 NKECZUQSgK0/m/Ag3W33b8sNqQm7pQNFXiIBGYvlyEw8CYhgyXLtT2nQBKYuc+JRNj8n
 D+t+QZzAkyLDz5Zn+5uGJzXLRbFGxnHTQJnubu0EbqK9cwvBx6ZfHuOjkXapbhm7z1K/
 lK+USh5Irb+O5EdNaShW74nL96gi0mw7ccgSV2Z/7KNQJa9d5KBERiIpuXKZNHJTJj0C
 gLllUrlCy0i9aEqA2p6ONRge3N9j0R9Uy5KLcMEw3ymyk6fV17+CwQeL+PeaOlz4Gidt
 1L7Q==
X-Gm-Message-State: AA+aEWaf9LrjnBwploFCILhJlZVoXLA6nw0y+vIRjC8mhqE7vJTHNHXG
 x7j3Bx/uSjFuOQpt/GYmF8oRsQ==
X-Google-Smtp-Source: AFSGD/XzNHY9kWDpwaeQcBGsnouBEkdj5n/q2gSqwQ/Jg+tVRFFP23O62II+IEaE8Low4nMRLrIzbA==
X-Received: by 2002:a63:4f5e:: with SMTP id p30mr5734462pgl.71.1543603393874; 
 Fri, 30 Nov 2018 10:43:13 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id l184sm12743147pfc.112.2018.11.30.10.43.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 30 Nov 2018 10:43:13 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: gregkh@linuxfoundation.org
Subject: [PATCH 5/6] coresight: etm3x: Release CLAIM tag when operated from
 perf
Date: Fri, 30 Nov 2018 11:43:06 -0700
Message-Id: <1543603387-32645-6-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543603387-32645-1-git-send-email-mathieu.poirier@linaro.org>
References: <1543603387-32645-1-git-send-email-mathieu.poirier@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_104320_313545_61E6DD27 
X-CRM114-Status: GOOD (  12.99  )
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

This patch deals with the release of the CLAIM tag when the ETM is
operated from perf.  Otherwise the tag is left asserted and subsequent
requests to use the device fail.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index 6f30d52da9e4..9a63e87ea5f3 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -601,6 +601,7 @@ static void etm_disable_perf(struct coresight_device *csdev)
 	 * power down the tracer.
 	 */
 	etm_set_pwrdwn(drvdata);
+	coresight_disclaim_device_unlocked(drvdata->base);
 
 	CS_LOCK(drvdata->base);
 }
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
