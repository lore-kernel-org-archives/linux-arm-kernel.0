Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2F4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:36:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C1A721902
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uLdcsWz0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUrTymBS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C1A721902
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=+BgbSXCXWXti9JXqy+bNId/9b0rVGy75Bh6LKT5UZDY=; b=uLd
	csWz0dlG/zsRsDBrRq9GS1JyF0IMWLMXFHLNMuw/EMQSzGlrd55DltWwst63E9mnZMRgSN4m578ap
	pmKfy5Euq3vQBKYDU1msBYR6W0fSfRtlNJFQCCgiT5YYeQwrDaeanv0xgKEkxAiChmeRvZG5ffMeC
	jlRK46oGe2ICPT8doN16KzVlZUxBMmGp7Wrzo5vzSQPUoYxC2N0RouAXfBQ0lzrMnHeeT2hXw04pL
	ZMZ86QXi+0qW6S/cREHELmPBQP11d2XUcMVvoFj7QiPaLap78bnNygxlQbrJJH9wWpgo1+Gc5bus+
	KuCIujzjTthBo4EJomfkYm17Ry8Tzjw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwR6V-0004o1-Sv; Wed, 20 Feb 2019 12:35:59 +0000
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwR6S-0004nf-CL
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 12:35:57 +0000
Received: by mail-qt1-x843.google.com with SMTP id v10so26917157qtp.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 20 Feb 2019 04:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=agopD1gzhiHpMGv4OdErEm1uxdxB/Ou+ntNJBEZUdwM=;
 b=OUrTymBSZ07RLQUHovlLji9oes8eaKkWTrp0fqnVXljim96P0AOgt7PZ6ipa6yMEBO
 jHBbA5JlG2JsghuHKTb/a5j6+j7iToS2YFQFhAqc78/bpuSUr4/BeuBHq2UNBTZUo5Hf
 D7vHHz3KNCPpnvPiIJgATgN0MUvYmNW6MMamrQfqbJj1HHPauTb9tbl1LGTbsBfT/bcn
 1xra8QUxVfzpY4B6q1Cl1tX8zM6zbpioLGnWjFv6nV1HplyYvSsv8zTPXYtDuEWTD53U
 kpt8ZUvJELXdNk1pY9z6OE6HG9utnoyy/N7HIzWKrWHykckyNTDxbI1DLQxAtNr8LHxp
 jQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=agopD1gzhiHpMGv4OdErEm1uxdxB/Ou+ntNJBEZUdwM=;
 b=UWt/0My1XXld6MYbvtc3V1jMLmAGLbANYPMHEn/LTv80N8Ykor2YUs/bFI5gH0J4vM
 f2eY2ZtO/w6m3IwmCm7t9uCb5qb99hstKN+m8n+ilwUE0miVmLxML09gfr7eoYVLvIqM
 DRJTtF8qI1cTBQl072MS+rNwSScFypnv61ePsIs+lx0xKoKd4mPVue8BWNovoNXtVE+E
 zzs/jXuqgCPWqbUMLDy1po56WqZHUDI6OJRy868a/35rCB/zUfnc++yuw+6oTzmikSlj
 O/nA0QJFghCqHN9uQKzCYUWf4kFFy7F2bxHiqDcvsaTxDQKVPo+0KqXU1b2OFFP2Doaa
 +VJw==
X-Gm-Message-State: AHQUAuYn2+zkIiGJuzdintd3IjC1GQAgTdekooYfpftxo8JKc9yR3QJ8
 kU3B+37ufRp/dzWBAo7B6U0=
X-Google-Smtp-Source: AHgI3IZq/29LDyZ/cSI8MfyvycXntZq7Hwhm0VgdDJH+3a9L85SapRRb9ovSJqZkjCRA3LF6ECsXiQ==
X-Received: by 2002:a0c:e64f:: with SMTP id c15mr6052588qvn.16.1550666151109; 
 Wed, 20 Feb 2019 04:35:51 -0800 (PST)
Received: from fabio-Latitude-E5450.nxp.com ([2804:14c:482:a73::1])
 by smtp.gmail.com with ESMTPSA id p186sm10315008qkb.69.2019.02.20.04.35.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 20 Feb 2019 04:35:50 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: shawnguo@kernel.org
Subject: [PATCH] arm64: defconfig: Enable CONFIG_SPI_IMX
Date: Wed, 20 Feb 2019 09:35:43 -0300
Message-Id: <20190220123543.15431-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_043556_415684_C4E823CB 
X-CRM114-Status: UNSURE (   9.82  )
X-CRM114-Notice: Please train this message.
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
Cc: Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Enable the CONFIG_SPI_IMX option so that i.MX8M can use the
imx spi driver by default.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2d9c39033c1a..f37e303188fe 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -364,6 +364,7 @@ CONFIG_SPI=y
 CONFIG_SPI_ARMADA_3700=y
 CONFIG_SPI_BCM2835=m
 CONFIG_SPI_BCM2835AUX=m
+CONFIG_SPI_IMX=y
 CONFIG_SPI_MESON_SPICC=m
 CONFIG_SPI_MESON_SPIFC=m
 CONFIG_SPI_ORION=y
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
