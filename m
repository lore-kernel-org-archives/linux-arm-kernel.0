Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DE1C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:03:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 130502082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E5iIHGrm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gG+UfqWj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 130502082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kgZpygjW6c1XaBnQV2H7TISnZ2z40CbDhwx62NoFBsQ=; b=E5iIHGrm2JML7Z
	uA0AZ/UglEGVAOdtnsQgA1r2Wdja/hjNWde/aUYPyMM/yatMJ+91t14BRBlBMd/fXx7Qm9/yGcr0i
	nJPc4DK/9FPx6+RiDVf/QdM2ttIXgnAYzcbQdlgOzRF5YS9ljSt8Z+S0K6tKCYK20qD6c6keVLIIr
	VaiwtKnF1O9BRG1K5UNSU7gomwtS2MSERB73M/Su3DoU9PQ1vzzZDSKx/vt5ZFNzPjao05h2AFCQQ
	qsJdG6tvhQGwwrsuiYbU/APRxxkklU8oyVhBpXZN9ZNnhvjafAZNyvaacJcqee3yq5szE/W4js53k
	9/PZuaz895q4DPNxe+Ow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUh8V-00070Q-Nu; Thu, 06 Dec 2018 00:03:23 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUh7u-0006Qo-Mw
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 00:02:53 +0000
Received: by mail-wr1-x443.google.com with SMTP id x10so21476988wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 16:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lGHDul39zNeZWBwTbhWQ3Y086neguPWhN09izxgMWVw=;
 b=gG+UfqWju0f6a7nHRvauIN0ynw03rVtRJqbOTVvnkM2gZ8D6YJPN+U6K/nxVNwO/9s
 z3x6Gt2G2eUrSgEY6QG+98vGpgR6lP8XQX3EogJbssU+6MTZVT5Uo4wbwe3B1uUFu/FP
 VUSxhx01yjEKVdMZoiWvxGtjjmkbfb64rR4NY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lGHDul39zNeZWBwTbhWQ3Y086neguPWhN09izxgMWVw=;
 b=OaIgAalEGiYL93wCM46YaLJk+9YDvG3rW/6t/tJmESLEz0ulfnvoFkbA/oIsd01gPU
 k1oU6VR8DxyrwWC+is2+xfuTWKXyCjASzuCNFDcfm4AvDDoRP5Aorlb/Lg3mMmDkzLbt
 sRyVXRQjY1nj03u+dPlBJLk6oDL1JYq3V9JAS5LaZTLcU+f+Qgd/pcIr3Lrki8hd5Nwq
 Z+jhZqCygxy4CwoW7ZYTSgXSIDROreIJXQY2cRhuS8l1u7ikJ1fMOFitpcD9JqpTffkW
 RXE1YRCyFquJ5NcAdAdVXzQ52GSRMJa3GhlQY0X7EKNxU97X5kDI5l/1J+tCqZ1Lp4X/
 iz9g==
X-Gm-Message-State: AA+aEWYmBUv+2xmIDrKU/MSa+pVy+OtbgwsJDHIpZOhN0+Tf9LFnApk5
 N6eBSJd5yEgDR/c2yPcOOM2G+A==
X-Google-Smtp-Source: AFSGD/VGN2fxC9LsfM7b/Y7ytGz0oiicWZfnWnkkMqCHiekPAcCJz/y4ynBuI50dn4fm5DQ2UoNKBQ==
X-Received: by 2002:adf:dfd1:: with SMTP id q17mr24530716wrn.27.1544054555123; 
 Wed, 05 Dec 2018 16:02:35 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6815:3901:cf0e:17bd:f425:fac3])
 by smtp.gmail.com with ESMTPSA id i9sm23241184wrs.34.2018.12.05.16.02.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 05 Dec 2018 16:02:34 -0800 (PST)
From: Mike Leach <mike.leach@linaro.org>
To: mike.leach@linaro.org, linux@armlinux.org.uk, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] coresight: etmv4: Update ID register table to add UCI
 support
Date: Thu,  6 Dec 2018 00:02:26 +0000
Message-Id: <20181206000226.2507-3-mike.leach@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181206000226.2507-1-mike.leach@linaro.org>
References: <20181206000226.2507-1-mike.leach@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_160246_750507_C77A8213 
X-CRM114-Status: GOOD (  14.28  )
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
Cc: mathieu.poirier@linaro.org, suzuki.poulose@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Updates the ID register tables to contain a UCI entry for the A35 ETM
device to allow correct matching of driver in the amba bus code.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 53e2fb6e86f6..2fb8054e43ab 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -1073,12 +1073,28 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 		.mask	= 0x000fffff,		\
 	}
 
+static struct amba_cs_uci_id uci_id_etm4[] = {
+	{
+		/*  ETMv4 UCI data */
+		.devarch	= 0x47704a13,
+		.devarch_mask	= 0xfff0ffff,
+		.devtype	= 0x00000013,
+	}
+};
+
+#define ETM4x_AMBA_UCI_ID(pid)			\
+	{					\
+		.id	= pid,			\
+		.mask	= 0x000fffff,		\
+		.data	= uci_id_etm4,		\
+	}
+
 static const struct amba_id etm4_ids[] = {
 	ETM4x_AMBA_ID(0x000bb95d),		/* Cortex-A53 */
 	ETM4x_AMBA_ID(0x000bb95e),		/* Cortex-A57 */
 	ETM4x_AMBA_ID(0x000bb95a),		/* Cortex-A72 */
 	ETM4x_AMBA_ID(0x000bb959),		/* Cortex-A73 */
-	ETM4x_AMBA_ID(0x000bb9da),		/* Cortex-A35 */
+	ETM4x_AMBA_UCI_ID(0x000bb9da),		/* Cortex-A35 */
 	{},
 };
 
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
