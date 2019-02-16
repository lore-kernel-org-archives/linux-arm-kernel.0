Return-Path: <SRS0=BOBm=QX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82830C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 15:19:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51577222A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 15:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cE04uaBi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ga36iSdH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51577222A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Xs+Ac0Pvz13Z9CPQJg/oBcS4xVcZJYuxztcmh+GWLQ4=; b=cE04uaBiVHyiwf8hDSoZPaOZwM
	St5VR9ZoWd07JfdE4AS9B51RPH4NMVuWmEXJuo6A0Z6jB4n2DOlSjiZsG5HV1pZMjKZkYGfCJ6TUI
	Ju1/Hb2dlikLnlCCFO6I5n2Hg9/mH5hFNQALkDrOxbVrrzLo93ekN4CgGfV0X3t8tB4r/CaYWi8qh
	YM+XuXvWf0hE1YYIE+Lzaep5F88591WEwfaV04JGeThI/s9hKo+s3PQXcIZ8Tier8CjienlAQfkzq
	071hBrIJzNQk+2DL4zzlrnaaKWumUkUtQsnWjuT5ACcVHG3tTjMEsA7G8DmAAEMZnp2wVBw9i7ler
	9QY9Yqdw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gv1jx-0003FU-RJ; Sat, 16 Feb 2019 15:18:53 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gv1jo-00033w-GI; Sat, 16 Feb 2019 15:18:47 +0000
Received: by mail-pf1-x441.google.com with SMTP id n22so6291168pfa.3;
 Sat, 16 Feb 2019 07:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=2Ciga3oq2Jepxu5Q88L5YWntx9r4J5pvBwDOGZvsxrQ=;
 b=Ga36iSdH1E1mfc1wO1UqCGBfyB6HtMbSgTOjjWJP8CyNILGMdj9htAwfn5tWnbV+VE
 9e6f9NnKf5foHVu50W9qpcVjInI/HNMgD1GMcc4IRv6vBn9DYo/8mY/HXQjxJhM6HogC
 v9bgxFcoKNkgzZA0Uz5gCsj/YBRbboMZW22zRaDVhH7lDeiHD642WdsD9TuBbdiiItAF
 66yoaeUWGARVri+Q6p0lg8y2iC88xEZa90A3WQYUjq7OGBJf2L6U02JQojSZqM6jeaqN
 uKGoeZs//OQiwbUA7eXfhodULfbvK0MTb1l2wR6mUxZvmhImlQ5tvqlhg/pnBdfGL3h7
 3JPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=2Ciga3oq2Jepxu5Q88L5YWntx9r4J5pvBwDOGZvsxrQ=;
 b=eiRezi6M2o3q1tUDZ04yLeBRuQ6CMNQW0CRo8O0fhWs7dZNhL6njZki05Ikli0Bl4v
 M3ASj2AKkyzxqvdoXwQj+9EoybztkzV3p4TVmRD0Jqz12VkQyhsHI7fUX9aDqNO3kMDS
 HyfI5Io/zn1j61Xn0Hyzkf61F9GOTK7p0AbXYlP2TbY17FPYdnYayTaIr1dQYyGaONzh
 B1R98Rzw6bhn+OKGVeg0hHnw93aMWVMC5JCLLwnxpiXAmEIlknILtdnwiYV2m+Ae1HVi
 C2+50Lb9HGzvkTp7YoR1+9LZIqsEL8UU3zW8gt28XShER5rgDpfZrZRT+fQfMS5dYzg/
 3WSQ==
X-Gm-Message-State: AHQUAub8r/ArOgnHbQMO35bt3rZ88i3dh8Xe0cYy9BylOUOpcQbfITrO
 r/sG8F8g1b7h1y5ek2w//sU=
X-Google-Smtp-Source: AHgI3Ia5HFmmkkpz+iQXTSUGjiboKoIFTbVtW3dxWixpu7wvRS/7SFDWTKZH/WvVgdURL1mvcLxzmg==
X-Received: by 2002:aa7:808a:: with SMTP id v10mr15471762pff.8.1550330323587; 
 Sat, 16 Feb 2019 07:18:43 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id g7sm12810254pfm.10.2019.02.16.07.18.42
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 16 Feb 2019 07:18:42 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: cw00.choi@samsung.com, myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
 heiko@sntech.de, thierry.reding@gmail.com, jonathanh@nvidia.com
Subject: [PATCH 1/3] PM / devfreq: rk3399_dmc: remove unneeded semicolon
Date: Sat, 16 Feb 2019 10:18:24 -0500
Message-Id: <20190216151826.11584-2-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190216151826.11584-1-tiny.windzz@gmail.com>
References: <20190216151826.11584-1-tiny.windzz@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190216_071844_735298_2BA43BF8 
X-CRM114-Status: GOOD (  11.04  )
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

The semicolon is unneeded, so remove it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/devfreq/rk3399_dmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index e795ad2b3f6b..a228dad2bee4 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -322,7 +322,7 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 
 		dev_err(dev, "Cannot get the clk dmc_clk\n");
 		return PTR_ERR(data->dmc_clk);
-	};
+	}
 
 	data->edev = devfreq_event_get_edev_by_phandle(dev, 0);
 	if (IS_ERR(data->edev))
-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
