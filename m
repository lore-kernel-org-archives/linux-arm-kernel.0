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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A76DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 15:19:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CA5A222A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 15:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hrou//f+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIlJz3mp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA5A222A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=snf7bOwfc4l4/WwwOoSgXNspd7qqKkgTiggZhR0emuM=; b=Hrou//f+7Vuwd1whhZGryOyNcP
	D8cBLSKR89XkgW/oRkJHlxFCRPibsUpKJ927spwB5rmP0MKC8PpfKsYZId0mZ/op3zAhpbHWG3tvH
	QA1nSqDUSbjh0y+gqkbsO68YkoltF4meh+tr2dJO/Ky82TYY7VkGLVRDHje7lY45hoIlw1Sk1uf5M
	SNJzCdxkC92L1o97dXis9m8g3Ix9Fa8+JiJOWoASURxuc+ILhBLVrYJOOrABwlxJmWssUIc3o0URz
	MHcZnoVXZ+3Tyr0ZbgyKSrok0uL0MkJkjQ+hFHbrjSL8ODoOg20kTvwv0t2bN6T66w/S8wiSNz9VZ
	2k77vK0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gv1kG-0003e0-9p; Sat, 16 Feb 2019 15:19:12 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gv1js-00038L-5P; Sat, 16 Feb 2019 15:18:50 +0000
Received: by mail-pf1-x444.google.com with SMTP id f132so6288732pfa.6;
 Sat, 16 Feb 2019 07:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=SIG+Lmpa8nZxwp/WdoBDzBbfQWf8IQ+YMup+W1n5rIA=;
 b=qIlJz3mpCgeIVKE4/QPwLeAiUZ2jiD504u9gTdtZ2egCr0V8t53TxQb1jLUOzQWcrA
 Vb1raaB82E0YndMwhSmn6WxILZu8Vv51zShas5SdgRYlCi1q+iDsitgd/FiP3QGtVKy6
 DZaZ+NSGspUWzShZ0H5GgKVH8yPw5NsX620Lf5XPuS2QcFagHeXigHcp22yhxHwUjyEt
 pb5QOxXxU0kvic24exq4pyKGLfQHkDx8R8D612OTPB7K/cl7VzS3u55TS3Mw6Jyca8ip
 h7dqsX7dkjUGtEdsZv6Rw9qLveuFmGfXHyY9si23dvHkj4I6sPLLFpa+jjXyAGdTCfto
 pVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=SIG+Lmpa8nZxwp/WdoBDzBbfQWf8IQ+YMup+W1n5rIA=;
 b=b7r3vl+4N9uVj2OLhgXbu5bRdM3d2taOoz9tg+PDIUIVXdsUxwLYsJM+5stTRxjcad
 sUJkBP+auNlqfSe5K5fEEkDdCSMvcDV/zE40J4iqO5dmmrKHRGnIkrhg2WHDi931H+Yd
 mzO1jDom/CCLy0lMOvG0SeUvQGPHqV9GKOPo+6VykOQl8eDAhhL8GqJUn71CKmrq79+S
 LzZdZqd1P8J8WXzTjrGwsAaLajDvhHr0Vdy2Idku4g3KTgVv6J9dxSRmCE+HqVtMRGib
 kdCIXMHBHqx793146lGjB8UqA/IY+KjYbYS7B3odx8ZCGKHQKIfpRfu+OiQWgapdXeJe
 5jxQ==
X-Gm-Message-State: AHQUAuZK/Yzl20mFARv9j2MvWHaS+YYwLnoQNMe/3GeObhqGZhFgssRO
 ofozKchUP99kX2FNVigwWWs=
X-Google-Smtp-Source: AHgI3IY+Xsf+vgV6zCpM2LC6oINCYqpY2j0HCRScZUBs7CsqvJKaOaraRdTsaTtMp6gOrQK1U5jB+w==
X-Received: by 2002:aa7:8d57:: with SMTP id s23mr15131241pfe.237.1550330327281; 
 Sat, 16 Feb 2019 07:18:47 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id c124sm12197367pfb.3.2019.02.16.07.18.46
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 16 Feb 2019 07:18:46 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: cw00.choi@samsung.com, myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
 heiko@sntech.de, thierry.reding@gmail.com, jonathanh@nvidia.com
Subject: [PATCH 2/3] PM / devfreq: rockchip-dfi: remove unneeded semicolon
Date: Sat, 16 Feb 2019 10:18:25 -0500
Message-Id: <20190216151826.11584-3-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190216151826.11584-1-tiny.windzz@gmail.com>
References: <20190216151826.11584-1-tiny.windzz@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190216_071848_557098_B73A3E09 
X-CRM114-Status: GOOD (  11.93  )
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
 drivers/devfreq/event/rockchip-dfi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index 22b113363ffc..fcbf76ebf55d 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -211,7 +211,7 @@ static int rockchip_dfi_probe(struct platform_device *pdev)
 	if (IS_ERR(data->clk)) {
 		dev_err(dev, "Cannot get the clk dmc_clk\n");
 		return PTR_ERR(data->clk);
-	};
+	}
 
 	/* try to find the optional reference to the pmu syscon */
 	node = of_parse_phandle(np, "rockchip,pmu", 0);
-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
