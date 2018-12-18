Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB319C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:34:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CB07217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b81gDgV2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Dyp9G4/e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB07217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o9x3Prw3b7N4sn2xZYTAGANn9hrWu8vsZGR+XzDIMl0=; b=b81gDgV2KVNPmE
	+BrUMKCCnkFAUTftAsU3wb48+U5SqxUb+irJwx/Qq+saJxTGnfpVtP1/Nu87omLY7LkxJ567nqNm4
	/H7nkYEbRhYrUh2wGFfV5Jtrka26EUlWEtax60ChKe4h0XDz5bgMA5gYcqbJPxINoetORIiDeTNxw
	sr8/sITAIxWv/o//zXKIqBMZuEeES1TzyitwoZGBKDp382SfpuEoAcn7TrNPcL31RBc89ZKndlRIm
	Ll4vAfj6HFRRYDqkn0RU0I9hhR1srk+jZEfkRN30CaviDLttoo+aJ8u5gRM9CayAxPeYWB28H/eaw
	pohTC0MgFab09PAGU8yg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZDdd-0002iF-FL; Tue, 18 Dec 2018 11:34:13 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZDdA-0002D2-Lw
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 11:33:46 +0000
Received: by mail-wr1-x443.google.com with SMTP id z5so15515141wrt.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 03:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tp2qTP6b0v5Vb54Ya9denLrSJ0P23sY7OEhQ5x0BuQw=;
 b=Dyp9G4/ekeYXIOjOjpiWgVd9vebimJb9fRIf1Xc3jcoJabiZtusXwthfSgo4oTLy+u
 X/LwvbVkkRx7XUDOUKqkbUANBdGpW00sWSJNIbT51PuJrYH/FHbgWIffTh815hutWXnt
 dtdOmBUs/595yPrQbizgIqEF5OeH7PeoYHPDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tp2qTP6b0v5Vb54Ya9denLrSJ0P23sY7OEhQ5x0BuQw=;
 b=PaaC2Wa+cLB1mUo8U1h4hu1/hu9+jvetz5wRr98dVq4oTNFcRV0KLuZRfoAa58eadW
 E/Vk1jvOEjHpc6Nb5J6CoR87lrhfjyF5XnmoC4zTlzIioWrYHrhfEvNLectRPnqMpq12
 pTjeDgZOcdtGQYLQSQY/44NuKVs2BFnHtSKBhqmhfiT6eJx302kw4FQ9IHBESrnCZTZG
 2joAqy3XoWHeHEylY9xLYEpDXYhxHX3ZxDUY+BXCLCd7m50tx6DwSAfN15nEBFQNPL8n
 0KwjvlXZTek8SnWsoeF2Ujz6/vIUbQ+N9KpuIP+l4hgYBH1FX0Z1QUYxRGn6icNZVWfi
 qmPg==
X-Gm-Message-State: AA+aEWbCWSO1nrNNkJZtBneBTKoC80mSv05fdeqhgKY3aKb+aKKTdx5G
 HQWA2szKMYjINH+CK21aJ2Eayw==
X-Google-Smtp-Source: AFSGD/UBnj2Lpi4jkn0o6yWcZcSfQE5ucR9VFQkE9SDOdqSMiaik7KRdoJ3yAEltcutn/NWo0vNsTw==
X-Received: by 2002:adf:e149:: with SMTP id f9mr15577466wri.42.1545132812924; 
 Tue, 18 Dec 2018 03:33:32 -0800 (PST)
Received: from jagan-XPS-13-9350.homenet.telecomitalia.it
 (host230-181-static.228-95-b.business.telecomitalia.it. [95.228.181.230])
 by smtp.gmail.com with ESMTPSA id h2sm4276184wrv.87.2018.12.18.03.33.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 03:33:32 -0800 (PST)
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
Subject: [PATCH v4 2/6] media: sun6i: Add A64 compatible support
Date: Tue, 18 Dec 2018 17:03:16 +0530
Message-Id: <20181218113320.4856-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181218113320.4856-1-jagan@amarulasolutions.com>
References: <20181218113320.4856-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_033344_949488_F01B018B 
X-CRM114-Status: GOOD (  12.39  )
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

Add compatible string for Allwinner A64 CSI.

A64 CSI has similar features as like in H3, but the CSI_SCLK
need to update it to 300MHz than default clock rate.

A64 BSP is also operating same rate as default csi clock.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index ee882b66a5ea..9ff61896e4bb 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -895,6 +895,7 @@ static const struct of_device_id sun6i_csi_of_match[] = {
 	{ .compatible = "allwinner,sun6i-a31-csi", },
 	{ .compatible = "allwinner,sun8i-h3-csi", },
 	{ .compatible = "allwinner,sun8i-v3s-csi", },
+	{ .compatible = "allwinner,sun50i-a64-csi", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sun6i_csi_of_match);
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
