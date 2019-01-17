Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8828DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:55:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3976020652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cF/MQABA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ZMMVlo6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3976020652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Zx1dJQ+iYgJEDiDSptfiQCPjYvf6gT0+lh63XOeHQXQ=; b=cF/MQABAfBd2FldbFkHKz7+Z/3
	ObIxhpiSAyFOPi1DyNdYl5Q3qI2HYAQPxWWW+25phHt1/aBt7hG2Hl+5WO2seawXjWSBdruSNFodv
	V8ABVLzt6qa5HWBnwIevSaPYk+0xYEPKkRcMDg8i1DhkxZEtd+KFQS/4rdVGbamXvpl8cNd8BWgB5
	jMNy6R8kGUnL4qug2I580UaPm+xN6K4r0ItKYcgb+ZN/WsbgI5/yF9Q7/E7DPFxJJaKRP87IwszyB
	ILnQT+ZVsBTNQkF7XXyCCD5kFS5cbpOmRNQt2XR6/9NlYoP64ahuI6Ik3S7cWIUCGZoPPDTnfveoE
	PNGSMcrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkAxA-00046w-Pd; Thu, 17 Jan 2019 16:55:40 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkAwH-00024h-88
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 16:54:50 +0000
Received: by mail-wm1-x344.google.com with SMTP id y185so1513365wmd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 17 Jan 2019 08:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=9j/4jxpYoQpPS/+1F1W02eb69wy8a+vueBOw79dZhl0=;
 b=ZMMVlo6gORfpCiJzCTh35BEQkxOT58yOVe7R5axxirvuNI7pvedOR7BDZIct9vWjLH
 xHFV0uD762SYEPELWy4SofB0e6QtGlu1ob1ua8RM8TeB8wbwRVposUIq87sy7IaoQn4u
 73tRkOcyhtSpHqQ0gFzkYRaCC/4ktaZ1QjvMFQ8tfT05X14fL99Z6kMFrPJ8kIkGwmBS
 wA7cpklVkVKdRsxjfAaDoI+My9hdnV7DlJTPEc6bMhFY6A/WkZwKsKXOb2/pJF4B0fZ8
 WWuAEJg8YGYgiJu+N9hyMjQA3uHnjko42yKcCo7o7E/UHMMHU7estb/PGK65ii1164Hd
 Lhug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=9j/4jxpYoQpPS/+1F1W02eb69wy8a+vueBOw79dZhl0=;
 b=OS8XGXAOBa7M050zu06aNh12uIFMwWxNO3nweTV1qSSYh19myBcTFt63oC7bu6Zzpb
 osknKjDHGHbLlmESm0GcxtLGeSDE+IBfBI6Lk8wlXaWi7RSUCOgUPjxvUY8wUbL1J/Ya
 niH24PrXK0ZhPq44/mf8CyevF5mkD9AsQkw+7STtTdEz2s/nRHorqo9N30KAlWIzkQzD
 am1tGOoVUMAK4oYQpKto0tFpVbYsjo8rB7djJBc60MfMCfBNspaHgLNiXpsE/JKXH7RZ
 W1+hTGfWU9guRSTd9y7IDd5pcKWkAuYPWapMFHedHQYlOCxuVhD6tBAv2nR48A0cnIPZ
 xTxQ==
X-Gm-Message-State: AJcUukdBzNS8wlxZziRMZ82ljhuz3gS+sdd/6nRwvb13HCK4i8cQA4ow
 MXcyyDerSctj2gqaUI4u1ylc4Q==
X-Google-Smtp-Source: ALg8bN4JFH5Al+JSn0k9EAkO6wjhzOlxBRiDe8ShCU05xJYXuEkqlX6BaZPLbL8Ttdb1wmQQMZyM6g==
X-Received: by 2002:a1c:c60e:: with SMTP id w14mr13223913wmf.18.1547744083821; 
 Thu, 17 Jan 2019 08:54:43 -0800 (PST)
Received: from loys-ubuntu-BY1835A49200471.thefacebook.com
 (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
 by smtp.googlemail.com with ESMTPSA id b12sm65309630wrt.17.2019.01.17.08.54.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 17 Jan 2019 08:54:43 -0800 (PST)
From: Loys Ollivier <lollivier@baylibre.com>
To: devicetree@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 3/4] gnss: add mtk receiver type support
Date: Thu, 17 Jan 2019 17:54:33 +0100
Message-Id: <1547744074-28308-4-git-send-email-lollivier@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547744074-28308-1-git-send-email-lollivier@baylibre.com>
References: <1547744074-28308-1-git-send-email-lollivier@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_085445_387902_66A2AECD 
X-CRM114-Status: GOOD (  11.24  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>, Loys Ollivier <lollivier@baylibre.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add an MTK (Mediatek) type to the "GNSS_TYPE" attribute.

Note that MTK receivers support a subset of NMEA 0183 with vendor
extensions (e.g. to allow switching to the vendor protocol).

Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
---

v2: renamed from GTOP to MTK.

 include/linux/gnss.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/gnss.h b/include/linux/gnss.h
index 43546977098c..36968a0f33e8 100644
--- a/include/linux/gnss.h
+++ b/include/linux/gnss.h
@@ -22,6 +22,7 @@ enum gnss_type {
 	GNSS_TYPE_NMEA = 0,
 	GNSS_TYPE_SIRF,
 	GNSS_TYPE_UBX,
+	GNSS_TYPE_MTK,
 
 	GNSS_TYPE_COUNT
 };
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
