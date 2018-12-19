Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9424C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:58:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A02520656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EOwPdW9u";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="F6JKn1yV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A02520656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ingics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=fbF377BrYQPJpxIQfPIiPnrh0drnVhTTX6FyVgVOQS0=; b=EOw
	PdW9uBpz7f6/U+DWITZKYJTZoUtyQTeyKKzN8IuSAEjN/jLSOT6yqZx9PKSytIGG/+WyBMz+7BjvX
	mjvppuqTYVbZB71GR0csef3PYehC2LlANxEbHhJEUpist+QvO9YHOTf9/11hb7xKDMhhP+RajTY8p
	2mGO6TfyxNHep7l4xEz2g1WDYae9JgAFuEnbY28Hu7WBqUpA0eY1MxlW/kV9tKr1JjZTnuWumP7ew
	W9LklOM55NFc5U4H8UccdZTeB/h/XlXSyc9RedmmiftmH3zxyuMTempokR9fjOXPQi4f2n1kGw1DF
	9SDwYJg/Mq99LcW+amFnlCLLzxNHNHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZXgU-00030m-24; Wed, 19 Dec 2018 08:58:30 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZXgQ-0002zr-Lb
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 08:58:28 +0000
Received: by mail-pl1-x641.google.com with SMTP id u18so9170865plq.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 00:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ingics-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=W6pQQtiooT/ADwr0XYoNIMzL8tlsJR0JaZNF4kZWDrI=;
 b=F6JKn1yVP5lueLtgwPxp+yDvWTFKRqcarEHE2WzP54jpxFRj9lmSC5ZAG00/jHWcTY
 Gbo3IX0oRABOpflxVI8bc9aFze4u4uLuY97yD/5lKm9M0HWoPHiVljCz5/YQ/1gZsqys
 3FTpC/eVnii5SxDq3XNKdlBHavq6IQ3xJy0MhNGXZsoSZTgdPqjQphveI7xkkutmQo5V
 RQ3wScEFadf9+sRXO6hEWuyVJ7HC292JEsRdSAQttv+kL1Vw3CBRIKlUs2ttVtEgc+iy
 Z53LQwi3/mwVUXYpgO02ButEAKKnlpF249qTToh4dWqX4XhcXgYaMqxMqoyvRteQ+Qaq
 +Rtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=W6pQQtiooT/ADwr0XYoNIMzL8tlsJR0JaZNF4kZWDrI=;
 b=KTfUf16Z1WHwYvgg5g//JQP2anXUvwHy1RUi/SB8uK9FOvIjvaq2hRmchzWOR6rQWK
 g2CnhUuJ32CPx46i3alpWbeLTrVk3vwq7+DV5U1+P2znaW1vN5DYK67pAJAF6xmtDxL4
 hmO+P7xajrWw+JCnXcAWdvBT/5FlLqF31SwJO7FER+g/TJSGIA9ppRJITIcRvfgHwYpd
 ofX4mXY2bdcYsGim0EF53BkyK9PnVuYY4i6YC1QbbSnffgTgxvMa7E9b6RB3BEdaBpRc
 w/praOKc3Flz0+I0CC2bjg9ieo9QrNWV4aT4nsbGctETag+uUvZzqpgAViEhnBTHA/L1
 /fBw==
X-Gm-Message-State: AA+aEWYPa7iZPHH2bvUcSin/3tTkiQLXPjEt12jkE3uTx6Pbcp2ody/k
 40BBgl/lUzO0g6GcHn4EUxi3Mw==
X-Google-Smtp-Source: AFSGD/WRNTZZ+dSdON4HcO3tdpG+votukG8IzssFHtAmdV/BWQCB00sapVwCAUgFLY3LS8Wf2K6B/A==
X-Received: by 2002:a17:902:e290:: with SMTP id
 cf16mr20038663plb.81.1545209895409; 
 Wed, 19 Dec 2018 00:58:15 -0800 (PST)
Received: from localhost.localdomain (36-239-224-74.dynamic-ip.hinet.net.
 [36.239.224.74])
 by smtp.gmail.com with ESMTPSA id e188sm21896281pfg.130.2018.12.19.00.58.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 19 Dec 2018 00:58:14 -0800 (PST)
From: Axel Lin <axel.lin@ingics.com>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH] regulator: mcp16502: Fix missing n_voltages setting
Date: Wed, 19 Dec 2018 16:58:04 +0800
Message-Id: <20181219085804.9601-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_005826_706811_50CB562B 
X-CRM114-Status: GOOD (  11.02  )
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
Cc: Axel Lin <axel.lin@ingics.com>,
 Andrei Stefanescu <andrei.stefanescu@microchip.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The n_voltages setting is not set, fix it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/mcp16502.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/mcp16502.c b/drivers/regulator/mcp16502.c
index 25d7b433fafd..ec5b6836a20c 100644
--- a/drivers/regulator/mcp16502.c
+++ b/drivers/regulator/mcp16502.c
@@ -90,6 +90,7 @@ static unsigned int mcp16502_of_map_mode(unsigned int mode)
 		.ops			= &(_ops),			\
 		.type			= REGULATOR_VOLTAGE,		\
 		.owner			= THIS_MODULE,			\
+		.n_voltages		= MCP16502_VSEL + 1,		\
 		.linear_ranges		= _ranges,			\
 		.n_linear_ranges	= ARRAY_SIZE(_ranges),		\
 		.of_match		= of_match_ptr(_name),		\
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
