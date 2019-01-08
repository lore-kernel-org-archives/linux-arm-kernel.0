Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E4AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:18:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7EE22089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u2he/A4z";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Fu/QOCWK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7EE22089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oCDyH1DkHPIm9ycf859ayXPk3jUWoautsSv/1IgdEzM=; b=u2he/A4zftfsBx
	EyChFydCzY4MPUwvlargu0I6oPVOVnQn+Sy6ypCCkFHKko94vFwsV+ADGH1K9sMpN0oJrObuTh+xa
	xD1XGhuiLjQYLn5BjkJDnnjc2cQbl/Y2XDoQhDPVA4Ii7/s12VWza6KqHpxwdXyvVS11sYUHpGM11
	dng1QDjs3MIE7crQhSTyeDxtzBuNGKMRno9ddmS3tQmjj3Spax9kHs3SdLmFVn4JbGCVFVonztJIW
	/sQHsTtDl/CLpEveQv1lSjkcsW73XIhPNVT7Sv4VZDT+pdRa7LbDBb7d3/hLlI2juPBq3iX7MXxY/
	xqYJI4RSNkwqfHmsA1HQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggnWa-0000sg-D8; Tue, 08 Jan 2019 09:18:16 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggnUS-00072R-TC
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 09:16:15 +0000
Received: by mail-ed1-x542.google.com with SMTP id a20so3450403edc.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 01:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oXTGXgrClMlW8LabyP51oPTHLt1d9TPP5bN7Oy9yaTQ=;
 b=Fu/QOCWKaQzM2CCroguKhoRNbbqYVmumF4ev4NEHPxj7T/7yCHXXnkIVLB0hTrpukK
 1t11LaomRucyU3qot62gzR0r9TZZAHscsL5atPEX+Ngqsj+xzuykuNkXPZjkVK/v8G5Y
 om0lBoJtgLINU53aB9oSllH3KUr19uT2CCGKp/LG0OGrXa4ermeZ20jhiKjrNcTx4FNA
 LD7MyuFMtLpw3w1vFGKSxd7Rr33nRYgCx5IhtvRzoO01e1RWawuVvfIB5XQdmxnwnmrh
 VPwt672T7X0qIPlvqwPHVNUTKby3uuhKSV5l5RP2Xrr7hGCChClmb/wgHw1bbWNJkxnJ
 mUKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oXTGXgrClMlW8LabyP51oPTHLt1d9TPP5bN7Oy9yaTQ=;
 b=Ri+CeukKAv72Ped4C6oUwaqMnpCxSKLW0iSP1fR3vogqVyu+U5BR4xk/3A57C/a6UT
 BbQozS0WmgYmCBHRX/H8H+4yBJMoYHgrrAeZ10Le1rryM9zUAuSLbvQCNrjDxvzhNW9d
 f/n/Usqe8B1OgGtwJmxwxgc8fdM7ZrRel/A6P+369aaGw6g/q8wfpBSxdHcSHLd5NRRn
 B7/o7ymgn/fwFRiWg7YWyHcumonsZMbUiAQvTskroh54Fjk6w2e2INebcPkZqCSNr270
 BNnodOEcdK0PAScOLethSEFLSt/gS1YqaeYrcAd8JPwkKAgLKeTGf/3YZ4VWbkOzcDTW
 44Uw==
X-Gm-Message-State: AJcUukfb8r7JRWpUT6+Rv1ykfstxwqXbP3/BCplmmRLk9OYRcF+SxZSd
 xvhbgl4sKvr2gCZbZorm+T2GDQ==
X-Google-Smtp-Source: ALg8bN4Y0hzLVqHt9UX4a4qUt7Jtxi/praTdrf7KUCraeBLgRDkxBBiK7c3f5PBwTWZwlNSO4TE2yw==
X-Received: by 2002:aa7:de06:: with SMTP id h6mr1274531edv.137.1546938963541; 
 Tue, 08 Jan 2019 01:16:03 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id gp22-v6sm18373560ejb.4.2019.01.08.01.16.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Jan 2019 01:16:03 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RESEND PATCH 11/12] ARM: davinci: mityomapl138: use device
 properties for at24 eeprom
Date: Tue,  8 Jan 2019 10:15:38 +0100
Message-Id: <20190108091539.16674-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108091539.16674-1-brgl@bgdev.pl>
References: <20190108091539.16674-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_011606_027263_A6209CDF 
X-CRM114-Status: GOOD (  13.24  )
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
---
 arch/arm/mach-davinci/board-mityomapl138.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index ac1a1699d185..a381b26328d8 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -14,13 +14,13 @@
 #include <linux/init.h>
 #include <linux/console.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/mtd/partitions.h>
 #include <linux/notifier.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/nvmem-provider.h>
 #include <linux/regulator/machine.h>
 #include <linux/i2c.h>
-#include <linux/platform_data/at24.h>
 #include <linux/etherdevice.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/flash.h>
@@ -192,10 +192,10 @@ static struct nvmem_cell_lookup mityomapl138_nvmem_cell_lookup = {
 	.con_id		= "mac-address",
 };
 
-static struct at24_platform_data mityomapl138_fd_chip = {
-	.byte_len	= 256,
-	.page_size	= 8,
-	.flags		= AT24_FLAG_READONLY | AT24_FLAG_IRUGO,
+static const struct property_entry mityomapl138_fd_chip_properties[] = {
+	PROPERTY_ENTRY_U32("pagesize", 8),
+	PROPERTY_ENTRY_BOOL("read-only"),
+	{ }
 };
 
 static struct davinci_i2c_platform_data mityomap_i2c_0_pdata = {
@@ -324,7 +324,7 @@ static struct i2c_board_info __initdata mityomap_tps65023_info[] = {
 	},
 	{
 		I2C_BOARD_INFO("24c02", 0x50),
-		.platform_data = &mityomapl138_fd_chip,
+		.properties = mityomapl138_fd_chip_properties,
 	},
 };
 
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
