Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F62C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:00:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3754D218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bZq+u/tX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jRIUyLp/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3754D218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=95zea0rmxChC2E3Gl4uBtDpRa9IQsTAN1rP4O7mE6Aw=; b=bZq+u/tXO1ogqO
	5NBI6fGfP31AbOQ6+SjEZqcsVaorRKHLTNSHFu0Ix+ntFPq18XMqA7egb6cD1AeDlF6hjGiJu+7X6
	Ufu1D+rDn0FtAUQ9F14zQIw7quQN1moNwYQ3EgYgEfWQhl/9RpUfuP0oyy70lfdd0R5efTtnR/D7i
	j5PMZoNDz95P0G2I8jPh4loF7yPwx21pAcQdYevI3FrVM0HTGwjLdEJEn/YD8Y8gTAOSySr7tj3AP
	K6bQQZaDBkcotVdDJIA4ZJJNwNsrpLdhi+VRjIkggjQRJWTNldiiQeG08Zfy0r3Ft6UzoVyZ2t+mR
	dV7+E1zZrMPR2avHB/9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZNPv-0007pD-MQ; Tue, 18 Dec 2018 22:00:43 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZNPe-0007Yp-2b
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 22:00:27 +0000
Received: by mail-wr1-x444.google.com with SMTP id z5so17462676wrt.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 14:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ydSAlnd72VkQ6lGpPSCbYq4vE2P1PydjacJOrhz/zN0=;
 b=jRIUyLp/4QHRrny9LWddhWAJID7GF7mlDFGuK2DnWoswCv7oSP10H/WQBrHtf9JYve
 dakU/umJ5DqsjpHY0X7DjOIWA3ATFeMt4kItii6TFazvHROYMg1NAZNsdjtxu8ja8eH/
 ukVCXTHZYrYzF5ISBZ6jUyVKuTLvWgbUhMtsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ydSAlnd72VkQ6lGpPSCbYq4vE2P1PydjacJOrhz/zN0=;
 b=FSsZr9ucgThFCivo3gs3R4pxnYsNkhN19ihqMRD4oGm5jSqA5c86AWUvtGWg0An8oO
 Fx08OhVpnPmq4G9s8vtvl5i/PjZi7zwW0AbJ6voG8YGTICLglirFBX+NDHbQxq085Kdi
 IdpY29bpwBFOyTnPQeHOQL5BqmODKsouZDvuxHxn72UvCiMW8VNVomwjZl1bbtWs9Oqj
 oq8jqx9oGh8wDVAAr9uhE5f01KyaD3ieiajmJ9QcrMHIE1ffEcbogcFhQmBOpQs+bswp
 iRsoVNMAyS/l6Q9nyEIwPBxky/FBq4EGnkv2GV4CeGURJo17mu1tgj0LEpTkqbCQ2g5a
 9fNA==
X-Gm-Message-State: AA+aEWZkckZIbF/++GUIomb5VwC5/WdmskOooKu1gYhHn/ySpqfpOxoj
 3Ac8todw/WyL1zsvn+33ZxxEUQ==
X-Google-Smtp-Source: AFSGD/X2HJF+QVbYmnu/lOvYSqSKJL59TR2w9ELRB5bh0VQmaesbuMLoNXj6oTdNGAYM8hKZyRELhw==
X-Received: by 2002:a5d:68c3:: with SMTP id p3mr16815373wrw.34.1545170414485; 
 Tue, 18 Dec 2018 14:00:14 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6815:3901:cf0e:17bd:f425:fac3])
 by smtp.gmail.com with ESMTPSA id x76sm7449158wmd.27.2018.12.18.14.00.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 18 Dec 2018 14:00:13 -0800 (PST)
From: Mike Leach <mike.leach@linaro.org>
To: mike.leach@linaro.org,
	linux@armlinux.org.uk
Subject: [RESEND PATCH v3 2/2] coresight: etmv4: Update ID register table to
 add UCI support
Date: Tue, 18 Dec 2018 21:59:44 +0000
Message-Id: <20181218215944.2444-3-mike.leach@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181218215944.2444-1-mike.leach@linaro.org>
References: <20181218215944.2444-1-mike.leach@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_140026_114345_F5C5E819 
X-CRM114-Status: GOOD (  13.88  )
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
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Updates the ID register tables to contain a UCI entry for the A35 ETM
device to allow correct matching of driver in the amba bus code.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
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
