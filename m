Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6DEC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:54:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 483F820821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qKO6BFMZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="RtODiqXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 483F820821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5+AJBl4aQkdY2D3OP6EPIdClH/4c0ffdY5gp+qHRiwY=; b=qKO6BFMZIOy037
	q5zqgBJ7/vdPv/J4ImN2Di3J5WQhuaEqaTyA4GIPSyWjO89c3wze6ENjA+x6BzHxwovISdTinltJh
	flHrRJtLT+2IK8fRlFErx6fDTm5iSSjngt811N4JW2feKz2lDBYCzC/ylFO5ZDO9TkOez1gWbNoKE
	bOBZ4k0Pm2QhN8hAgh0Yd3nsOAPuzdaVy/NAeJWgBgysSN9+08sQttaBH6/B+9KCu1s2oNCTTqRLR
	EVsqNVe3nqu2MtEPrXk5TnDrNdPtdLVrQdAwMOkNSBagjFJj0hRYKWrEC3CFiYShRQvC02J+ur+7p
	t1cDQcycBnm7BMLOPUog==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWK8W-00015m-1f; Mon, 10 Dec 2018 11:54:08 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWK87-0000ei-Lw
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 11:53:45 +0000
Received: by mail-wm1-x343.google.com with SMTP id y1so10568984wmi.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 03:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oKwkzMOWRQEWFTLUklhPX6+c5oXA7cimHYq8AEDDkxU=;
 b=RtODiqXUztsCylKr84fXQveBZmLrwdH33lyx6NYjXRPPW87KzwTSDUG+9HL1+BfYbg
 nv9abK6HfEuDCL/k46RuMBswxJhvoJbuPy7l7XJByxGo8lFRhpdd67Tck1f3Z0Xg7I2y
 s8nfDbSFnDNP+JVdETweX8HcgcYPOstKCqQdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oKwkzMOWRQEWFTLUklhPX6+c5oXA7cimHYq8AEDDkxU=;
 b=WHWRkV3MC95qtqQVqhLUtqqIHsI9owvD6SFm86nJIMLP9tpBsDv0cdJkjQNwky3Pro
 vG9GFHTryxKbLvmc9EM8N5+x7dwwOT/12WekylIXpAlN8qQJnS5m01XPB/QwyVoRFjpP
 jgzKrWn/3z5MgghKlHLIx4ki74IL8GZbBWt8xXYDwfey92kR8/P8Jkfk875aEQikpan/
 +5X1TmKS28V1Ab9eD4vJuROYIrUObsECG8+/WBODBrxYQL+lq0mAU/g/Yvhv/57xuyix
 wa0FA9IFcchS+IdmcfdMiBHXV/Z6rGi9llwZXAJtLy0MjVRPv9qGIZLRn/fqgKHEjW4F
 MzNQ==
X-Gm-Message-State: AA+aEWZL1i0yO0SuppgccLM9i0OjYFS24K74FI1s9b0f6vlXh8Dbrss2
 0TGd3C1nqzNnnAzAfX/vwxx3vg==
X-Google-Smtp-Source: AFSGD/Xz8I6cN84X/FEMHiu6k8Bhi+MoIp1XLoYeowMvi97hhE28IVAlVvNqDdfr3ch1F+AqiR0zfA==
X-Received: by 2002:a1c:7f0c:: with SMTP id a12mr6650138wmd.89.1544442811948; 
 Mon, 10 Dec 2018 03:53:31 -0800 (PST)
Received: from localhost.localdomain (ip-162-59.sn-213-198.clouditalia.com.
 [213.198.162.59])
 by smtp.gmail.com with ESMTPSA id b16sm7869243wrm.41.2018.12.10.03.53.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 03:53:31 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sunxi <linux-sunxi@googlegroups.com>,
 linux-amarula@amarulasolutions.com,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH v3 2/6] media: sun6i: Add A64 compatible support
Date: Mon, 10 Dec 2018 17:22:42 +0530
Message-Id: <20181210115246.8188-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181210115246.8188-1-jagan@amarulasolutions.com>
References: <20181210115246.8188-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_035343_711621_633EF2B6 
X-CRM114-Status: GOOD (  13.87  )
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
Cc: Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Allwinner A64 CSI has single channel time-multiplexed BT.656
CMOS sensor interface like H3 but work by lowering clock than
default mod clock.

So use separate compatibe to support it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index ee882b66a5ea..bbe45e893722 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -892,6 +892,7 @@ static int sun6i_csi_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id sun6i_csi_of_match[] = {
+	{ .compatible = "allwinner,sun50i-a64-csi", },
 	{ .compatible = "allwinner,sun6i-a31-csi", },
 	{ .compatible = "allwinner,sun8i-h3-csi", },
 	{ .compatible = "allwinner,sun8i-v3s-csi", },
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
