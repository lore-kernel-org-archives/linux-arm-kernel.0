Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3195C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:17:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83D252089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cSMxEkPQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="SkoiwJ7m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D252089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PBhkTvIOigkr7cf8rmvH+ZbjrYKqcWK6vBlngWqipec=; b=cSMxEkPQKSv/Kb
	k4Y1VNbe6h0BjT3OBqv4EDQyH/1+3ZCGlE2W3xHBh+qI4XxjPDyvwp4hNHUJoVPRh79F9eZ+1o+cu
	0kBKllmwgJv3mM2k0hSHixyYNzwWwaWCqLAZ1X9Qk8wCR/FAnfkalOpvrDOk8xDlL1jqN8v2ajagC
	011rqJt7XYj+uG1jFaUSCHACI76EDEHFPGrTh1egqph4vttoOzd2ph7qyr2zhQ0CwTwnmT9LK/yDn
	vGmU4YWQK9WBFOPSvi8532qszHgArzcWIR2sO3g1XF4wMBIwrUkeIb7nBYN8w/+Zb8+ZzPRRHrXF6
	L4a1AO6JKeMx3ldkpzUg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggnVm-0008SW-U6; Tue, 08 Jan 2019 09:17:26 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggnUL-0006to-Nr
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 09:16:02 +0000
Received: by mail-ed1-x543.google.com with SMTP id x30so3485314edx.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 01:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hh5b2k/7h0Wkn2rLn6NIi7mvwMbeZ/cPsG4EAD277Kg=;
 b=SkoiwJ7mSICbm05UcVobOCupwPj7xv1ZeuUR0Khw9wxNITzWgKNtdimlgv7XTUWAis
 2ugNlNJEvdY9KG5yJ9922gDbYhSWs5Nz0ghJwbYqrg2Y51kMeueMvewtjf1UVBc8gaWc
 M4VV7MPIDiv95So++iXt/5Dlv1ec3R0cYyZeRKB4nPJUSFcz5c6891WOdCbX42Oo42lo
 p5NvKyBdNhLXTJNFUR+eNNVOkNn6R4yORHZIhX9d+EqjcR3mWEdymo0ZNxDztspCSXxF
 XB3wFSYErdZYf/WSdhYwIE59inECFrbHcoMCxrrsWjLlcYfiLOIZCDifDpUgJXcVORKn
 bsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hh5b2k/7h0Wkn2rLn6NIi7mvwMbeZ/cPsG4EAD277Kg=;
 b=AQUZ56hDZpNtJdWo0wH+nYzHCkPHn5xgebs9MfSEATijXrC0kUHi+nwV7xUgubcc3a
 /0V34poNH8L9NL/gWine3WS2xeUrB6ypW/Mnp3HHxiLkU/LkuEnfrHXKy7ZaaMfNIe+f
 EMxz8j0/uFptrLOIpf7F3zBUDHlGKP0+TqV8kMpJb7RJ4rbI0nEKMrhbNkWkPgc60bze
 yPQDQpNAfJGZTmQfaXDpviIfzDZZrl5yGgpokLtn4ZzJYv7v1iJTB9iqQ6PX2Reen26d
 7JEZv1xP+XZ0DK9+hbEAJ5X/yzw6jAMFhoyMGPRv2LpZ3HAvwOsWnaSGw0Zv45jH0i8F
 Kr5w==
X-Gm-Message-State: AJcUukfwQaosqM36+m6/RC4//GaI5jTUFeJiRUMwSIKMCSnrdRx/kWrb
 kLz6hmjX+wa6ALGFKNHznA5W7nZUUdNM5g==
X-Google-Smtp-Source: ALg8bN5F3/ZKizjRyhig9R6zB1qpI+G0nZ57edJzgP5cBXVtwrjxKMkPImYuXsbq4gITuBWf0HljYg==
X-Received: by 2002:a50:ad55:: with SMTP id z21mr1310568edc.74.1546938956451; 
 Tue, 08 Jan 2019 01:15:56 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id gp22-v6sm18373560ejb.4.2019.01.08.01.15.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Jan 2019 01:15:55 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RESEND PATCH 06/12] ARM: davinci: dm646x-evm: use device properties
 for at24 eeprom
Date: Tue,  8 Jan 2019 10:15:33 +0100
Message-Id: <20190108091539.16674-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108091539.16674-1-brgl@bgdev.pl>
References: <20190108091539.16674-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_011558_192587_EEB7E4A5 
X-CRM114-Status: GOOD (  13.42  )
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

We want to work towards phasing out the at24_platform_data structure.
There are few users and its contents can be represented using generic
device properties. Using device properties only will allow us to
significantly simplify the at24 configuration code.

Remove the at24_platform_data structure and replace it with an array
of property entries. Drop the byte_len/size property, as the model name
already implies the EEPROM's size.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 arch/arm/mach-davinci/board-dm646x-evm.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 8d5be6dd2019..02b57face113 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -22,7 +22,7 @@
 #include <linux/gpio.h>
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
-#include <linux/platform_data/at24.h>
+#include <linux/property.h>
 #include <linux/platform_data/pcf857x.h>
 #include <linux/platform_data/ti-aemif.h>
 
@@ -364,12 +364,9 @@ static struct nvmem_cell_lookup dm646x_evm_nvmem_cell_lookup = {
 	.con_id		= "mac-address",
 };
 
-static struct at24_platform_data eeprom_info = {
-	.byte_len       = (256*1024) / 8,
-	.page_size      = 64,
-	.flags          = AT24_FLAG_ADDR16,
-	.setup          = davinci_get_mac_addr,
-	.context	= (void *)0x7f00,
+static const struct property_entry eeprom_properties[] = {
+	PROPERTY_ENTRY_U32("pagesize", 64),
+	{ }
 };
 #endif
 
@@ -440,7 +437,7 @@ static void evm_init_cpld(void)
 static struct i2c_board_info __initdata i2c_info[] =  {
 	{
 		I2C_BOARD_INFO("24c256", 0x50),
-		.platform_data  = &eeprom_info,
+		.properties  = eeprom_properties,
 	},
 	{
 		I2C_BOARD_INFO("pcf8574a", 0x38),
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
