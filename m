Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49209C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:40:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18FFE2082C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i7e5nbGz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="HYqf2z5e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18FFE2082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=v8vGzPB3zbyBJ2g6XtfmBKPZTvceZWSIXIb6ZjWBpfk=; b=i7e5nbGzGIcSXk9jNPSZzCHKiu
	Dm8RhZ8ZxddKssTjCL+5lnohxpHJ9IWIYzLT4tDp79f6raazuxKrTaGaTmTc5G7KZl6k+39SwaBYB
	twLvQ2Y9OkzWtTgdnKzooqRzqtxLiQqV8baonVnT+ShZCQSf+8E0S7DAsGmByYRillfhK3LapxPrQ
	bBoP9Atqs029ZLdHdz4ktwzYi6u34nzQH5t60YKu33UExRnn7TDyLv2P/MwYUQKjomkF7C4YnR8Dr
	OnvSX6xDEPv34nogUbEffrA3RwmTFER9rTyasI+4XUG8Q0339HwITsh6RBMADJ5e73J/iqJr4wdec
	/SPZM/dA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go9xM-000145-NA; Mon, 28 Jan 2019 16:40:20 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go9vG-0006kh-LM
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 16:38:22 +0000
Received: by mail-wr1-x443.google.com with SMTP id r10so18762584wrs.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 08:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=fyBQQHTr8PUOvMNC5TSDB366cWfD8A0+KHCn5LVVNH8=;
 b=HYqf2z5eD3+QLpuQsIa8Phc08x0KnTYkWPWdqhent4WHaKgV4AbHrdtuSEnDNKkNea
 scxM5Kd1hkFVFFI5IHpusyuIjntVpb2gnbFpH79sCOqq5mBgtfdPApxIgeCI0uoboDz7
 CmTfvBuda3ITtikhX8QxoAqgbZAQgO/hztL1G88Gyxh6/tf2cqnOxQ6OKQGiCFlpfKq8
 7Ld2pI88cmWYyySZhmb1YoxRZF0HfbJauuKsWpbg9ssVMXAv3mh09+s0BgXqfyLxXxxH
 ghdjIouftGV65Hgm1OLT7E7tq70USf2NZLEJlM8dJ8EREsqhBC09RG5Na/qrCNvsNWyJ
 +BTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=fyBQQHTr8PUOvMNC5TSDB366cWfD8A0+KHCn5LVVNH8=;
 b=KdG69L91dJ5wSyimciqPYiZFNzidPzapgo+2sU12vB7qi2/8jlcs7gAIS3em44GKrK
 xbL4yGv9eDcb+Pa9HcbNGjQyZs5xNJJUtzhrMmXBim7kjfl87urh5VJM4j+V47L4Ygtw
 vcu0VIWnymmIcxohTsJI2WdSc3E0UYidmdhC18DvH/tgGCF0C1vtiOKEcGhE/rLp0Juv
 13GuwVfzJ0Fj6xjCBcw4QHf8klXBrHEeEZ5UZY6u8nJetCJvvBAKFsOo+MUAE9KF86Kp
 cFiD/kkCiCGmeaAAyUotq2vrckV/cH2CHTd05lNMybiPb/b0PqEu64V+r5SmsgCbPhxH
 4uDA==
X-Gm-Message-State: AJcUukf87AbNgvV4SWZJnIWkMJHkPcJhEQh1S7bAv4Sd2k1KUufTM7xA
 ZV42nZddyJzw5oOGYo6etJDAMQ==
X-Google-Smtp-Source: ALg8bN4/B4SWxIm7vCUbRYvn874M1dL1HvhVWIsz6SyWTxC8hna3Zz/YBgIob2CzSREhZRSEL60eAA==
X-Received: by 2002:adf:eec9:: with SMTP id a9mr22139027wrp.242.1548693489225; 
 Mon, 28 Jan 2019 08:38:09 -0800 (PST)
Received: from loys-ubuntu-BY1835A49200471.thefacebook.com
 ([2620:10d:c092:180::1:d40b])
 by smtp.googlemail.com with ESMTPSA id s3sm52388982wmj.23.2019.01.28.08.38.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 28 Jan 2019 08:38:08 -0800 (PST)
From: Loys Ollivier <lollivier@baylibre.com>
To: devicetree@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v3 3/4] gnss: add mtk receiver type support
Date: Mon, 28 Jan 2019 17:38:00 +0100
Message-Id: <1548693481-1162-4-git-send-email-lollivier@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548693481-1162-1-git-send-email-lollivier@baylibre.com>
References: <1548693481-1162-1-git-send-email-lollivier@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_083810_915401_1A43EEF2 
X-CRM114-Status: GOOD (  13.04  )
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
extensions.

Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
---

v3:
Moved the gnss_type_names string addition to this patch.
Edited the commit message to remove the reference to a vendor protocol.

v2: renamed from GTOP to MTK.

 drivers/gnss/core.c  | 1 +
 include/linux/gnss.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gnss/core.c b/drivers/gnss/core.c
index 4291a0dd22aa..320cfca80d5f 100644
--- a/drivers/gnss/core.c
+++ b/drivers/gnss/core.c
@@ -334,6 +334,7 @@ static const char * const gnss_type_names[GNSS_TYPE_COUNT] = {
 	[GNSS_TYPE_NMEA]	= "NMEA",
 	[GNSS_TYPE_SIRF]	= "SiRF",
 	[GNSS_TYPE_UBX]		= "UBX",
+	[GNSS_TYPE_MTK]		= "MTK",
 };
 
 static const char *gnss_type_name(struct gnss_device *gdev)
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
