Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11F7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:18:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB1282087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RK2RltsW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="vL1UmvsI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB1282087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kmN1HnpQgbOygc7YUcUiMCrITFdQZow3iajHsOYfi3c=; b=RK2RltsW380HMp
	ZV07/c9xUF/tWrcJiGR6A4kILXne2eTieuSILxhfkKvkAorcTE59+9DFdP09qzsrB6m0GLKlJG1hm
	CpP4Vch+Pq+CRU5V4YQ/BS7VDxl2BKerJB0aEw1IZ4S158QRtwHhBg7dX5wIYOSkkQOAfmjenqTUf
	KV/kNSDQHgGvLCB67M5osqqcGabNujasKJXg1bd0V4455Ulr1GcXmbLFYAsg5iA+MY7SoK904Hacm
	jJdrEPPna47ZsCZMJaTqpATgGoDXQfJi1KJWvCLBnqrBB4xQ+/i5QaPmSgEX4NZXyY3vEar5JY/Ji
	fBXBMQ7XJhH86IFxutOw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggnWF-0000Vw-8x; Tue, 08 Jan 2019 09:17:55 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggnUQ-0006zE-4r
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 09:16:09 +0000
Received: by mail-ed1-x541.google.com with SMTP id p6so3498505eds.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 01:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+MhstBAWAWTvjV+7n2ZSuyCNluyXHXlSjobSaNP/M+U=;
 b=vL1UmvsIz4oOviOGu+y+fZ41BRFcWkeVgw9i9KziXEqHwOil6iPVYRonWegCiwd+DN
 ggp5Yl4L2DeT0q/ObFz5IXAfU8oaOaUcUouHk7h8AKxnZwimoYHKMDf2tgDMvqiKgeua
 eszgwAtSq7jr148OK9Aq39mMTNgIzfzrnNWXaag5g93ov+7s9SQCtIClM+SL4X9Mgast
 KrLIH7CEnEbrPE+ZFfRXiu6I6C/FjCMRclkUdoNLyDs4XKIgwo9l7WqUjN7DpKBHV+I0
 N4CMvD1OxojhZG1GzkfQn+ofpUZF5bkMK7Ae8yBMjXkjF9hBikyiKtVnzeELun3TPDkZ
 nzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+MhstBAWAWTvjV+7n2ZSuyCNluyXHXlSjobSaNP/M+U=;
 b=Sx6bAWkqHlf5vV/nDGkngY/DluRB3QsL3VLDt8CaLCVZkpu5xi5te1P0vL46GAbrdx
 0MP6KW7rv/6H0PPy25G0bbpRFZI21xNbgDJcXk1tVWrek0cP1GIsjgIMaKCFoWhJOSnj
 GMBF3g1wG0lnvP0W9lOAXRVmYOBNQolAsboQkzLT0tYerPXQ2V3q8OZqcFHhb4eu9fFf
 KAnCd1MvuDnVQunGuSKAyrjwoNlzoXnrnNy6c45zdv6fYWM1MEIXMkQ+hfVd+r/ng2qX
 qhkf+OQof3kd/MUC3Sd98a1X0E+qciOrwFKMdl097oLsdEjJmxhYSKtN7GRcGFQBIPYW
 6gsA==
X-Gm-Message-State: AJcUuke80uqWbpzoP5zeg178DTUmSDsWQYPfah+Q7f5EBrAXDaRiq3ZH
 HW8/rMhGwzWwpd0d68uu+afcMQ==
X-Google-Smtp-Source: ALg8bN7pp63gp0stxuU86/Ef5iHXUkzmZWnGk4PKZKPUyEmf6QzJY8UES63OULT/yDjVEWpIiz4QKA==
X-Received: by 2002:a17:906:32c6:: with SMTP id
 k6-v6mr1199646ejk.48.1546938960756; 
 Tue, 08 Jan 2019 01:16:00 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id gp22-v6sm18373560ejb.4.2019.01.08.01.15.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Jan 2019 01:16:00 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RESEND PATCH 09/12] ARM: davinci: remove dead code related to MAC
 address reading
Date: Tue,  8 Jan 2019 10:15:36 +0100
Message-Id: <20190108091539.16674-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108091539.16674-1-brgl@bgdev.pl>
References: <20190108091539.16674-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_011602_892057_FBEF66E6 
X-CRM114-Status: GOOD (  11.66  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

There are no more users of davinci_get_mac_addr(). Remove it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/common.c | 15 ---------------
 include/linux/davinci_emac.h   |  1 -
 2 files changed, 16 deletions(-)

diff --git a/arch/arm/mach-davinci/common.c b/arch/arm/mach-davinci/common.c
index e1d0f0d841ff..0c638fe15dcb 100644
--- a/arch/arm/mach-davinci/common.c
+++ b/arch/arm/mach-davinci/common.c
@@ -26,21 +26,6 @@ EXPORT_SYMBOL(davinci_soc_info);
 void __iomem *davinci_intc_base;
 int davinci_intc_type;
 
-void davinci_get_mac_addr(struct nvmem_device *nvmem, void *context)
-{
-	char *mac_addr = davinci_soc_info.emac_pdata->mac_addr;
-	off_t offset = (off_t)context;
-
-	if (!IS_BUILTIN(CONFIG_NVMEM)) {
-		pr_warn("Cannot read MAC addr from EEPROM without CONFIG_NVMEM\n");
-		return;
-	}
-
-	/* Read MAC addr from EEPROM */
-	if (nvmem_device_read(nvmem, offset, ETH_ALEN, mac_addr) == ETH_ALEN)
-		pr_info("Read MAC addr from EEPROM: %pM\n", mac_addr);
-}
-
 static int __init davinci_init_id(struct davinci_soc_info *soc_info)
 {
 	int			i;
diff --git a/include/linux/davinci_emac.h b/include/linux/davinci_emac.h
index 05b97144d342..28e6cf1356da 100644
--- a/include/linux/davinci_emac.h
+++ b/include/linux/davinci_emac.h
@@ -46,5 +46,4 @@ enum {
 	EMAC_VERSION_2,	/* DM646x */
 };
 
-void davinci_get_mac_addr(struct nvmem_device *nvmem, void *context);
 #endif
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
