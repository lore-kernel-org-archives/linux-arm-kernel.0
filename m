Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25A7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:17:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FDDB2089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Om94nsM7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="t/6BSrAC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FDDB2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kurp9JMaJh0Rbe/O45wpE3nSxQgrnusFC0h17qfu7kQ=; b=Om94nsM78KPaAs
	WBY6JsP+IdiJwHICVZsNYBLnFroIq+HyMbbsQEiWw+Fi0tsd8MUyZCuQYj7lH8guK7NjMYODxqUY4
	fhR0dy8hhfBV23o7ek6ZkTEY+FS8MJOSQH8/JvGzt0z1ZXIJwyvOFJk1e4m1qds5TQmfYsKmyjpkB
	g1Cdgz053yrfE4Fln7r0zd62PJzzARVoWxV2arkmJEk9SgfS6vwpZ+djRJ5+VOPMMDkfpgaX8MFfR
	zONnxh6y5YWhTU5fVmNzfPhuTQQvbd1AVm61dKnTqcALy/vqnvxiny0v63UO94UBecz9WbadBuuT8
	8U+jVlu1/I4vtgGFe5Aw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggnVZ-0008E3-9t; Tue, 08 Jan 2019 09:17:13 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggnUK-0006sv-TE
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 09:16:01 +0000
Received: by mail-ed1-x544.google.com with SMTP id y20so3439003edw.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 01:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NtdPGnoNcOA+uAMeykOlFvJi5M25GSj2otU8Jlp5mq4=;
 b=t/6BSrACMpojsU1VWdUposfrHgGClFWcP71qT2s+vhPd/29df5n7Ij1XEIkIpX3trL
 Ng0MgVNjxdG8ubvZUNa5zZLkG5dheBnqizItOOhgONxNx/eyS9KTcjKDTeANVeRPf6UO
 zJMQmr/kkrSCSqcLoqc6J5iPa83k2FKKpUaRPVsmLDK1VnY2wx4fCVi2/l3E15nwXem4
 q9K6APrr05FYA/HC093TIqL6BiD0WWAuCYBcfsDPC/qaF+wCBvs4uTjCvX7BDzSq1wn8
 afdElkXMePx1AXpaQ9JW0FsxZUUJM4Q1znYXW8A0gCDU/LIzplp2S240APmLJjWaGBl0
 M/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NtdPGnoNcOA+uAMeykOlFvJi5M25GSj2otU8Jlp5mq4=;
 b=lN0GwIe/INIs8rMmpzb5OPk/CczoUxNk9dx7ROhNw8+I4RZMQSEiSV+1kRm+nSOxEp
 I9ZVOliPFTdJRzFFW4qrK+lph89pl2unRL6SknpmgWqCML+EOhR/d/pfQKZsVqMgeSPO
 b7NO4BbhyKTssApRPgXJEcW/uVsOdV8Dc84fNvb2h3bhjEEc01IbVJFf1ABjy+1f1lvG
 GRRRdP22JExduhdfXLN0Y/u8gkHVjK8rH93GqgUo40fFNQDqBrKCH58uhhHRnMybGNxb
 XPoPNKGJC4T6fpdxdcMxvHZHxxydIrgPwvGoeT4SGhaoLFlaX5l5h43FgZB2PKKJxXoA
 h3Aw==
X-Gm-Message-State: AJcUukel5Lq04XjfcyCWg6TZsAKrFGeMsXVhPi9d1lJVFo/0HrJXXKiy
 bgt5ox1KoKmXlamhYZhN7gCk1g==
X-Google-Smtp-Source: ALg8bN6piq7qJ+WWVxnfv6jG2DOxdEePGwG+y2iIZUUo5LaSwZYTsK5Ajo1QMxe2Al6D7q6w0wW7Eg==
X-Received: by 2002:a50:f5af:: with SMTP id u44mr1351249edm.172.1546938955234; 
 Tue, 08 Jan 2019 01:15:55 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id gp22-v6sm18373560ejb.4.2019.01.08.01.15.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Jan 2019 01:15:54 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RESEND PATCH 05/12] ARM: davinci: dm644x-evm: use device properties
 for at24 eeprom
Date: Tue,  8 Jan 2019 10:15:32 +0100
Message-Id: <20190108091539.16674-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108091539.16674-1-brgl@bgdev.pl>
References: <20190108091539.16674-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_011557_156837_71595ECB 
X-CRM114-Status: GOOD (  13.49  )
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
 arch/arm/mach-davinci/board-dm644x-evm.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index e1428115067f..efe4e170e87d 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -16,8 +16,8 @@
 #include <linux/gpio/machine.h>
 #include <linux/i2c.h>
 #include <linux/platform_data/pcf857x.h>
-#include <linux/platform_data/at24.h>
 #include <linux/platform_data/gpio-davinci.h>
+#include <linux/property.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
@@ -532,12 +532,9 @@ static struct nvmem_cell_lookup dm644evm_nvmem_cell_lookup = {
 	.con_id		= "mac-address",
 };
 
-static struct at24_platform_data eeprom_info = {
-	.byte_len	= (256*1024) / 8,
-	.page_size	= 64,
-	.flags		= AT24_FLAG_ADDR16,
-	.setup          = davinci_get_mac_addr,
-	.context	= (void *)0x7f00,
+static const struct property_entry eeprom_properties[] = {
+	PROPERTY_ENTRY_U32("pagesize", 64),
+	{ }
 };
 
 /*
@@ -647,7 +644,7 @@ static struct i2c_board_info __initdata i2c_info[] =  {
 	},
 	{
 		I2C_BOARD_INFO("24c256", 0x50),
-		.platform_data	= &eeprom_info,
+		.properties = eeprom_properties,
 	},
 	{
 		I2C_BOARD_INFO("tlv320aic33", 0x1b),
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
