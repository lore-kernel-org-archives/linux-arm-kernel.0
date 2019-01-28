Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D3FC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:14:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04BFD21783
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y3ZzbmGC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="cTbvSyZi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04BFD21783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C4B6O0/roba+ibl6inUEBHKh5x1PaidtvPn0WhH2Ey0=; b=Y3ZzbmGCrRiKPy
	Ur2Dc2jwm1eS3n5PZeOP+z+BO/HpnkyCMqMSUtUjMbhJTWmRJ6km0EQwj4aMR5/sbV0wVr+eKPvKu
	T9AUbubTb2xXS0ir6KYyHHD09z9Jtyo/NejZoCEBALDt7HpLdurHqRnSS/PCkrTTs6Ls2YOAd+qVk
	jEL3VqA0/IEXC0xgdBhHP5jBa9+QNvD3Ln/ObEYW8BDw71JPJFI5JVjjmyrRwXp+zgkLKoy0cuSsG
	h8MQaKxz9dSOAcWeKvq0mDJh4TW/Qgz4/k+cD8O2upRBw9i59EhrT/8Fga3qmfJka6uTSr7m6Mgx5
	+pU7OQCZ+NfCxFX07KCA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goBQE-0003o6-RU; Mon, 28 Jan 2019 18:14:14 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goBPX-0003Bb-5T
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 18:13:35 +0000
Received: by mail-wr1-x442.google.com with SMTP id t6so19122196wrr.12
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 10:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fNWFoC3BVYguxhRUMdCWIfb/Rl7MMG8+du2R0BO4wEY=;
 b=cTbvSyZi34BO7xbHL7VjC4d2IpWNxC+mgHDwmQWegRazQajEzWNV54xiBuCNp/moMT
 HROWKjnIbA7JvT2vO0syVqfu//FmOgrFwOLFNMtFi8pr8Tq0FtjLa5c9XCQIPsJH+zFD
 O+ZmTWk8/TBzXmYurL45pGsohZ3RAFrIvQfh9yQjOZgoX64mDLyQTZ+BYrlE5eGcpG1/
 TIjagMrZ8OPw/H8XWS4X7b7MGTEqyDLEEV2H1aGaH1KBOtOY9feCWLsSr1mNjaN1I4zt
 JljKvlmlLdzx2ZiYL9oUi/OIsx4xBYVDpM/Z/GP0Dca+swMhlWhhXODudJBAycQKL4RG
 8ZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fNWFoC3BVYguxhRUMdCWIfb/Rl7MMG8+du2R0BO4wEY=;
 b=QK1Uh0Vho+xJJv/Feb2QmIR0n6kyXrtWkpknfkpNNCxq4XTcey9QNq+7AL7e4JS/u+
 zlRhzUYAJK0QyN2OZrqzvHbweWqmGqZNkwCNk6X1zxA7nljX2mIW5V1UXV5CRz7DiUNA
 9l9RLPXgDuGwS8RdFRdWRUiBeBrXpJBGUBAg0A3B6gmO0rsoIzgVzgGkmMJKkOh1+XVD
 9TysBl93zrCY4gmiBAeUZLKE4zp2C9O6XMqvpWKKLyFtQf7DnEgV0X/Y0ir6g2Im2hay
 EQAQSSeK094O3aduR8mazUWf2qsw/dPWu0dv5Um+6fJKveI6LEf3PYwGGEPszyYwPeAY
 M2gw==
X-Gm-Message-State: AJcUukfb7cQeO/3G5dKS69LahvhRzogNypeqD4W8QMD3LJfVG8XFzkXK
 HfVp/TaSbkAOFp74UoVl9Z6M6g==
X-Google-Smtp-Source: ALg8bN7PbaATt/necB5hsHVmNzRxYe2SlsqLJaqmZdEnsDm4GHzSTuTL0Th3+7/lHl3HDWA40aHnMQ==
X-Received: by 2002:adf:8323:: with SMTP id 32mr21979595wrd.176.1548699209700; 
 Mon, 28 Jan 2019 10:13:29 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
 by smtp.googlemail.com with ESMTPSA id y185sm110654wmg.34.2019.01.28.10.13.28
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Jan 2019 10:13:29 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v2 2/2] reset: meson: add g12a compatible string
Date: Mon, 28 Jan 2019 19:13:15 +0100
Message-Id: <20190128181316.30814-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128181316.30814-1-jbrunet@baylibre.com>
References: <20190128181316.30814-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_101331_514518_8DEB4F08 
X-CRM114-Status: GOOD (  11.96  )
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
Cc: devicetree@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add a compatible for the new g12a SoC family.

Tested-by: Neil Armstrong <narmstrong@baylibre.com>
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
