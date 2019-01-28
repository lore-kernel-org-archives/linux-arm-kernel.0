Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0414CC282CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:14:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6CEC214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hPds0l9j";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="nN/k7Fbp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6CEC214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FqIwlFL9iyRPUv8ksc7SbFWgmZZ59XnnJCpPJTZrsw0=; b=hPds0l9j7sie1O
	reoiofHCSJdBg0wdSqa1dF7DvKGblzOqoilj0J2qfrMM0/RSH9YJfjtyo1xsPKq8jjINa0tU7h7oB
	Qmvu10cGjTFazCxW3CUfzrhpTFVQjVXQmRgxNlllODukdZV9YofkQO/fDDE9YR0YxklxvBf4JuD3k
	hstV+uaZwhtDtNPT1GyLJkGAJQyb/CmOFGOYM+BLpvWIJqUFI5WjfMm+RSnkMNA8B2cmc+e4AI6a5
	EmFeQS4qLBcxqAo4DZp/b9+G2pZClxt3k+ymqe+MR5ZHO7eiSW5ZLv0hmww7N6Ui5n81OuGEvg2wA
	iW6llwTa6pX0G7wDrgAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go7fk-0000S0-S0; Mon, 28 Jan 2019 14:14:00 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go7fX-0000EZ-IZ
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 14:13:49 +0000
Received: by mail-wm1-x341.google.com with SMTP id f188so14005017wmf.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 06:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=i34Wa4ADtzVgCnN+6BAW5HuYsfawNRONPMGoZ75cMs4=;
 b=nN/k7FbpAUE64ZJ4WR6w9uRIWEkLkPoZ+cVxUdGEEuOmK94KEmUGLC84+KILKRJPOb
 HRBp4DT7CjxeTrk7isZqx2BxmpcppcUHhHOsXZ3/YYL168nJCUUcU5A1ZyVGzU6eGC09
 Yq6QN1mgdUeYHLQ/xoGF0n0TeRh17I+zodvtbvK1VEs6pWxDQiC716qgs4katlAPZQvp
 z65Lu1sU+jqc7VF9cuhvXp7vMuLPWmKZcwgbpK5QmifC8cgcW5tZmVY3mewtdr4TQjzz
 nmEQLVVvnEnEfkkW/xbOfi0Kmm6bBahqaa5xlYPECTpVWJhRmxFvPwVquAJ5ztd0n2aZ
 jSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=i34Wa4ADtzVgCnN+6BAW5HuYsfawNRONPMGoZ75cMs4=;
 b=bibr/jxqk4sZO7IxytgF1fOJHtViJb9yFMGkKIbnLMyfrMz43Iyy1r7VS+tjpnqPEA
 y54F073Q62NEEIm/E7sgivSWvMGRvVWDdoli1Q7LrB93aqEOIfgNAc2mXgP1akimwsFg
 C1weNQBB/5JK7AnrCd+AQnyvY26IItfWorybxs3Kd0dT0w3ireS+qdaW6o9GoerHd4Rt
 VNoAlwgWkB0nSxGYMjdx6lSr4Mv6H8zFij5ukBHB37x40jIy3IJiqbZneMyvqXbsoPUF
 uqavXAsG6nfaalnqvhOXGIPAEzstuLe/1FTIi/0vmkYyv2sn0ckpY4VvTUg96dMa2MKs
 FwBg==
X-Gm-Message-State: AJcUukdytITRmuztCSnoUmYtY6aaLZ+lEM/olHx/Lixsec8psJkb2hu1
 JbZNz9kjL3mKghsSX8hMKJqqRw==
X-Google-Smtp-Source: ALg8bN4tpAILmud2M1w3bNvNLvOKtgMuuj4xC5W/XQizrhj0boUG9X/8cHDti63hP7KY/pygefsRxw==
X-Received: by 2002:a1c:650b:: with SMTP id z11mr17348894wmb.23.1548684825650; 
 Mon, 28 Jan 2019 06:13:45 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
 by smtp.googlemail.com with ESMTPSA id o9sm44131913wmh.3.2019.01.28.06.13.44
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Jan 2019 06:13:45 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 2/2] reset: meson: add g12a and generic compatible string
Date: Mon, 28 Jan 2019 15:13:30 +0100
Message-Id: <20190128141330.21927-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128141330.21927-1-jbrunet@baylibre.com>
References: <20190128141330.21927-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_061347_669609_6498F432 
X-CRM114-Status: GOOD (  11.78  )
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
Cc: devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add a compatible for the new g12a SoC family.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/reset/reset-meson.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index 5242e0679df7..a8f6549b3af4 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -134,6 +134,7 @@ static const struct of_device_id meson_reset_dt_ids[] = {
 	 { .compatible = "amlogic,meson8b-reset" },
 	 { .compatible = "amlogic,meson-gxbb-reset" },
 	 { .compatible = "amlogic,meson-axg-reset" },
+	 { .compatible = "amlogic,meson-g12a-reset" },
 	 { /* sentinel */ },
 };
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
