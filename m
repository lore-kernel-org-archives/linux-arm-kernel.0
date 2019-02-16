Return-Path: <SRS0=BOBm=QX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3924BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 15:19:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06161222A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 15:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IOGJMwSk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZApq5ARU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06161222A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=VZ/2NIrPOT8vAmEzU0Kk6wcao4bFJvoIFxJtvWtUWXE=; b=IOGJMwSk6GNK6cipWVE0/7c6Tc
	8f5m8TY5DAzxSIedE/JJYSbIpy+/Pbsssmw1WOOvANBzrKeXlph0tG1FUR6Lg9PkzzKeISmQOmOhn
	1hEwZovUIoM38dFXSxAS5jrzFM55q9tCRb+sUuQC6Ma4zKVqsDCG3+kENuaBIm6q1VlKbKkHvBWst
	R1txxuMzL4yguAg/QgkXjM2YzAgowm/Ld8Yi1GohpXI4RqM+XcXEARXt5g7BTcBCFMH/NghQLQACg
	AgYXbiL3W9idYZ6Zvu3Yy867nEBayGXE3t2zf8s4zxXAcYZ1v2oth3cD3axCWDf9/89NxqFnFbZ8R
	/DcHatLg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gv1kO-0003mr-Ci; Sat, 16 Feb 2019 15:19:20 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gv1ju-0003CG-IF; Sat, 16 Feb 2019 15:18:52 +0000
Received: by mail-pf1-x441.google.com with SMTP id q1so6286696pfi.5;
 Sat, 16 Feb 2019 07:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=+obBbYPLyLsKhLxV8PUlhQAAQv38YOeGGO7KFLMs+Qg=;
 b=ZApq5ARUqTtxqWC5/5JV0YaBezInejDyj6EGPwJygz1ZzC2fQxVkOcoYF8F+TIdMut
 HrgrjFyQ0AHXfuEsU+qjyu6NcWkzmgz63yfVTXEUwojBlNpNpFEiTI30FITHGRSn0Z7T
 BIdedU1l8EARcAFafP4QFF7SUpbTo22l2kMs3QdVZUexLrvVW1MnQu9CMS8btXdhslxo
 Ml5mIjykFDWvYelPE57opWetc4PiphyKWmMlftsONq96i/zoxUJSRQqWGzHlc/PfJBcL
 XQep5OKWKpWKrr8Z4KVTObM4ENOJ3/lQ23Z23GXLU8Kjqy7t8x/+5XOd15sLfZlfa4ZQ
 d+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=+obBbYPLyLsKhLxV8PUlhQAAQv38YOeGGO7KFLMs+Qg=;
 b=X/V/zqyiKZGcd20ZEb/8WfFP9haCuUDzwb4P7pqVvKfBey26XGJbJFogEMehCRbF5/
 jahVOkg65IjO6aimvL90p64wItpGwrJ39+HxImmYT3vbxFL8kVlQ8Nhr1CIu6ncp6KCy
 ykzcsQNUa+tkPFjtUvlblf8zXXyqLyoRA5u+DjFJF51RNxaGgpeSA9JvtJ2fLN2Bz0iD
 y3DIqySRapa3ZZ0FiF62pEz0LPidDJnkNgxIGZFahnqgRTXjvHym9u0P71m2cNFovVrI
 +nOfVlOycD0PbbYb6zrl/JGQKjcUyuyTwmqUvnS9Tos60sialc18ljeRLx7/0OyHKfhs
 GR4A==
X-Gm-Message-State: AHQUAuZEd3b8sIUO1r2d8ltGaECS46rvkXn8OsNbX2HwHO/Xn00yykvz
 bhlfm1beww6+1MqYT83iDAM=
X-Google-Smtp-Source: AHgI3IbtrZw4sGn50oUZ86X8w9u9PrweIiAeOQdwAZ1aS7aoSuX3u+JF+x08xKMnmUAgA+vk1XqjXQ==
X-Received: by 2002:aa7:9289:: with SMTP id j9mr6363518pfa.130.1550330330158; 
 Sat, 16 Feb 2019 07:18:50 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id q28sm23926492pgl.35.2019.02.16.07.18.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 16 Feb 2019 07:18:49 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: cw00.choi@samsung.com, myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
 heiko@sntech.de, thierry.reding@gmail.com, jonathanh@nvidia.com
Subject: [PATCH 3/3] PM / devfreq: tegra: remove unneeded variable
Date: Sat, 16 Feb 2019 10:18:26 -0500
Message-Id: <20190216151826.11584-4-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190216151826.11584-1-tiny.windzz@gmail.com>
References: <20190216151826.11584-1-tiny.windzz@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190216_071850_609835_E0352DB4 
X-CRM114-Status: GOOD (  12.50  )
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
Cc: linux-pm@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This variable is not used after initialization, so
remove it. And in order to unify the code style,
move the location where the dev_get_drvdata is called
by the way.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index c59d2eee5d30..c89ba7b834ff 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -573,10 +573,7 @@ static int tegra_governor_get_target(struct devfreq *devfreq,
 static int tegra_governor_event_handler(struct devfreq *devfreq,
 					unsigned int event, void *data)
 {
-	struct tegra_devfreq *tegra;
-	int ret = 0;
-
-	tegra = dev_get_drvdata(devfreq->dev.parent);
+	struct tegra_devfreq *tegra = dev_get_drvdata(devfreq->dev.parent);
 
 	switch (event) {
 	case DEVFREQ_GOV_START:
@@ -600,7 +597,7 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 		break;
 	}
 
-	return ret;
+	return 0;
 }
 
 static struct devfreq_governor tegra_devfreq_governor = {
-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
