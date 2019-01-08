Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5549C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:16:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E64A2089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iZm1no1h";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="VCmoxz1p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E64A2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+ah58tc1mKnrEgBa5dEXZfZS/lHNzz7FnWkdgwad4QQ=; b=iZm1no1h1OpgDH
	TnhiE80T0pUmEPSB2xNB7wTcazKsfiV0mwCVUsVjwZTFp+d5EgcCYOnp15wcvhg6/ibU7Y77ZSNdw
	36PjYnS09FMAdDrmwTOW6B5PrcYQ2iIYuqAHErE/Lxh+ygrm04fLbmJQx0TICTdKRAMZWBdO6lZPl
	pdIlNjil24URpDbDBGlNoAhjbPqMp8elJHSeFIvk57mVqlzV7TPbKXmBgrNDJlzSKkRpQ0RmHi/g2
	WlDpz9+uUqFxJlObRAw1WOcTMEjykhrsHXpS+02dGua9p4SnYeHMXflvOuGkkxiDvtlMYn2dD7T/q
	T85mmYwmCy3wIn6d+vFw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggnUV-00073N-Ca; Tue, 08 Jan 2019 09:16:07 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggnUF-0006qw-15
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 09:15:53 +0000
Received: by mail-ed1-x541.google.com with SMTP id f9so3431085eds.10
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 01:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OoIJe4mIDvTgdZuFApCm4Rth6o5WcRAhu1RpXcDbEn4=;
 b=VCmoxz1pe8h/sCGOr3KE6kn1KAUvQMv/IMN3cHZ8CxFJAX8ZoYfa9qdzywShv+V5AQ
 hr+JNNFpfcD28S2hAGOhUjsLvRJuVvrtJOpd5LGTjDA1bKeeCqVaJ0Lb/L4rGRz4QQdw
 Nnf4YQzeACIcW2byxB59y0Tt8VlZCI7yiOKAJv+3S2ouyuInFPMwWUvBAk29+AN6scWd
 Xch8QI5vrJumKZBKZQSaeUoZcibSLEXPDx5JBwxU9IbaBVyE0qh5mA+mHi89wWWHzJTR
 AUPz3k40FqCfQRdMH2XpnNkyKpKzuTYkP2891kux7HXVs/KpeB2rEhqx6SxHuIrK/RUR
 FvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OoIJe4mIDvTgdZuFApCm4Rth6o5WcRAhu1RpXcDbEn4=;
 b=t+Ftv4A5ux/cWxzUOC9X7TCxUS1cwHLgrRuw3E3yzGDZKOygAdfW9YnI+UKU06oORr
 8yS+fZ3KZzMU9STPydw5BSgzXxCEM9dwbKEY8RpinKufB6921p1AfIxikO4WqNgSxEJP
 J5T/3Ib+mrCPkqO0vKJqLStYZXXY1iWAOC6OrKtn0bNLhdX48uA+/zc3sV65ivHBE+AJ
 U6wbdWWHwksKhzX+if27PB1CZWFPWTpYKCwcGJpng3EOBxwhGfpomVvWeUI/zdFXlM6R
 no3oxoqhwwYV21WylTU9iDf/4prftLyxZkCWcPE0T+jUehSCdw72XtJmbJba8fC04HG/
 DG2g==
X-Gm-Message-State: AJcUukfGi0GgdM7F4wlUIkOaVs+dNyCPwhJvOOPHqP3ai3YWkFCOIySi
 AKy35tYw6LS0qD9l4lg/u74plQ==
X-Google-Smtp-Source: ALg8bN6BNPITbKOv3XPbcz4zSiBIE8OsOtEPb3ekrVlDBVJmvPxw0z+AOWIBPhXi1Gs7Z11GOelnQw==
X-Received: by 2002:a50:b3c9:: with SMTP id t9mr1314567edd.270.1546938949770; 
 Tue, 08 Jan 2019 01:15:49 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id gp22-v6sm18373560ejb.4.2019.01.08.01.15.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Jan 2019 01:15:49 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RESEND PATCH 01/12] ARM: davinci: da850-evm: remove dead MTD code
Date: Tue,  8 Jan 2019 10:15:28 +0100
Message-Id: <20190108091539.16674-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108091539.16674-1-brgl@bgdev.pl>
References: <20190108091539.16674-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_011551_105282_E985AC78 
X-CRM114-Status: GOOD (  11.86  )
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

We no longer need to register the MTD notifier to read the MAC address
as it's now being done in the emac driver.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-da850-evm.c | 28 -------------------------
 1 file changed, 28 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 6a29baf0a289..128dd7d8dff6 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -150,32 +150,6 @@ static struct spi_board_info da850evm_spi_info[] = {
 	},
 };
 
-#ifdef CONFIG_MTD
-static void da850_evm_m25p80_notify_add(struct mtd_info *mtd)
-{
-	char *mac_addr = davinci_soc_info.emac_pdata->mac_addr;
-	size_t retlen;
-
-	if (!strcmp(mtd->name, "MAC-Address")) {
-		mtd_read(mtd, 0, ETH_ALEN, &retlen, mac_addr);
-		if (retlen == ETH_ALEN)
-			pr_info("Read MAC addr from SPI Flash: %pM\n",
-				mac_addr);
-	}
-}
-
-static struct mtd_notifier da850evm_spi_notifier = {
-	.add	= da850_evm_m25p80_notify_add,
-};
-
-static void da850_evm_setup_mac_addr(void)
-{
-	register_mtd_user(&da850evm_spi_notifier);
-}
-#else
-static void da850_evm_setup_mac_addr(void) { }
-#endif
-
 static struct mtd_partition da850_evm_norflash_partition[] = {
 	{
 		.name           = "bootloaders + env",
@@ -1494,8 +1468,6 @@ static __init void da850_evm_init(void)
 	if (ret)
 		pr_warn("%s: SATA registration failed: %d\n", __func__, ret);
 
-	da850_evm_setup_mac_addr();
-
 	ret = da8xx_register_rproc();
 	if (ret)
 		pr_warn("%s: dsp/rproc registration failed: %d\n",
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
