Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A699FC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:16:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FFE320851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Uf644sku";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="aYTFU2MZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FFE320851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rjRGACSkOoulBIS9kgLzdWCXuOzN/lwc0fweYreC5MU=; b=Uf644skuBTRl12
	efYKGQYpggwb26l1GoKdVH0P/vsv3pG1UBSyRz7oBN2Waxuy+x6+IG5/gzJXyFvBA4ht/0QLYceYV
	wc7xvwaHLJG4U1Nh3EfdX3+7Mmzqpdul/8rZzt8aWRe7DH76BobFy8B6JZ8MYhU1cMUiw0cAslG9+
	HGp6ptIq3/MQ/bQTi463IePQjGrj9ghLvx2w5t796LXQEl0HW8am9BbyRJm9kEVDaPKTHAWfbEsjp
	hhpUQCsE+K/yaV3uKLCB2lX0aUVK+RITLnZN6rbDbPg8Qr+J9GEEn5gGnRWA2Yr/T6vkGQmIMy82Y
	AfrOmGg8hmDjnlSH/SqA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTlH3-0008Fn-Ds; Mon, 03 Dec 2018 10:16:21 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTlGp-00080z-3n
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 10:16:08 +0000
Received: by mail-wm1-x343.google.com with SMTP id n190so2658033wmd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 02:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ENkdUwpMYIjikqqc1QhQM7T86CeGAWnXemUcHFbD02o=;
 b=aYTFU2MZ7/ghfls+aRabDUkSrsGcTIia9n7+ti02Ikl0zukh3A5R4+kPd/2PL9dVlB
 bVX28R9dBILXBboU99T758EvRQ64ucicqi4xbZOoPQA5xl4i9UJk2Jbr0oWzlYaAXKFE
 tBKfHjUHlUL1LsIpIe6D3i3HT+8bCZcuwP61U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ENkdUwpMYIjikqqc1QhQM7T86CeGAWnXemUcHFbD02o=;
 b=fu/7FKbnd3WrSONHAnGuidskWDXsqp7kU763mSr9pdDZjZrvcIIC6S10g2YRSDqV0q
 nBXfftI11vJ7K3fanAo9wBWB5xhzPAzy82OY/47alI2Ez+wtxhjqVyq6ueco6YnKrkvk
 Ic9waMHQ6LX2nhTlYPP5xrGI3TwwKyo95b+dEaAKTFGAsY5KmymqqxZx6rwIcdIGrDSZ
 da+u1QCoUdL/zpyT7GfSJOtRNAbaVYceI2DzUrojXhqaV9cl2BjQaoa5XV9RKudlgpaV
 jWTjtU32EYxMxOWIxH+hD9N/ocWMC0ohLCk1/EUrCiTVbeE3Srxk4qxp1mwAF3/ues/j
 nTwA==
X-Gm-Message-State: AA+aEWbmtJrkgAfqThIAn9mocIq5vqLgHpLiocK3++yOSs4DfOV4mvYl
 tc2kdYj7Rnz39A02Cg/RU57sdA==
X-Google-Smtp-Source: AFSGD/X7xfmFlqfllOFSoXoL/fsvUc05xC8M823dMGYQDptYklNoaRsVfRUi3/sznjvgXljdefiipw==
X-Received: by 2002:a1c:13d1:: with SMTP id 200mr4440666wmt.4.1543832164583;
 Mon, 03 Dec 2018 02:16:04 -0800 (PST)
Received: from localhost.localdomain (conf.hotelmediterraneo.com.
 [2.228.78.71])
 by smtp.gmail.com with ESMTPSA id f192sm5832158wmd.12.2018.12.03.02.16.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 02:16:04 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
 linux-sunxi@googlegroups.com
Subject: [PATCH 8/9] Input: goodix - Add GT5663 CTP support
Date: Mon,  3 Dec 2018 15:45:46 +0530
Message-Id: <20181203101547.16835-8-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181203101547.16835-1-jagan@amarulasolutions.com>
References: <20181203101547.16835-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_021607_178470_80B336F0 
X-CRM114-Status: GOOD (  13.23  )
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

GT5663 is capacitive touch controller with customized smart wakeup gestures,
the existing goodix driver will work by phandle vcc-supply regulator.

So, add compatible for the same.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/input/touchscreen/goodix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 7adcf1491609..0c09512bcdea 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -971,6 +971,7 @@ MODULE_DEVICE_TABLE(acpi, goodix_acpi_match);
 #ifdef CONFIG_OF
 static const struct of_device_id goodix_of_match[] = {
 	{ .compatible = "goodix,gt1151" },
+	{ .compatible = "goodix,gt5663" },
 	{ .compatible = "goodix,gt911" },
 	{ .compatible = "goodix,gt9110" },
 	{ .compatible = "goodix,gt912" },
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
