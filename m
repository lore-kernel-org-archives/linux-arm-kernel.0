Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10DCC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:44:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A546620868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iOIE4LQq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eR81Gzpz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A546620868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=/n0ldOAC97OiuwBe32+rbPaKhB/WmAtRYtKx2iMW1FE=; b=iOIE4LQqXvms5vfoc4UFjV8/BS
	epM7s8fn72pmw01jOhAOIrMFnQtlpqJg9CRyvxbXF3xEV6n/qnxrD872CxkiJLubbs30bOBd20eed
	1Tl/NZ/6Ko50ns8yAhqzd8doBGy5+D/SVJkqN+uOPDk2UrkPoNSfF0Vx4bsBEWA9nbVjSq2vthjt4
	dXrue3uecsVCLtbDr2M7CQ/A41IF8aKcKlGin+F3NxK3JG7Z7ycEF5nlLVQlMh+KG2SggKyGRnmbD
	DMcgafZq5MTjPZ7eeGQ3Ubup7kRdBHypih0IXQPACWWFabOm5GL8HLO9yIRFxH+KWDHm1il+8XB+M
	IRJqe2eQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSnmB-00018U-Iw; Fri, 30 Nov 2018 18:44:31 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSnl7-0000AE-F6
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 18:43:29 +0000
Received: by mail-pf1-x444.google.com with SMTP id i12so3221808pfo.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 10:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=IG7KRCWaojU1bB2x6elFS8JLJg5OGapgO5FtAnCgCzM=;
 b=eR81GzpzDzdMjHwlH7UN8hQc2PhFXh4zxkagfQpuLUEoJz/H3yCRLL4gV6X7c6pL2g
 xOIZZUGPma3AUQJsZIb4UnRjn3c7Ez6dWs+y1LRv28eyBAa298s25pm+O1kOCe6zbokD
 je/h9wBxtXRRbXRY8jrb8Je0qcjAi8kN7JyMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=IG7KRCWaojU1bB2x6elFS8JLJg5OGapgO5FtAnCgCzM=;
 b=cnCj/JxXZWu7PosrxsX9K87wbyeGUAAt0JEpIPo/wYUgsSwGkGH2tJIAInTv71+wZQ
 JHP1Vfbwghhb8v6Yn1dOG0mpY1Ty7od8b1IXbHtoYtFbaqqeDbl57Kc+4hYhMzXLZfn7
 4fPT7wEP9EThU8lmEqvC/cYkfLxTPoun07Qph+PuNEDG1w/6UiDypZI4MQXviPt6ufXW
 5P5tJBH2XK2fVHybtyMkUEKOX/ZnL4Hipe2uRyft3EpPvt0bCB4KYBjCB+wEKn5mKdaf
 Idr9jCC10crE68lZM0CKNo10exFg2hgDDW8nRB99FtPxlIvmyjaZ7yS/bSyoAQnNkMBt
 eBpg==
X-Gm-Message-State: AA+aEWabuuJb3g27pQRWj45wlZOUJFoPgyEKsMp6Or5viQmCcOiaH5ZD
 /VYKmY6kfcb3J6NhUx8k+kNDag==
X-Google-Smtp-Source: AFSGD/VruTurxButpnNWTJKd4LeKbbF5ewudhVyxxtbRET00jIeRD7eFXTLI25rW5Panaj2uw8Kn0Q==
X-Received: by 2002:a63:9749:: with SMTP id d9mr5591505pgo.415.1543603394789; 
 Fri, 30 Nov 2018 10:43:14 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id l184sm12743147pfc.112.2018.11.30.10.43.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 30 Nov 2018 10:43:14 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: gregkh@linuxfoundation.org
Subject: [PATCH 6/6] coresight: fix spelling mistake "deffered" -> "deferred"
Date: Fri, 30 Nov 2018 11:43:07 -0700
Message-Id: <1543603387-32645-7-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543603387-32645-1-git-send-email-mathieu.poirier@linaro.org>
References: <1543603387-32645-1-git-send-email-mathieu.poirier@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_104325_872455_3D3C1AEB 
X-CRM114-Status: GOOD (  13.78  )
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

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the dev_info error message, fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-stm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 35d6f9709274..ef339ff22090 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -856,7 +856,7 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 
 	if (stm_register_device(dev, &drvdata->stm, THIS_MODULE)) {
 		dev_info(dev,
-			 "stm_register_device failed, probing deffered\n");
+			 "stm_register_device failed, probing deferred\n");
 		return -EPROBE_DEFER;
 	}
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
