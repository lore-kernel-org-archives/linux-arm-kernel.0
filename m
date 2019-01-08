Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581A8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:28:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2678720651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QzZ5v4mv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="prSU80XT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2678720651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8o1MPyeuG1KrmxmIFfKYeb3kj6bClhptXX9F2su7ZIk=; b=QzZ5v4mvcBLs8Q
	IuEDmusmZmkHHk3nETQtK8U/n32fiMKIRchCJzS8TRNRqNMKEECvz783m/ncVTQLC6ahd7XnM0UCO
	hcsF9wI1g6wKWrOHZ/qJOOLA264M9J9sF6tYBtb1cNP0xjngBGXwUIrfRiuPTf5OZq86t29j8O6Lh
	ETKW4Bwj4lad1xykeJBASi7bVY7ThitAlUoCUc3TfCewHJii6qjcTWI7jYK5CGdpeyc0m+qkMKTYJ
	NIIPSMp+aLMkLdNrMTsXih1VOzFG3K+t9tPw52OTZ0ZlFk/cLhpOOOxIkkrqzj5UJlCX46fXvjJlL
	weapSqT+ysqBJvd03Wwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggng7-00088D-Os; Tue, 08 Jan 2019 09:28:07 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggnUO-0006xt-Tc
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 09:16:10 +0000
Received: by mail-ed1-x541.google.com with SMTP id y20so3439184edw.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 01:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ztnUf8638FUSA3Znei2oPXxpgrZCrlfwVxJL7f5VqxM=;
 b=prSU80XT5greSTVvVxfOdqS7GZRxlEzsOboNskP7xXdW54w+/BME4EN85MiqNC7ck0
 CwUFThI7MB4Q6ikITGr7in1oMAtOpVJANUCbnae/IBMczruA4tcnj9sZLjZRSUMeI8gz
 LcFm/zxTvdkBW/KLBLcxC8thvjK7MUpb6+XnHYR/UBUhAjr4Q5cNka3oqdobmNxvYfco
 O1jKN5VEYdv/Q7NM8PTUmkmmYZHEzDkMfYB2PAOhKYt3IVtONOmV83soefGatUFWTb1k
 H3HpuNZgNwmGnynLgoSpMZVtCpBODL/ovUuWWuZ6aHQzRcRZYbZ2sQDM7M/O2+4SSNQ6
 uTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ztnUf8638FUSA3Znei2oPXxpgrZCrlfwVxJL7f5VqxM=;
 b=CclCz46H16rILw1m/e9IIv1ne/+oXGiEDyWmpWv37g7RJocAes710HqzRwYI6fVTXm
 SAS7jIgDURvyVHuaj81uVZrbJAE8FWH4nUBibhtsch7uSMUXKL4DmRVXpYNIHT6di31C
 +MN5QflxfT7+Wdue2E8RMQAfgqynDZSge+g2uDsJdCmU1tJt2apNgs/2eZCsIp1cNvw3
 CAGhG0GZC1/nmyp9jVoByFOneX3SqrJFxnGFwTpNrj3fzvWgI3ckKfR2dX+agTCX+L6q
 9g+6HaPhVpoT/K2G5wr6gTpeuxETFiQyq0nQl+rqUTQVD0YNHUgmfaKRpugj+4Dx2TyF
 c8og==
X-Gm-Message-State: AJcUukddFaJCce6ElfCubFhfSv5fs5xI46YyPYoUpKZf206n8utL7Xmo
 /HdxafKLncTGup7rjvA1hWpEsFpvJgbNRw==
X-Google-Smtp-Source: ALg8bN4QFqzh3AdeWeDBlsfg2cR86a//RrCnjhZ5x9WbdegyD1YONe6smD1jiDCacPnVszleRmXT/g==
X-Received: by 2002:a17:906:23f1:: with SMTP id
 j17-v6mr1180789ejg.155.1546938959455; 
 Tue, 08 Jan 2019 01:15:59 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id gp22-v6sm18373560ejb.4.2019.01.08.01.15.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Jan 2019 01:15:58 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RESEND PATCH 08/12] ARM: davinci: sffsdr: use device properties for
 at24 eeprom
Date: Tue,  8 Jan 2019 10:15:35 +0100
Message-Id: <20190108091539.16674-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108091539.16674-1-brgl@bgdev.pl>
References: <20190108091539.16674-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_011601_473913_FEAC34F0 
X-CRM114-Status: GOOD (  13.03  )
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
 arch/arm/mach-davinci/board-sffsdr.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
index acd9778ffa07..ff14de1396c8 100644
--- a/arch/arm/mach-davinci/board-sffsdr.c
+++ b/arch/arm/mach-davinci/board-sffsdr.c
@@ -26,7 +26,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
-#include <linux/platform_data/at24.h>
+#include <linux/property.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
@@ -92,16 +92,15 @@ static struct platform_device davinci_sffsdr_nandflash_device = {
 	.resource	= davinci_sffsdr_nandflash_resource,
 };
 
-static struct at24_platform_data eeprom_info = {
-	.byte_len	= (64*1024) / 8,
-	.page_size	= 32,
-	.flags		= AT24_FLAG_ADDR16,
+static const struct property_entry eeprom_properties[] = {
+	PROPERTY_ENTRY_U32("pagesize", 32),
+	{ }
 };
 
 static struct i2c_board_info __initdata i2c_info[] =  {
 	{
 		I2C_BOARD_INFO("24c64", 0x50),
-		.platform_data	= &eeprom_info,
+		.properties = eeprom_properties,
 	},
 	/* Other I2C devices:
 	 * MSP430,  addr 0x23 (not used)
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
